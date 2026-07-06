abstract class ErrorReporter {
  String reportError(Object e, StackTrace st, {Map<String, Object?>? context});
}
