import 'package:brewery_forest/core/domain/brewery.dart';
import 'package:brewery_forest/core/network/dio_error_mapper.dart';
import 'package:brewery_forest/core/observability/logger.dart';
import 'package:brewery_forest/shared/api/obdb/models/brewery/obdb_brewery_res.dart';
import 'package:brewery_forest/shared/api/obdb/models/breweries/obdb_breweries_res.dart';
import 'package:brewery_forest/shared/api/obdb/models/search/obdb_search_res.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

typedef _BreweryRaw = Map<String, dynamic>;

@lazySingleton
final class ObdbDatasource {
  final Dio _dio;
  final Logger _logger;

  ObdbDatasource(@Named('obdb') this._dio, this._logger);

  bool _isCancelled(DioException e, String operation) {
    if (e.type != DioExceptionType.cancel) return false;
    _logger.debug('$operation cancelled: ${e.message}');
    return true;
  }

  Future<List<ObdbBreweriesRes>?> getAll({
    int? page = 1,
    int? perPage = 10,
    GeoCoordinates? near,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get(
        "/breweries",
        cancelToken: cancelToken,
        queryParameters: {
          'page': page,
          'per_page': perPage,
          if (near != null) ...{
            'by_dist': '${near.latitude},${near.longitude}',
          },
        },
      );
      final data = response.data as List;

      return data
          .map((b) => ObdbBreweriesRes.fromJson(b as _BreweryRaw))
          .toList();
    } on DioException catch (e) {
      if (_isCancelled(e, 'getAll')) return null;
      throw mapDioException(e);
    }
  }

  Future<ObdbBreweryRes?> getById(String id) async {
    try {
      final response = await _dio.get("/breweries/$id");
      final data = response.data as _BreweryRaw;

      return ObdbBreweryRes.fromJson(data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return null;
      throw mapDioException(e);
    }
  }

  Future<List<ObdbSearchRes>?> search(
    String q, {
    int? page = 1,
    int? perPage = 10,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get(
        "/breweries/search",
        cancelToken: cancelToken,
        queryParameters: {'query': q, 'page': page, 'per_page': perPage},
      );
      final data = response.data as List;
      return data.map((b) => ObdbSearchRes.fromJson(b as _BreweryRaw)).toList();
    } on DioException catch (e) {
      if (_isCancelled(e, 'search')) return null;
      throw mapDioException(e);
    }
  }
}
