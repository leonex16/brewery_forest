part of 'app_ex.dart';

sealed class InfraEx extends AppEx {
  final Object? cause;
  InfraEx(super.message, {this.cause});
}

final class NetworkEx extends InfraEx {
  NetworkEx({super.cause}) : super('Network error');
}

final class ServerEx extends InfraEx {
  final int? statusCode;
  ServerEx({this.statusCode, super.cause})
    : super('Server error with status code $statusCode');
}

final class ParsingEx extends InfraEx {
  ParsingEx(super.message, {super.cause});
}

final class StorageEx extends InfraEx {
  StorageEx(super.message, {super.cause});
}
