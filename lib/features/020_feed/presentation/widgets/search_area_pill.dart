import 'package:brewery_forest/ui/index.dart';
import 'package:flutter/material.dart';

class SearchAreaPill extends StatelessWidget {
  final VoidCallback onTap;

  const SearchAreaPill({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.surfaceContainerHigh,
      elevation: 3,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.pill),
        onTap: onTap,
        child: Padding(
          padding: .symmetric(
            horizontal: AppSpacing.gutter,
            vertical: AppSpacing.stackSm,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                AppIcons.searchArea,
                size: 18,
                color: context.colors.onSurface,
              ),
              const Gap.gutter(axis: Axis.horizontal),
              AppText.labelMd(context.l10n.searchThisArea),
            ],
          ),
        ),
      ),
    );
  }
}
