import 'dart:async';

import 'package:brewery_forest/core/app_info/app_info.dart';
import 'package:brewery_forest/core/app_info/app_info_service.dart';
import 'package:brewery_forest/core/di/injection.dart';
import 'package:brewery_forest/ui/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_confetti/flutter_confetti.dart';

Future<void> showAppInfoEasterEgg(BuildContext context) async {
  final info = await getIt<AppInfoService>().resolve();
  if (!context.mounted) return;

  unawaited(
    showDialog<void>(
      context: context,
      builder: (_) => _AppInfoDialog(info: info),
    ),
  );

  Confetti.launch(
    context,
    options: const ConfettiOptions(particleCount: 140, spread: 80, startVelocity: 32, y: 0.7),
  );
}

class _AppInfoDialog extends StatelessWidget {
  const _AppInfoDialog({required this.info});

  final AppInfo info;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: .circular(AppRadius.lg)),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: .min,
          children: [
            const IconCircle(icon: AppIcons.drink),
            const Gap.gutter(),
            const AppText.headlineMd('Brewery Forest'),
            const Gap.group(),
            _InfoRow(label: 'Version', value: info.version),
            _InfoRow(label: 'Build', value: info.buildNumber),
            _InfoRow(label: 'Environment', value: info.environment),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close')),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(vertical: AppSpacing.base / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText.labelSm(label, color: context.colors.onSurfaceVariant),
          AppText.bodyMd(value),
        ],
      ),
    );
  }
}
