import 'package:brewery_forest/core/index.dart';
import 'package:brewery_forest/ui/index.dart';
import 'package:flutter/material.dart';

class DetailErrorView extends StatelessWidget {
  final AppEx error;
  final String eventId;
  final VoidCallback onRetry;
  final VoidCallback onGoHome;

  const DetailErrorView({
    super.key,
    required this.error,
    required this.eventId,
    required this.onRetry,
    required this.onGoHome,
  });

  bool get _isDiagnostic => error is ServerEx || error is ParsingEx;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_isDiagnostic) _DiagnosticPill(error: error, eventId: eventId),
        Expanded(
          child: StatusView(
            icon: AppIcons.error,
            headline: _isDiagnostic
                ? context.l10n.detailDiagnosticTitle
                : context.l10n.errServer,
            body: _isDiagnostic
                ? context.l10n.detailDiagnosticBody
                : context.l10n.detailErrorBody,
            actions: [
              FilledButton(
                onPressed: onRetry,
                child: Text(
                  _isDiagnostic
                      ? context.l10n.detailTryRefreshing
                      : context.l10n.feedRetry,
                ),
              ),
              TextButton(
                onPressed: onGoHome,
                child: Text(context.l10n.detailGoHome),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DiagnosticPill extends StatelessWidget {
  const _DiagnosticPill({required this.error, required this.eventId});
  final AppEx error;
  final String eventId;

  @override
  Widget build(BuildContext context) {
    final code = switch (error) {
      ServerEx(:final statusCode) => 'ERROR ${statusCode ?? '???'}',
      _ => 'PARSE ERROR',
    };
    return Padding(
      padding: const .all(AppSpacing.gutter),
      child: Container(
        padding: const .symmetric(horizontal: AppSpacing.gutter, vertical: 6),
        decoration: BoxDecoration(
          color: context.colors.surfaceContainerHigh,
          borderRadius: .circular(AppRadius.pill),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText.labelSm(code, color: context.colors.error),
            const Gap.group(axis: Axis.horizontal),
            AppText.labelSm(
              '| Trace $eventId',
              color: context.colors.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
