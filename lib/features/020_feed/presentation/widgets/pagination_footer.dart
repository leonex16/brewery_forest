import 'package:brewery_forest/core/errors/app_ex.dart';
import 'package:brewery_forest/features/020_feed/application/feed_cubit.dart';
import 'package:brewery_forest/ui/index.dart';
import 'package:flutter/material.dart';

class PaginationFooter extends StatelessWidget {
  final PaginationStatus status;
  final VoidCallback onRetry;
  final AppEx? error;

  const PaginationFooter({
    super.key,
    required this.status,
    required this.onRetry,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      PaginationStatus.idle => const SizedBox.shrink(),

      PaginationStatus.reachedEnd => Padding(
        padding: const EdgeInsets.all(AppSpacing.gutter),
        child: Center(
          child: AppText.labelSm(
            context.l10n.paginationEnd,
            color: context.colors.onSurfaceVariant,
          ),
        ),
      ),

      PaginationStatus.loadingMore => const Padding(
        padding: EdgeInsets.all(AppSpacing.gutter),
        child: LoadingView(),
      ),

      PaginationStatus.error => Padding(
        padding: const EdgeInsets.all(AppSpacing.gutter),
        child: Center(
          child: Semantics(
            identifier: 'pagination_retry',
            child: TextButton(
              onPressed: onRetry,
              child: Text(context.l10n.feedRetry),
            ),
          ),
        ),
      ),
    };
  }
}
