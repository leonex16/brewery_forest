## https://pub.dev/packages/build_runner

build:
	dart run build_runner build

watch:
	dart run build_runner watch

## Dart

anlz:
	dart analyze lib

## Maestro e2e (Android only — Maestro doesn't support Flutter Desktop)

.PHONY: build

# Resolve adb from PATH, falling back to the default macOS SDK location.
ADB ?= $(shell command -v adb 2>/dev/null || echo $(HOME)/Library/Android/sdk/platform-tools/adb)
MAESTRO_DIR := maestro

# Build + install the debug APK with the Mapbox token (required, or the app crashes at launch).
e2e-build:
	flutter build apk --debug --dart-define-from-file=env/production.json
	$(ADB) install -r build/app/outputs/flutter-apk/app-debug.apk

# One-time device prep: accept the GMS "Location Accuracy" consent + disable animations.
e2e-setup:
	$(ADB) shell settings put global window_animation_scale 0
	$(ADB) shell settings put global transition_animation_scale 0
	$(ADB) shell settings put global animator_duration_scale 0
	maestro test $(MAESTRO_DIR)/subflows/accept_location_consent.yaml

e2e:
	maestro test $(MAESTRO_DIR)

e2e-smoke:
	maestro test $(MAESTRO_DIR) --include-tags smoke

e2e-report:
	maestro test $(MAESTRO_DIR) --format HTML-DETAILED --output maestro-report

e2e-demo:
	$(ADB) shell settings put global window_animation_scale 1.5
	$(ADB) shell settings put global transition_animation_scale 1.5
	$(ADB) shell settings put global animator_duration_scale 1.5
	maestro test $(MAESTRO_DIR)/demo/010_walkthrough.yaml
	maestro test $(MAESTRO_DIR)/demo/020_ip_location.yaml

e2e-demo-reset:
	$(ADB) shell settings put global window_animation_scale 0
	$(ADB) shell settings put global transition_animation_scale 0
	$(ADB) shell settings put global animator_duration_scale 0

e2e-record:
	maestro record --local $(MAESTRO_DIR)/demo/010_walkthrough.yaml walkthrough.mp4
