import 'package:brewery_forest/core/domain/ip_location.dart';
import 'package:brewery_forest/shared/api/ipwhois/models/ipwhois_res.dart';

extension IpWhoisMapper on IpWhoisRes {
  /// Maps the ipwho.is DTO to the [IpLocation] domain entity. Returns null when
  /// the lookup was unsuccessful; a successful response with missing coordinates
  /// makes [IpLocation.raw] throw InvalidCoordinatesEx (handled by the repository).
  IpLocation? toEntity() {
    if (success != true) return null;

    return IpLocation.raw(
      latitude: latitude,
      longitude: longitude,
      ip: ip,
      city: city,
      region: region,
      country: country,
      countryCode: countryCode,
      flagEmoji: flag?.emoji,
      isp: connection?.isp,
      timezone: timezone?.id,
    );
  }
}
