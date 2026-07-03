import 'package:brewery_forest/core/index.dart';
import 'package:brewery_forest/shared/api/obdb/models/breweries/obdb_breweries_mapper.dart';
import 'package:brewery_forest/shared/api/obdb/models/brewery/obdb_brewery_mapper.dart';
import 'package:brewery_forest/shared/api/obdb/models/search/obdb_search_mapper.dart';
import 'package:brewery_forest/shared/api/obdb/obdb_datasource.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: BreweryRepository)
final class ObdbRepository implements BreweryRepository {
  final ObdbDatasource _datasource;
  final ErrorReporter _errorReporter;

  ObdbRepository(this._datasource, this._errorReporter);

  @override
  Future<List<Brewery>> getAll() async {
    final res = await _datasource.getAll();
    final breweries = <Brewery>[];

    for (final brewery in res) {
      try {
        breweries.add(brewery.toEntity());
      } on DomainEx catch (e, stackTrace) {
        _errorReporter.reportError(
          e,
          stackTrace,
          context: {'brewery_id': brewery.id},
        );
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
  Future<List<Brewery>> search(
    String q, {
    int? page = 1,
    int? perPage = 10,
  }) async {
    final res = await _datasource.search(q, page: page, perPage: perPage);
    final breweries = <Brewery>[];

    for (final brewery in res) {
      try {
        breweries.add(brewery.toEntity());
      } on DomainEx catch (e, stackTrace) {
        _errorReporter.reportError(
          e,
          stackTrace,
          context: {'brewery_id': brewery.id},
        );
      }
    }

    return breweries;
  }
}
