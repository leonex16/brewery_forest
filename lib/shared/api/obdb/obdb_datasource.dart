import 'package:brewery_forest/shared/api/obdb/models/brewery/obdb_brewire_res.dart';
import 'package:brewery_forest/shared/api/obdb/models/breweries/obdb_brewires_res.dart';
import 'package:brewery_forest/shared/api/obdb/models/search/obdb_search_res.dart';


final class ObdbDatasource {
  @override
  List<ObdbBreweriesRes> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  ObdbBreweryRes? getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  List<ObdbSeachRes> search(String q, {int? page = 1, int? perPage = 10}) {
    // TODO: implement search
    throw UnimplementedError();
  }
}
