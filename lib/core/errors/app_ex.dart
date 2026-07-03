part 'domain_ex.dart';
part 'infra_ex.dart';
part 'application_ex.dart';

sealed class AppEx implements Exception {
  final String message;
  AppEx(this.message);

  @override
  String toString() => '$runtimeType: $message';
}
