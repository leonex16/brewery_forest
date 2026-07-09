import 'package:brewery_forest/core/index.dart';
import 'package:brewery_forest/features/020_feed/data/feed_local_data_source.dart';
import 'package:brewery_forest/shared/api/obdb/models/breweries/obdb_breweries_mapper.dart';
import 'package:brewery_forest/shared/api/obdb/models/breweries/obdb_breweries_res.dart';
import 'package:brewery_forest/shared/api/obdb/models/brewery/obdb_brewery_mapper.dart';
import 'package:brewery_forest/shared/api/obdb/models/search/obdb_search_mapper.dart';
import 'package:brewery_forest/shared/api/obdb/obdb_datasource.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: BreweryRepository)
final class ObdbBreweryRepository implements BreweryRepository {
  final ObdbDatasource _datasource;
  final FeedLocalDataSource _feedLocalDataSource;
  final ErrorReporter _errorReporter;

  ObdbBreweryRepository(this._datasource, this._feedLocalDataSource, this._errorReporter);

  @override
  Future<(List<Brewery> breweries, bool hasMore)?> getAll({
    int? page = 1,
    int? perPage = 10,
    GeoCoordinates? near,
    CancelToken? cancelToken,
  }) async {
    try {
      final res = await _datasource.getAll(
        page: page,
        perPage: perPage,
        near: near,
        cancelToken: cancelToken,
      );

      if (res == null) return null;

      if ((page ?? 1) == 1) {
        await _feedLocalDataSource.saveLastSuccessful(res);
      }

      return (_mapToEntities(res), res.isNotEmpty);
    } on InfraEx catch (e, stackTrace) {
      final cached = await _feedLocalDataSource.getLastSuccessful();
      if (cached.isEmpty) rethrow;

      _errorReporter.reportError(e, stackTrace, context: {'served_from': 'feed_cache'});

      return (_mapToEntities(cached), false);
    }
  }

  List<Brewery> _mapToEntities(List<ObdbBreweriesRes> res) {
    final breweries = <Brewery>[];

    for (final brewery in res) {
      try {
        breweries.add(brewery.toEntity());
      } on DomainEx catch (e, stackTrace) {
        _errorReporter.reportError(e, stackTrace, context: {'brewery_id': brewery.id});
      }
    }

    return breweries;
  }

  @override
  Future<Brewery?> getById(String id) async {
    final res = await _datasource.getById(id);
    return res?.toEntity();
  }

  @override
  Future<List<Brewery>?> search(
    String q, {
    int? page = 1,
    int? perPage = 10,
    CancelToken? cancelToken,
  }) async {
    final res = await _datasource.search(q, page: page, perPage: perPage, cancelToken: cancelToken);

    if (res == null) return null;

    final breweries = <Brewery>[];

    for (final brewery in res) {
      try {
        breweries.add(brewery.toEntity());
      } on DomainEx catch (e, stackTrace) {
        _errorReporter.reportError(e, stackTrace, context: {'brewery_id': brewery.id});
      }
    }

    return breweries;
  }
}
