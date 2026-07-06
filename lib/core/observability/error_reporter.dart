abstract class ErrorReporter {
  String reportError(Object e, StackTrace st, {Map<String, Object?>? context});
  void addBreadcrumb(
    String message, {
    String? category,
    Map<String, Object?>? data,
  });
}
