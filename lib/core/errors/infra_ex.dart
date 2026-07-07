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

final class LocationUnavailableEx extends InfraEx {
  LocationUnavailableEx({super.cause}) : super('Location unavailable');
}
