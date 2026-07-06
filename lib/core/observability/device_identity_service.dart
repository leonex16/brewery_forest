import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class DeviceIdentity {
  final String installationId;
  final String model;
  final String osVersion;

  const DeviceIdentity({
    required this.installationId,
    required this.model,
    required this.osVersion,
  });
}

abstract class DeviceIdentityService {
  Future<DeviceIdentity> resolve();
}

@LazySingleton(as: DeviceIdentityService)
class DeviceIdentityServiceImpl implements DeviceIdentityService {
  static const _key = 'installation_id';
  DeviceIdentity? _cached;

  @override
  Future<DeviceIdentity> resolve() async {
    if (_cached != null) return _cached!;

    final prefs = await SharedPreferences.getInstance();
    var id = prefs.getString(_key);
    if (id == null) {
      id = const Uuid().v4();
      await prefs.setString(_key, id);
    }

    final info = DeviceInfoPlugin();
    var model = 'unknown';
    var os = 'unknown';

    if (Platform.isAndroid) {
      final a = await info.androidInfo;
      model = '${a.manufacturer} ${a.model}';
      os = 'Android ${a.version.release}';
    } else if (Platform.isIOS) {
      final i = await info.iosInfo;
      model = i.utsname.machine;
      os = 'iOS ${i.systemVersion}';
    }

    return _cached = DeviceIdentity(
      installationId: id,
      model: model,
      osVersion: os,
    );
  }
}
