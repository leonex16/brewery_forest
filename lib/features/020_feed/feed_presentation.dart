import 'package:brewery_forest/core/index.dart';

/// Builds the feed's location banner copy from the resolved location state.
/// Presentation concern (mirrors `userMessage`): keeps the copy out of the
/// widget and out of the Cubit. The place composition lives on `IpLocation`
/// (`placeLabel`); this only assembles the final banner text. Returns null when
/// no banner should show (precise GPS location).
String? locationBannerMessage(LocationSource source, IpLocation? ip) {
  switch (source) {
    case LocationSource.precise:
      return null;
    case LocationSource.none:
      return 'Location unavailable';
    case LocationSource.approximate:
      final suffix = [ip?.placeLabel, ip?.flagEmoji].joinNonEmpty(' ');
      return suffix == null
          ? 'Approximate location by IP'
          : 'Approximate location by IP: $suffix';
  }
}
