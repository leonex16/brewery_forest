import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final _prettyDioLoggerInterceptor = PrettyDioLogger(
  responseBody: true,
  responseHeader: false,
  error: true,
  compact: false,
  enabled: kDebugMode,
);

Dio _dioFor(String baseUrl, {required CacheStore cacheStore}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );

  final cacheOptions = CacheOptions(
    store: cacheStore,
    hitCacheOnErrorCodes: [500],
    hitCacheOnNetworkFailure: true,
    maxStale: const Duration(days: 7),
    priority: .normal,
  );
  final cacheInterceptor = DioCacheInterceptor(options: cacheOptions);

  dio.interceptors.addAll([_prettyDioLoggerInterceptor, cacheInterceptor]);
  return dio;
}

@module
abstract class NetworkModule {
  @Named('obdb')
  @lazySingleton
  Dio obdbDio(CacheStore cacheStore) =>
      _dioFor('https://api.openbrewerydb.org/v1', cacheStore: cacheStore);

  @Named('ipwho')
  @lazySingleton
  Dio ipwhoDio(CacheStore cacheStore) => _dioFor('https://ipwho.is', cacheStore: cacheStore);
}
