part of 'app_ex.dart';

sealed class DomainEx extends AppEx {
  DomainEx(super.message);
}

final class InvalidBreweryEx extends DomainEx {
  InvalidBreweryEx(super.message);
}

final class InvalidCoordinatesEx extends DomainEx {
  InvalidCoordinatesEx({String? latitude, String? longitude})
    : super(
        'latitude and longitude must be defined, got lat: $latitude, long: $longitude',
      );
}

final class InvalidContactEx extends DomainEx {
  InvalidContactEx() : super('phone and websiteUrl must be defined');
}
