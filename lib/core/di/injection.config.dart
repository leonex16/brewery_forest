// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:brewery_forest/core/index.dart' as _i496;
import 'package:brewery_forest/core/managers/location/location_repository.dart'
    as _i304;
import 'package:brewery_forest/core/network/dio_client.dart' as _i209;
import 'package:brewery_forest/core/observability/error_reporter.dart' as _i113;
import 'package:brewery_forest/core/observability/logging_error_reporter.dart'
    as _i275;
import 'package:brewery_forest/features/010_location_onboarding/location_onboarding_cubit.dart'
    as _i175;
import 'package:brewery_forest/features/020_feed/feed_cubit.dart' as _i347;
import 'package:brewery_forest/features/030_brewery_detail/brewery_detail_cubit.dart'
    as _i931;
import 'package:brewery_forest/shared/api/obdb/obdb_datasource.dart' as _i609;
import 'package:brewery_forest/shared/api/obdb/obdb_repository.dart' as _i525;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio());
    gh.lazySingleton<_i113.ErrorReporter>(() => _i275.LoggingErrorReporter());
    gh.lazySingleton<_i304.LocationRepository>(
      () => _i304.GeolocatorLocationRepository(),
    );
    gh.factory<_i175.LocationOnboardingCubit>(
      () => _i175.LocationOnboardingCubit(gh<_i496.LocationRepository>()),
    );
    gh.lazySingleton<_i609.ObdbDatasource>(
      () => _i609.ObdbDatasource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i496.BreweryRepository>(
      () => _i525.ObdbRepository(
        gh<_i609.ObdbDatasource>(),
        gh<_i496.ErrorReporter>(),
      ),
    );
    gh.factory<_i347.FeedCubit>(
      () => _i347.FeedCubit(
        repository: gh<_i496.BreweryRepository>(),
        errorReporter: gh<_i496.ErrorReporter>(),
      ),
    );
    gh.factoryParam<_i931.BreweryDetailCubit, String, dynamic>(
      (id, _) => _i931.BreweryDetailCubit(gh<_i496.BreweryRepository>(), id),
    );
    return this;
  }
}

class _$NetworkModule extends _i209.NetworkModule {}
