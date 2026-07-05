abstract class ErrorReporter {
  void reportError(Object e, StackTrace st, {Map<String, Object?>? context});
}
