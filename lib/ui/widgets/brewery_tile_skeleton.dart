import 'package:flutter/material.dart';
import 'package:brewery_forest/ui/index.dart';

class BreweryTileSkeleton extends StatelessWidget {
  const BreweryTileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: .symmetric(
        horizontal: AppSpacing.gutter,
        vertical: AppSpacing.stackMd,
      ),
      child: Row(
        children: [
          Skeleton(width: 48, height: 48, radius: 24),

          Gap.gutter(axis: .horizontal),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Skeleton(width: 160),
                Gap.tiny(),
                Skeleton(width: 100, height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
