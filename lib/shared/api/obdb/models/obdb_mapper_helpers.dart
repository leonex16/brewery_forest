import 'package:brewery_forest/core/index.dart';

BreweryType parseBreweryType(String? type) {
  if (type == null) return BreweryType.unknown;
  switch (type.toLowerCase().trim()) {
    case 'brewpub':
      return BreweryType.brewpub;
    case 'closed':
      return BreweryType.closed;
    case 'large':
      return BreweryType.large;
    case 'micro':
      return BreweryType.micro;
    case 'proprietor':
      return BreweryType.proprietor;
    default:
      return BreweryType.unknown;
  }
}

List<String> parseAddressLines(
  String? address1,
  String? address2,
  String? address3,
) {
  return [address1, address2, address3].compact();
}
