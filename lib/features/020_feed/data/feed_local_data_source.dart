import 'package:brewery_forest/core/observability/error_reporter.dart';
import 'package:brewery_forest/shared/api/obdb/models/breweries/obdb_breweries_res.dart';
import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';

abstract class FeedLocalDataSource {
  Future<List<ObdbBreweriesRes>> getLastSuccessful();
  Future<void> saveLastSuccessful(List<ObdbBreweriesRes> breweries);
}

const _feedCacheKey = 'last_successful_feed';

@LazySingleton(as: FeedLocalDataSource)
class HiveFeedLocalDataSource implements FeedLocalDataSource {
  static const boxName = 'feed_cache';
  LazyBox? _box;

  final ErrorReporter _errorReporter;

  HiveFeedLocalDataSource(this._errorReporter);

  Future<LazyBox> get _openBox async => _box ??= await Hive.openLazyBox(boxName);

  @override
  Future<List<ObdbBreweriesRes>> getLastSuccessful() async {
    try {
      final box = await _openBox;
      final cached = await box.get(_feedCacheKey);

      if (cached == null) return [];

      return (cached as List).cast<ObdbBreweriesRes>();
    } catch (e, st) {
      _errorReporter.reportError(
        e,
        st,
        context: {'method': 'getLastSuccessful', 'cacheKey': _feedCacheKey},
      );
      return [];
    }
  }

  @override
  Future<void> saveLastSuccessful(List<ObdbBreweriesRes> breweries) async {
    final box = await _openBox;
    await box.put(_feedCacheKey, breweries);
  }
}
