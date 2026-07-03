import 'package:brewery_forest/core/index.dart';
import 'package:brewery_forest/shared/api/obdb/models/search/obdb_search_res.dart';
import 'package:brewery_forest/shared/api/obdb/models/obdb_mapper_helpers.dart';

extension ObdbSearchMapper on ObdbSearchRes {
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
      latitude: latitude,
      longitude: longitude,
      phone: phone,
      websiteUrl: websiteUrl,
    );
  }
}
