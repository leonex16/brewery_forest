import 'package:brewery_forest/ui/theme/dimensions.dart';
import 'package:brewery_forest/ui/theme/theme_context.dart';
import 'package:brewery_forest/ui/widgets/app_text.dart';
import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .centerLeft,
      child: Container(
        padding: const .symmetric(horizontal: AppSpacing.stackSm, vertical: 4),
        decoration: BoxDecoration(
          color: context.colors.secondaryContainer,
          borderRadius: .circular(AppRadius.pill),
        ),
        child: AppText.labelSm(
          label,
          color: context.colors.onSecondaryContainer,
        ),
      ),
    );
  }
}
