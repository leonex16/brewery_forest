import 'dart:developer' as developer;

import 'package:brewery_forest/core/observability/error_reporter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ErrorReporter)
final class LoggingErrorReporter implements ErrorReporter {
  @override
  void reportError(
    Object error,
    StackTrace stackTrace, {
    Map<String, Object?>? context,
  }) {
    final message = (context == null || context.isEmpty)
        ? error.toString()
        : '${error.toString()} | context: $context';

    developer.log(
      message,
      name: 'ErrorReporter',
      error: error,
      stackTrace: stackTrace,
    );
  }
}
