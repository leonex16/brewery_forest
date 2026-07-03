abstract class ErrorReporter {
  void reportError(
    Object error,
    StackTrace stackTrace, {
    Map<String, Object?>? context,
  });
}
