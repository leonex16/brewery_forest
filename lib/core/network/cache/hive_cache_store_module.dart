import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:http_cache_hive_store/http_cache_hive_store.dart';
import 'package:injectable/injectable.dart';

@module
abstract class CacheStoreModule {
  @preResolve
  Future<CacheStore> hiveCacheStore() async {
    return HiveCacheStore(null, hiveBoxName: 'dio_cache');
  }
}
