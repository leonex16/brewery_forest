import 'package:brewery_forest/core/errors/app_ex.dart';

sealed class InfraEx extends AppEx {
  final Object? cause;
  InfraEx(super.message, {this.cause});
}

final class NetworkEx extends InfraEx {
  NetworkEx(super.message, {super.cause});
}

final class ParsingEx extends InfraEx {
  ParsingEx(super.message, {super.cause});
}

final class StorageEx extends InfraEx {
  StorageEx(super.message, {super.cause});
}
