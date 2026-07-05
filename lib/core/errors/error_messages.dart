import 'package:brewery_forest/core/index.dart';

String userMessage(AppEx error) => switch (error) {
  // DomainEx
  InvalidBreweryEx() => 'This brewery information is invalid',
  InvalidCoordinatesEx() => 'This brewery has invalid location data',
  InvalidContactEx() => 'This brewery has no contact information',

  // InfraEx
  NetworkEx() => 'No internet connection',
  ServerEx() => 'Something went wrong on our end',
  ParsingEx() => 'We had trouble reading the data',
  StorageEx() => 'We had trouble saving your data',
  LocationUnavailableEx() => 'We couldn\'t get your location',

  // AppEx
  BreweryNotFoundEx() => 'We couldn\'t find that brewery',
};
