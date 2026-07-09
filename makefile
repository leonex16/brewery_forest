# Brewery Forest - developer commands. Run `make` (or `make help`) to list them.

.DEFAULT_GOAL := help

# ─── Config ───────────────────────────────────────────────────────────────────
# Resolve adb from PATH, falling back to the default macOS SDK location.
ADB ?= $(shell command -v adb 2>/dev/null || echo $(HOME)/Library/Android/sdk/platform-tools/adb)
MAESTRO_DIR := maestro

# PLATFORM selects which OS install/e2e targets act on: Android (default) or
# iOS (case-sensitive - matches Maestro's own --platform values exactly).
# DEVICE optionally pins one emulator/simulator UDID when more than one is
# connected (`maestro list-devices` / `flutter devices` to find it).
PLATFORM ?= Android
DEVICE ?=
# Flutter wants "-d <id>"; Maestro wants "--device=<id>" - same DEVICE, two flags.
FLUTTER_DEVICE_FLAG := $(if $(DEVICE),-d $(DEVICE),)
MAESTRO_DEVICE_FLAG := $(if $(DEVICE),--device=$(DEVICE),)

# production.json carries the required Mapbox token (the app crashes at launch without it).
ENV_FILE := env/production.json

# Store screenshots (Maestro -> Fastlane metadata).
SHOTS_LOCALE ?= en-US
SHOTS_OUT := $(MAESTRO_DIR)/screenshots/out
SHOTS_IMG := android/fastlane/metadata/android/$(SHOTS_LOCALE)/images

.PHONY: help codegen codegen-watch analyze install-debug install-release \
        build-appbundle e2e-setup e2e e2e-smoke e2e-report \
        demo demo-reset demo-record screenshots \
        format format-check fix fix-dry lint tidy

help: ## List available commands
	@awk '/^##@ /{printf "\n%s\n", substr($$0,5)} /^[a-zA-Z0-9_-]+:.*## /{t=$$0; sub(/:.*/,"",t); n=index($$0,"## "); printf "  %-18s %s\n", t, substr($$0,n+3)}' $(MAKEFILE_LIST)

##@ Code generation (build_runner: injectable, freezed, json, l10n)
codegen: ## Generate code once
	dart run build_runner build

codegen-watch: ## Regenerate on every file change
	dart run build_runner watch

##@ Quality
analyze: ## Run static analysis over lib/
	dart analyze lib

##@ Code quality / formatting
format: ## Format lib/ and test/
	dart format lib test

format-check: ## Fail if lib/ or test/ have unformatted files (CI)
	dart format --output=none --set-exit-if-changed lib test

fix: ## Apply automated lint fixes
	dart fix --apply

fix-dry: ## Preview automated lint fixes without applying them
	dart fix --dry-run

lint: ## Run static analysis over the whole project (complements analyze)
	dart analyze

tidy: ## Apply lint fixes then format lib/ and test/
	dart fix --apply
	dart format lib test

##@ Run locally
run-debug: ## Run the debug APK
	flutter run --dart-define-from-file=env/local.json

run-release: ## Run the release APK
	flutter run --dart-define-from-file=env/production.json

##@ Build & install (onto a connected Android device/emulator, or PLATFORM=iOS for a Simulator)
install-debug: ## Build + install the debug build (PLATFORM=iOS to target a Simulator instead)
ifeq ($(PLATFORM),iOS)
	flutter build ios --simulator --debug --dart-define-from-file=$(ENV_FILE)
	flutter install $(FLUTTER_DEVICE_FLAG)
else
	flutter build apk --debug --dart-define-from-file=$(ENV_FILE)
	$(ADB) install -r build/app/outputs/flutter-apk/app-debug.apk
endif

install-release: ## Build + install the release build (PLATFORM=iOS to target a Simulator instead)
ifeq ($(PLATFORM),iOS)
	flutter build ios --simulator --release --dart-define-from-file=$(ENV_FILE)
	flutter install $(FLUTTER_DEVICE_FLAG)
else
	flutter build apk --release --dart-define-from-file=$(ENV_FILE)
	$(ADB) install -r build/app/outputs/flutter-apk/app-release.apk
endif

