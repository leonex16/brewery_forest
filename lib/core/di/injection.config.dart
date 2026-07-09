// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:brewery_forest/core/app_info/app_info_service.dart' as _i272;
import 'package:brewery_forest/core/index.dart' as _i496;
import 'package:brewery_forest/core/managers/location/ip_location_repository.dart'
    as _i826;
import 'package:brewery_forest/core/managers/location/location_repository.dart'
    as _i304;
import 'package:brewery_forest/core/network/cache/hive_cache_store_module.dart'
    as _i100;
import 'package:brewery_forest/core/network/dio_client.dart' as _i209;
import 'package:brewery_forest/core/observability/developer_logger.dart'
    as _i60;
import 'package:brewery_forest/core/observability/device_identity_service.dart'
    as _i810;
import 'package:brewery_forest/core/observability/error_reporter.dart' as _i113;
import 'package:brewery_forest/core/observability/logger.dart' as _i768;
import 'package:brewery_forest/core/observability/logging_error_reporter.dart'
    as _i275;
import 'package:brewery_forest/core/observability/sentry_error_reporter.dart'
    as _i429;
import 'package:brewery_forest/features/010_location_onboarding/application/location_onboarding_cubit.dart'
    as _i708;
import 'package:brewery_forest/features/020_feed/application/feed_cubit.dart'
    as _i305;
import 'package:brewery_forest/features/020_feed/application/search_bloc.dart'
    as _i711;
import 'package:brewery_forest/features/020_feed/data/feed_local_data_source.dart'
    as _i1030;
import 'package:brewery_forest/features/030_brewery_detail/application/brewery_detail_cubit.dart'
    as _i685;
import 'package:brewery_forest/shared/api/ipwhois/ipwhois_datasource.dart'
    as _i684;
import 'package:brewery_forest/shared/api/obdb/obdb_brewery_repository.dart'
    as _i846;
import 'package:brewery_forest/shared/api/obdb/obdb_datasource.dart' as _i609;
import 'package:dio/dio.dart' as _i361;
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart' as _i695;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

const String _dev = 'dev';
const String _prod = 'prod';
const String _test = 'test';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final cacheStoreModule = _$CacheStoreModule();
    final networkModule = _$NetworkModule();
    await gh.factoryAsync<_i695.CacheStore>(
      () => cacheStoreModule.hiveCacheStore(),
      preResolve: true,
    );
    gh.lazySingleton<_i304.LocationRepository>(
      () => _i304.GeolocatorLocationRepository(),
    );
    gh.factory<_i708.LocationOnboardingCubit>(
      () => _i708.LocationOnboardingCubit(gh<_i496.LocationRepository>()),
    );
    gh.lazySingleton<_i768.Logger>(() => _i60.DeveloperLogger());
    gh.lazySingleton<_i113.ErrorReporter>(
      () => _i429.SentryErrorReporter(),
      registerFor: {_dev, _prod},
    );
    gh.lazySingleton<_i113.ErrorReporter>(
      () => _i275.LoggingErrorReporter(),
      registerFor: {_test},
    );
    gh.lazySingleton<_i272.AppInfoService>(() => _i272.AppInfoServiceImpl());
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.ipwhoDio(gh<_i695.CacheStore>()),
      instanceName: 'ipwho',
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.obdbDio(gh<_i695.CacheStore>()),
      instanceName: 'obdb',
    );
    gh.lazySingleton<_i810.DeviceIdentityService>(
      () => _i810.DeviceIdentityServiceImpl(),
    );
    gh.lazySingleton<_i1030.FeedLocalDataSource>(
      () => _i1030.HiveFeedLocalDataSource(gh<_i113.ErrorReporter>()),
    );
    gh.lazySingleton<_i609.ObdbDatasource>(
      () => _i609.ObdbDatasource(
        gh<_i361.Dio>(instanceName: 'obdb'),
        gh<_i768.Logger>(),
      ),
    );
    gh.lazySingleton<_i496.BreweryRepository>(
      () => _i846.ObdbBreweryRepository(
        gh<_i609.ObdbDatasource>(),
        gh<_i1030.FeedLocalDataSource>(),
        gh<_i496.ErrorReporter>(),
      ),
    );
    gh.lazySingleton<_i684.IpWhoisDatasource>(
      () => _i684.IpWhoisDatasource(
        gh<_i361.Dio>(instanceName: 'ipwho'),
        gh<_i768.Logger>(),
      ),
    );
    gh.lazySingleton<_i826.IpLocationRepository>(
      () => _i826.IpWhoisLocationRepository(gh<_i684.IpWhoisDatasource>()),
    );
    gh.factoryParam<_i685.BreweryDetailCubit, String, dynamic>(
      (id, _) => _i685.BreweryDetailCubit(
        gh<_i496.BreweryRepository>(),
        gh<_i496.ErrorReporter>(),
        id,
      ),
    );
    gh.factory<_i711.SearchBloc>(
      () => _i711.SearchBloc(
        repository: gh<_i496.BreweryRepository>(),
        errorReporter: gh<_i496.ErrorReporter>(),
      ),
    );
    gh.factory<_i305.FeedCubit>(
      () => _i305.FeedCubit(
        repository: gh<_i496.BreweryRepository>(),
        locationRepository: gh<_i496.LocationRepository>(),
        ipLocationRepository: gh<_i496.IpLocationRepository>(),
        errorReporter: gh<_i496.ErrorReporter>(),
      ),
    );
    return this;
  }
}

class _$CacheStoreModule extends _i100.CacheStoreModule {}

class _$NetworkModule extends _i209.NetworkModule {}
