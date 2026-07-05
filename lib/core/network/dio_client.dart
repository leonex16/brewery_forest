import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final _prettyDioLogger = PrettyDioLogger(
  responseBody: true,
  responseHeader: false,
  error: true,
  compact: false,
  enabled: kDebugMode,
);

Dio _dioFor(String baseUrl) {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );

  dio.interceptors.add(_prettyDioLogger);
  return dio;
}

@module
abstract class NetworkModule {
  @Named('obdb')
  @lazySingleton
  Dio obdbDio() => _dioFor('https://api.openbrewerydb.org/v1');

  @Named('ipwho')
  @lazySingleton
  Dio ipwhoDio() => _dioFor('https://ipwho.is');
}
