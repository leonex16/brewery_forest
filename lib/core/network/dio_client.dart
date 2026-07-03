import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

final baseOptions = BaseOptions(
  baseUrl: 'https://api.openbrewerydb.org/v1',
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 5),
);

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio() => Dio(baseOptions);
}
