import 'package:brewery_forest/ui/theme/app_icons.dart';
import 'package:brewery_forest/ui/theme/dimensions.dart';
import 'package:brewery_forest/ui/theme/theme_context.dart';
import 'package:brewery_forest/ui/widgets/app_text.dart';
import 'package:flutter/material.dart';

class BfBanner extends StatelessWidget {
  const BfBanner({
    super.key,
    required this.message,
    this.icon = AppIcons.info,
    this.onDismiss,
    this.semanticsIdentifier,
  });

  final String message;
  final IconData icon;
  final VoidCallback? onDismiss;
  final String? semanticsIdentifier;

  @override
  Widget build(BuildContext context) {
    final banner = Material(
      color: context.colors.surfaceContainerLow,
      elevation: 2,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.gutter,
          vertical: AppSpacing.stackSm,
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: context.colors.onSurfaceVariant),
            const SizedBox(width: AppSpacing.stackSm),
            Expanded(child: AppText.labelMd(message)),
            if (onDismiss != null)
              IconButton(
                icon: const Icon(AppIcons.close, size: 20),
                visualDensity: VisualDensity.compact,
                onPressed: onDismiss,
              ),
          ],
        ),
      ),
    );

    if (semanticsIdentifier == null) return banner;
    return Semantics(identifier: semanticsIdentifier, child: banner);
  }
}
