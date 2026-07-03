class AppEx implements Exception {
  final String message;
  AppEx(this.message);

  @override
  String toString() => '$runtimeType: $message';
}
