import 'dart:developer' as developer;

import 'package:brewery_forest/core/observability/logger.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: Logger)
final class DeveloperLogger implements Logger {
  @override
  void debug(String message, {Map<String, Object?>? context}) {
    final full = (context == null || context.isEmpty)
        ? message
        : '$message | context: $context';

    developer.log(full, name: 'Logger');
  }
}
