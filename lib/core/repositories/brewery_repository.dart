import 'package:brewery_forest/core/domain/brewery.dart';

abstract class BreweryRepository {
  Future<(List<Brewery> breweries, bool hasMore)> getAll({
    int? page = 1,
    int? perPage = 10,
    GeoCoordinates? near,
  });
  Future<Brewery?> getById(String id);
  Future<List<Brewery>> search(String q, {int? page = 1, int? perPage = 10});
}
