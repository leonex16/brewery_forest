import 'package:brewery_forest/core/app_info/app_info.dart';
import 'package:brewery_forest/core/env.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

abstract class AppInfoService {
  Future<AppInfo> resolve();
}

@LazySingleton(as: AppInfoService)
class AppInfoServiceImpl implements AppInfoService {
  AppInfo? _cached;

  @override
  Future<AppInfo> resolve() async {
    if (_cached != null) return _cached!;

    final info = await PackageInfo.fromPlatform();

    return _cached = AppInfo(
      version: info.version,
      buildNumber: info.buildNumber,
      environment: Env.appEnv,
    );
  }
}
