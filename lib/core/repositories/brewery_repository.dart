import 'package:brewery_forest/core/domain/brewery.dart';

abstract class BreweryRepository {
  List<Brewery> getAll();
  Brewery? getById(String id);
  List<Brewery> search(String q, {int? page = 1, int? perPage = 10});
}
