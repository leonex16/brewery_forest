import 'package:brewery_forest/core/errors/app_ex.dart';
import 'package:dio/dio.dart';

InfraEx mapDioException(DioException e) {
  return switch (e.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout ||
    DioExceptionType.connectionError => NetworkEx(cause: e),
    DioExceptionType.badResponse => ServerEx(
      statusCode: e.response?.statusCode,
      cause: e,
    ),
    _ => NetworkEx(cause: e),
  };
}
