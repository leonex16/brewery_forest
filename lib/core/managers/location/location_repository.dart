import 'package:brewery_forest/core/index.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

abstract class LocationRepository {
  Future<LocationAccess> checkPermission();
  Future<LocationAccess> requestPermission();
  Future<GeoCoordinates> getPosition();
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

  @override
  Future<GeoCoordinates> getPosition() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: .high),
      );
      return GeoCoordinates.raw(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (e) {
      throw LocationUnavailableEx(cause: e);
    }
  }
}
