import 'package:brewery_forest/ui/index.dart';
import 'package:flutter/material.dart';

class DetailInfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? iconBackground;
  final Color? iconForeground;
  final VoidCallback? onTap;

  const DetailInfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.iconBackground,
    this.iconForeground,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: .all(AppSpacing.containerPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconCircle(
            icon: icon,
            background: iconBackground,
            foreground: iconForeground,
          ),
          const Gap.gutter(axis: Axis.horizontal),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                AppText.labelSm(
                  label.toUpperCase(),
                  color: context.colors.onSurfaceVariant,
                ),
                const Gap.tiny(),
                AppText.bodyLg(value),
              ],
            ),
          ),
          if (onTap != null) ...[
            const Gap.gutter(axis: Axis.horizontal),
            Icon(
              AppIcons.openExternal,
              size: 18,
              color: context.colors.onSurfaceVariant,
            ),
          ],
        ],
      ),
    );

    return Card(
      child: onTap == null
          ? content
          : InkWell(
              borderRadius: BorderRadius.circular(AppRadius.xl),
              onTap: onTap,
              child: content,
            ),
    );
  }
}
