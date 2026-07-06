import 'package:brewery_forest/ui/theme/app_icons.dart';
import 'package:brewery_forest/ui/theme/dimensions.dart';
import 'package:brewery_forest/ui/theme/l10n_context.dart';
import 'package:brewery_forest/ui/theme/theme_context.dart';
import 'package:brewery_forest/ui/widgets/app_text.dart';
import 'package:brewery_forest/ui/widgets/gap.dart';
import 'package:brewery_forest/ui/widgets/icon_circle.dart';
import 'package:flutter/material.dart';

class EnableLocationPage extends StatelessWidget {
  final VoidCallback onEnable;
  final VoidCallback onExplore;

  const EnableLocationPage({
    super.key,
    required this.onEnable,
    required this.onExplore,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const .symmetric(horizontal: AppSpacing.containerPadding),
          child: Column(
            children: [
              const Spacer(),

              const _LocationHero(),
              const Gap.section(),

              AppText.headlineLgMobile(
                context.l10n.onboardingTitle,
                textAlign: .center,
              ),
              const Gap.group(),
              AppText.bodyLg(
                context.l10n.onboardingBody,
                textAlign: .center,
                color: context.colors.onSurfaceVariant,
              ),
              const Gap.section(),

              FilledButton.icon(
                onPressed: onEnable,
                icon: Icon(
                  AppIcons.myLocation,
                  color: context.colors.onPrimary,
                ),
                label: AppText.labelMd(
                  context.l10n.onboardingEnable,
                  color: context.colors.onPrimary,
                ),
              ),
              const Gap.tiny(),
              TextButton(
                onPressed: onExplore,
                child: AppText.labelMd(context.l10n.onboardingExplore),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LocationHero extends StatelessWidget {
  static const double size = 192;

  const _LocationHero();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return SizedBox(
      width: _LocationHero.size,
      height: _LocationHero.size,
      child: Stack(
        clipBehavior: .none,
        alignment: .center,
        children: [
          Container(
            width: _LocationHero.size,
            height: _LocationHero.size,
            decoration: BoxDecoration(
              shape: .circle,
              color: colors.primaryFixed.withValues(alpha: 0.4),
              boxShadow: [
                BoxShadow(
                  color: colors.primaryFixed.withValues(alpha: 0.4),
                  blurRadius: 48,
                  spreadRadius: 8,
                ),
              ],
            ),
          ),

          const IconCircle(icon: AppIcons.userPin, size: _LocationHero.size),

          Positioned(
            top: -8,
            right: -4,
            child: Transform.rotate(
              angle: 0.2,
              child: IconCircle(
                icon: AppIcons.drink,
                size: 48,
                background: colors.secondaryContainer,
                foreground: colors.onSecondaryContainer,
                shape: .rectangle,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
            ),
          ),

          Positioned(
            bottom: 8,
            left: -12,
            child: Transform.rotate(
              angle: -0.1,
              child: IconCircle(
                icon: AppIcons.mapTrifold,
                size: 52,
                background: colors.tertiaryContainer,
                foreground: colors.onTertiaryContainer,
                shape: .rectangle,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
