import 'package:brewery_forest/core/managers/location/location_permission_state.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

abstract class LocationRepository {
  Future<LocationAccess> checkPermission();
  Future<LocationAccess> requestPermission();
}

@LazySingleton(as: LocationRepository)
class GeolocatorLocationRepository implements LocationRepository {
  @override
  Future<LocationAccess> checkPermission() async {
    final isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) return LocationServiceDisabled();

    final permission = await Geolocator.checkPermission();
    return _map(permission);
  }

  @override
  Future<LocationAccess> requestPermission() async {
    final isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) return LocationServiceDisabled();

    final permission = await Geolocator.requestPermission();
    return _map(permission);
  }

  LocationAccess _map(LocationPermission permission) => switch (permission) {
    LocationPermission.always ||
    LocationPermission.whileInUse => LocationGranted(),
    LocationPermission.deniedForever => LocationDeniedForever(),
    LocationPermission.denied ||
    LocationPermission.unableToDetermine => LocationDenied(),
  };
}
