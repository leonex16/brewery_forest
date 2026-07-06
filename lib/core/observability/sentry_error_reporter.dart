import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'error_reporter.dart';

@dev
@prod
@LazySingleton(as: ErrorReporter)
class SentryErrorReporter implements ErrorReporter {
  @override
  String reportError(Object e, StackTrace st, {Map<String, Object?>? context}) {
    final eventId =
        'bf-${DateTime.now().microsecondsSinceEpoch.toRadixString(36)}';
    unawaited(
      Sentry.captureException(
        e,
        stackTrace: st,
        withScope: (scope) {
          scope.setTag('bf_event_id', eventId);
          if (context != null) scope.setContexts('bf_context', context);
        },
      ),
    );
    return eventId;
  }

  @override
  void addBreadcrumb(
    String message, {
    String? category,
    Map<String, Object?>? data,
  }) {
    unawaited(
      Sentry.addBreadcrumb(
        Breadcrumb(
          message: message,
          category: category,
          data: data == null ? null : Map<String, dynamic>.from(data),
        ),
      ),
    );
  }
}
