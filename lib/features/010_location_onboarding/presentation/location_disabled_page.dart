import 'package:brewery_forest/ui/index.dart';
import 'package:flutter/material.dart';

class LocationDisabledPage extends StatefulWidget {
  final Future<bool> Function() onOpenSettings;
  final VoidCallback onExplore;
  final VoidCallback reCheckPermission;

  const LocationDisabledPage({
    super.key,
    required this.onOpenSettings,
    required this.onExplore,
    required this.reCheckPermission,
  });

  @override
  State<LocationDisabledPage> createState() => _LocationDisabledPageState();
}

class _LocationDisabledPageState extends State<LocationDisabledPage> {
  late AppLifecycleListener _lifecycleListener;

  @override
  void initState() {
    super.initState();
    _lifecycleListener = AppLifecycleListener(
      onResume: () => widget.reCheckPermission(),
    );
  }

  @override
  void dispose() {
    _lifecycleListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const .symmetric(horizontal: AppSpacing.containerPadding),
          child: Column(
            children: [
              const Spacer(),

              IconCircle(
                icon: AppIcons.myLocationOff,
                size: 128,
                background: context.colors.surfaceContainer,
                foreground: context.colors.primary.withValues(alpha: 0.8),
              ),
              const Gap.group(),

              AppText.headlineLgMobile(
                context.l10n.deniedTitle,
                textAlign: .center,
              ),
              const Gap.group(),
              AppText.bodyLg(
                context.l10n.deniedBody,
                textAlign: .center,
                color: context.colors.onSurfaceVariant,
              ),
              const Gap.section(),

              FilledButton.icon(
                onPressed: () => widget.onOpenSettings(),
                icon: Icon(AppIcons.settings, color: context.colors.onPrimary),
                label: AppText.labelMd(
                  context.l10n.deniedOpenSettings,
                  color: context.colors.onPrimary,
                ),
              ),
              const Gap.tiny(),
              TextButton(
                onPressed: widget.onExplore,
                child: AppText.labelMd(context.l10n.deniedExplore),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
