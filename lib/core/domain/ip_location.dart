import 'package:brewery_forest/core/domain/brewery.dart';

/// Approximate location resolved from the device's public IP (ipwho.is).
/// Enriched domain entity: keeps the fields the app finds valuable, decoupled
/// from the provider's raw JSON. Built via [IpLocation.raw], which enforces the
/// coordinates invariant (throws InvalidCoordinatesEx when they are missing).
final class IpLocation {
  final String? ip;
  final String? city;
  final String? region;
  final String? country;
  final String? countryCode;
  final GeoCoordinates coordinates;
  final String? flagEmoji;
  final String? isp;
  final String? timezone;

  const IpLocation._({
    required this.coordinates,
    this.ip,
    this.city,
    this.region,
    this.country,
    this.countryCode,
    this.flagEmoji,
    this.isp,
    this.timezone,
  });

  factory IpLocation.raw({
    required double? latitude,
    required double? longitude,
    String? ip,
    String? city,
    String? region,
    String? country,
    String? countryCode,
    String? flagEmoji,
    String? isp,
    String? timezone,
  }) {
    return IpLocation._(
      coordinates: GeoCoordinates.raw(latitude: latitude, longitude: longitude),
      ip: ip,
      city: city,
      region: region,
      country: country,
      countryCode: countryCode,
      flagEmoji: flagEmoji,
      isp: isp,
      timezone: timezone,
    );
  }
}
