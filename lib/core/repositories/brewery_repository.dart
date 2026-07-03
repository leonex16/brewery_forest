import 'package:brewery_forest/core/domain/brewery.dart';

abstract class BreweryRepository {
  Future<List<Brewery>> getAll({int? page = 1, int? perPage = 10});
  Future<Brewery?> getById(String id);
  Future<List<Brewery>> search(String q, {int? page = 1, int? perPage = 10});
}
