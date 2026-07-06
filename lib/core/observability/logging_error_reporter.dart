import 'dart:developer' as developer;

import 'package:brewery_forest/core/observability/error_reporter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ErrorReporter)
final class LoggingErrorReporter implements ErrorReporter {
  @override
  String reportError(Object e, StackTrace st, {Map<String, Object?>? context}) {
    final eventId =
        'bf-${DateTime.now().microsecondsSinceEpoch.toRadixString(36)}';
    final message = (context == null || context.isEmpty)
        ? e.toString()
        : '${e.toString()} | context: $context';
    developer.log(
      '[$eventId] $message',
      name: 'ErrorReporter',
      error: e,
      stackTrace: st,
    );
    return eventId;
  }
}
