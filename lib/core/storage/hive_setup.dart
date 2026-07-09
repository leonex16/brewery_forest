import 'package:brewery_forest/shared/api/obdb/models/breweries/obdb_breweries_res_hive_adapter.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ObdbBreweriesResHiveAdapter());
}
