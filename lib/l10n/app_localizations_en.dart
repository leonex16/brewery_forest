// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get errInvalidBrewery => 'This brewery information is invalid';

  @override
  String get errInvalidCoordinates => 'This brewery has invalid location data';

  @override
  String get errInvalidContact => 'This brewery has no contact information';

  @override
  String get errNetwork => 'No internet connection';

  @override
  String get errServer => 'Something went wrong on our end';

  @override
  String get errParsing => 'We had trouble reading the data';

  @override
  String get errStorage => 'We had trouble saving your data';

  @override
  String get errLocationUnavailable => 'We couldn\'t get your location';

  @override
  String get errBreweryNotFound => 'We couldn\'t find that brewery';

  @override
  String get onboardingTitle => 'Enable location to see breweries near you';

  @override
  String get onboardingBody =>
      'We use your location only to find breweries near you. You can change this any time.';

  @override
  String get onboardingEnable => 'Enable location';

  @override
  String get onboardingExplore => 'Explore without location';

  @override
  String get onboardingPrivacy => 'Your data stays private';

  @override
  String get deniedTitle => 'No problem!';

  @override
  String get deniedBody =>
      'You can still explore breweries by searching manually, or enable location in your settings later to see what\'s nearby.';

  @override
  String get deniedOpenSettings => 'Open settings';

  @override
  String get deniedExplore => 'Explore without location';

  @override
  String get deniedPrivacyFirst => 'Privacy first';

  @override
  String get feedSearchHint => 'Search breweries...';

  @override
  String get feedEmptyTitle => 'No breweries found';

  @override
  String get feedEmptyBody => 'Try a different search or clear your filters.';

  @override
  String get feedClearFilters => 'Clear all filters';

  @override
  String get feedRetry => 'Retry';

  @override
  String get paginationEnd => 'You\'ve reached the end';

  @override
  String get fabSearchHere => 'Search on current location';

  @override
  String get searchMinChars => 'Type at least 3 characters to search';

  @override
  String locationBannerApproximate(String city, String country) {
    return 'Approximate location by IP: $city, $country';
  }

  @override
  String get locationBannerNone => 'We couldn\'t get your location';
}
