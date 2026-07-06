import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:brewery_forest/core/index.dart';
import 'package:geolocator/geolocator.dart';

import 'package:injectable/injectable.dart';

typedef LocationOnboardingState = LocationAccess;

@injectable
class LocationOnboardingCubit extends Cubit<LocationOnboardingState> {
  final LocationRepository _locationRepository;

  LocationOnboardingCubit(this._locationRepository)
    : super(LocationChecking()) {
    _checkAccess();
  }

  Future<void> recheck() async {
    final result = await _locationRepository.checkPermission();

    if (state is LocationDeniedForever && result is LocationDenied) return;

    emit(result);
  }

  Future<void> _checkAccess() async =>
      emit(await _locationRepository.checkPermission());

  Future<void> requestPermission() async {
    final state = await _locationRepository.requestPermission();

    emit(state);
  }

  Future<bool> openAppSettings() => Geolocator.openAppSettings();

  Future<bool> openLocationSettings() => Geolocator.openLocationSettings();
}
