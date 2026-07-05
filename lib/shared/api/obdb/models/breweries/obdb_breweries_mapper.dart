import 'package:brewery_forest/core/index.dart';
import 'package:brewery_forest/shared/api/obdb/models/breweries/obdb_breweries_res.dart'
    as res;
import 'package:brewery_forest/shared/api/obdb/models/obdb_mapper_helpers.dart';

extension ObdbBreweriesMapper on res.ObdbBreweriesRes {
  Brewery toEntity() {
    return Brewery.raw(
      id: id,
      name: name,
      breweryType: parseBreweryType(breweryType),
      addressLines: parseAddressLines(address1, address2, address3),
      city: city,
      stateProvince: stateProvince ?? state,
      postalCode: postalCode,
      country: country,
      countryCode: countryCodeFromName(country),
      latitude: latitude,
      longitude: longitude,
      phone: phone,
      websiteUrl: websiteUrl,
    );
  }
}
