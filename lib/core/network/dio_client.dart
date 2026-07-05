import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final _baseOptions = BaseOptions(
  baseUrl: 'https://api.openbrewerydb.org/v1',
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 5),
);

final _prettyDioLogger = PrettyDioLogger(
  responseBody: true,
  responseHeader: false,
  error: true,
  compact: false,
  enabled: kDebugMode,
);

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio() {
    final dio = Dio(_baseOptions);

    dio.interceptors.add(_prettyDioLogger);
    return dio;
  }
}