##@ Release (Play Store artifact)
build-appbundle: ## Build the release .aab for the Play Store, then reveal it in Finder
	flutter build appbundle --release --dart-define-from-file=$(ENV_FILE)
	open build/app/outputs/bundle/release

##@ E2E tests (Maestro - Android by default; PLATFORM=iOS to target a Simulator)
# iOS needs its own permission vocabulary: `permissions.location: allow/deny`
# (Android's) isn't a valid value on iOS, which wants always/inuse/never/unset
# - every flow that sets this now branches on `runFlow: when: platform:` so
# each OS gets its own value. iOS also needs NSLocationWhenInUseUsageDescription
# in ios/Runner/Info.plist (added) - without it, iOS silently refuses any
# location authorization request, no matter what Maestro or `simctl privacy`
# pre-grants at the TCC level; that's what looked like a Maestro bug at first.
# 16/16 pass on iOS with both fixes in place. The android-only-tagged flows
# (080, 090, 140, 150, 160 - anything needing setAirplaneMode, which has no
# effect on iOS Simulators) already self-guard with `runFlow: when: platform:
# Android` and simply no-op on iOS.
e2e-setup: ## One-time device prep (Android: disable animations + accept location consent; no-op on iOS today)
ifeq ($(PLATFORM),iOS)
	@echo "PLATFORM=iOS: no one-time device prep implemented yet (see e2e-setup's comment above)."
else
	$(ADB) shell settings put global window_animation_scale 0
	$(ADB) shell settings put global transition_animation_scale 0
	$(ADB) shell settings put global animator_duration_scale 0
	maestro test $(MAESTRO_DEVICE_FLAG) $(MAESTRO_DIR)/subflows/accept_location_consent.yaml
endif

e2e: ## Run the full e2e suite (PLATFORM=iOS to target a Simulator)
	maestro test --platform=$(PLATFORM) $(MAESTRO_DEVICE_FLAG) $(MAESTRO_DIR)

e2e-smoke: ## Run only smoke-tagged flows (PLATFORM=iOS to target a Simulator)
	maestro test --platform=$(PLATFORM) $(MAESTRO_DEVICE_FLAG) $(MAESTRO_DIR) --include-tags smoke

e2e-report: ## Run the suite and emit an HTML report (PLATFORM=iOS to target a Simulator)
	maestro test --platform=$(PLATFORM) $(MAESTRO_DEVICE_FLAG) $(MAESTRO_DIR) --format HTML-DETAILED --output maestro-report

##@ Demo (narrated walkthrough, kept out of the suite)
demo: ## Run the demo flows with slowed animations
	$(ADB) shell settings put global window_animation_scale 1.5
	$(ADB) shell settings put global transition_animation_scale 1.5
	$(ADB) shell settings put global animator_duration_scale 1.5
	maestro test $(MAESTRO_DIR)/demo/010_walkthrough.yaml
	maestro test $(MAESTRO_DIR)/demo/020_ip_location.yaml

demo-reset: ## Restore instant animations after a demo
	$(ADB) shell settings put global window_animation_scale 0
	$(ADB) shell settings put global transition_animation_scale 0
	$(ADB) shell settings put global animator_duration_scale 0

demo-record: ## Record the walkthrough to walkthrough.mp4
	maestro record --local $(MAESTRO_DIR)/demo/010_walkthrough.yaml walkthrough.mp4

##@ Store screenshots (Maestro -> Fastlane metadata)
# Phone-only, portrait app -> reuse the same shots for 7" and 10".
screenshots: ## Capture store screenshots into the Fastlane structure
	mkdir -p $(SHOTS_OUT) $(SHOTS_IMG)/phoneScreenshots $(SHOTS_IMG)/sevenInchScreenshots $(SHOTS_IMG)/tenInchScreenshots
	maestro test -e OUTPUT_DIR=$(CURDIR)/$(SHOTS_OUT) $(MAESTRO_DIR)/screenshots/capture.yaml
	cp $(SHOTS_OUT)/*.png $(SHOTS_IMG)/phoneScreenshots/
	cp $(SHOTS_OUT)/*.png $(SHOTS_IMG)/sevenInchScreenshots/
	cp $(SHOTS_OUT)/*.png $(SHOTS_IMG)/tenInchScreenshots/
	@echo "Screenshots -> $(SHOTS_IMG) (phone / 7in / 10in)"
