import 'package:brewery_forest/core/errors/app_ex.dart';

enum BreweryType { unknown, brewpub, closed, large, micro, proprietor }

final class GeoCoordinates {
  final double latitude;
  final double longitude;

  const GeoCoordinates._(this.latitude, this.longitude);

  factory GeoCoordinates.raw({
    required double? latitude,
    required double? longitude,
  }) {
    if (latitude == null || longitude == null) {
      throw InvalidCoordinatesEx();
    }

    return GeoCoordinates._(latitude, longitude);
  }
}

final class Address {
  final List<String> lines;
  final String? city;
  final String? stateProvince;
  final String? postalCode;
  final String? country;
  final GeoCoordinates coordinates;

  const Address({
    this.lines = const [],
    this.city,
    this.stateProvince,
    this.postalCode,
    this.country,
    required this.coordinates,
  });

  @override
  String toString() => 'Address(${lines.join(', ')}, $city, $country)';
}

final class ContactInfo {
  final String? phone;
  final String? websiteUrl;

  const ContactInfo._({this.phone, this.websiteUrl});

  factory ContactInfo.raw({String? phone, String? websiteUrl}) {
    if (phone == null && websiteUrl == null) {
      throw InvalidContactEx();
    }
    return ContactInfo._(phone: phone, websiteUrl: websiteUrl);
  }
}

final class Brewery {
  final String id;
  final String name;
  final BreweryType breweryType;
  final Address? address;
  final ContactInfo contact;

  const Brewery._({
    required this.id,
    required this.name,
    required this.breweryType,
    required this.address,
    required this.contact,
  });

  factory Brewery.raw({
    required String? id,
    required String? name,
    BreweryType breweryType = BreweryType.unknown,
    List<String> addressLines = const [],
    String? city,
    String? stateProvince,
    String? postalCode,
    String? country,
    double? latitude,
    double? longitude,
    String? phone,
    String? websiteUrl,
  }) {
    if (id == null || id.isEmpty) {
      throw InvalidBreweryEx('id must be defined and non-empty');
    }
    if (name == null || name.isEmpty) {
      throw InvalidBreweryEx('name must be defined and non-empty');
    }

    final address = (latitude != null || longitude != null)
        ? Address(
            lines: addressLines,
            city: city,
            stateProvince: stateProvince,
            postalCode: postalCode,
            country: country,
            coordinates: GeoCoordinates.raw(
              latitude: latitude,
              longitude: longitude,
            ),
          )
        : null;

    return Brewery._(
      id: id,
      name: name,
      breweryType: breweryType,
      address: address,
      contact: ContactInfo.raw(phone: phone, websiteUrl: websiteUrl),
    );
  }
}
