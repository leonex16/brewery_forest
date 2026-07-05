import 'package:brewery_forest/core/domain/brewery.dart';
import 'package:brewery_forest/core/network/dio_error_mapper.dart';
import 'package:brewery_forest/shared/api/obdb/models/brewery/obdb_brewery_res.dart';
import 'package:brewery_forest/shared/api/obdb/models/breweries/obdb_breweries_res.dart';
import 'package:brewery_forest/shared/api/obdb/models/search/obdb_search_res.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

typedef _BreweryRaw = Map<String, dynamic>;

@lazySingleton
final class ObdbDatasource {
  final Dio _dio;

  ObdbDatasource(this._dio);

  Future<List<ObdbBreweriesRes>> getAll({
    int? page = 1,
    int? perPage = 10,
    GeoCoordinates? near,
  }) => guardDio(() async {
    final response = await _dio.get(
      "/breweries",
      queryParameters: {
        'page': page,
        'per_page': perPage,
        if (near != null) ...{'by_dist': '${near.latitude},${near.longitude}'},
      },
    );
    final data = response.data as List;

    return data
        .map((b) => ObdbBreweriesRes.fromJson(b as _BreweryRaw))
        .toList();
  });

  Future<ObdbBreweryRes?> getById(String id) async {
    try {
      final response = await _dio.get("/breweries/$id");
      final data = response.data as _BreweryRaw;

      return ObdbBreweryRes.fromJson(data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      }

      throw mapDioException(e);
    }
  }

  Future<List<ObdbSearchRes>> search(
    String q, {
    int? page = 1,
    int? perPage = 10,
  }) => guardDio(() async {
    final response = await _dio.get(
      "/breweries/search",
      queryParameters: {'query': q, 'page': page, 'per_page': perPage},
    );
    final data = response.data as List;

    return data.map((b) => ObdbSearchRes.fromJson(b as _BreweryRaw)).toList();
  });
}
