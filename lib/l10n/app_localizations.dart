import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// InvalidBreweryEx: brewery failed domain validation
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t read this brewery\'s details'**
  String get errInvalidBrewery;

  /// InvalidCoordinatesEx: brewery coordinates are missing/invalid
  ///
  /// In en, this message translates to:
  /// **'This brewery is missing location data'**
  String get errInvalidCoordinates;

  /// InvalidContactEx: brewery has no usable contact data
  ///
  /// In en, this message translates to:
  /// **'This brewery has no contact info yet'**
  String get errInvalidContact;

  /// NetworkEx: device is offline / request never left
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get errNetwork;

  /// ServerEx: backend returned an error status
  ///
  /// In en, this message translates to:
  /// **'Something went wrong on our end'**
  String get errServer;

  /// ParsingEx: response body could not be deserialized
  ///
  /// In en, this message translates to:
  /// **'We had trouble reading the data'**
  String get errParsing;

  /// StorageEx: local persistence failed
  ///
  /// In en, this message translates to:
  /// **'We had trouble saving your data'**
  String get errStorage;

  /// LocationUnavailableEx: could not resolve device location
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t get your location'**
  String get errLocationUnavailable;

  /// BreweryNotFoundEx: requested brewery id does not exist
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find that brewery'**
  String get errBreweryNotFound;

  /// Onboarding: headline inviting the user to enable location
  ///
  /// In en, this message translates to:
  /// **'Enable location to see breweries near you'**
  String get onboardingTitle;

  /// Onboarding: supporting body under the headline
  ///
  /// In en, this message translates to:
  /// **'We use your location only to find breweries near you. You can change this any time.'**
  String get onboardingBody;

  /// Onboarding: primary button that requests the OS permission
  ///
  /// In en, this message translates to:
  /// **'Enable location'**
  String get onboardingEnable;

  /// Onboarding: secondary action to skip and browse anyway
  ///
  /// In en, this message translates to:
  /// **'Explore without location'**
  String get onboardingExplore;

  /// Onboarding: reassurance line about privacy
  ///
  /// In en, this message translates to:
  /// **'Your data stays private'**
  String get onboardingPrivacy;

  /// Permission-denied screen: friendly headline
  ///
  /// In en, this message translates to:
  /// **'No problem!'**
  String get deniedTitle;

  /// Permission-denied screen: explains the fallbacks available
  ///
  /// In en, this message translates to:
  /// **'You can still explore breweries by searching manually, or enable location in your settings later to see what\'s nearby.'**
  String get deniedBody;

  /// Permission-denied screen: opens OS/app settings
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get deniedOpenSettings;

  /// Permission-denied screen: skip and browse anyway
  ///
  /// In en, this message translates to:
  /// **'Explore without location'**
  String get deniedExplore;

  /// Permission-denied screen: reassurance line
  ///
  /// In en, this message translates to:
  /// **'Privacy first'**
  String get deniedPrivacyFirst;

  /// Feed: placeholder text inside the search field
  ///
  /// In en, this message translates to:
  /// **'Search breweries...'**
  String get feedSearchHint;

  /// Feed/search: empty-state headline when no results
  ///
  /// In en, this message translates to:
  /// **'No breweries found'**
  String get feedEmptyTitle;

  /// Feed: empty-state supporting body
  ///
  /// In en, this message translates to:
  /// **'Try moving the map or searching another area.'**
  String get feedEmptyBody;

  /// Feed map pill: re-search around the current map center
  ///
  /// In en, this message translates to:
  /// **'Search in this area'**
  String get searchThisArea;

  /// Feed: retry action (pagination error, feed error)
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get feedRetry;

  /// Feed: footer shown when there are no more pages
  ///
  /// In en, this message translates to:
  /// **'That\'s all for now'**
  String get paginationEnd;

  /// Feed: FAB tooltip/label to re-search at the user's current location
  ///
  /// In en, this message translates to:
  /// **'Search near you'**
  String get fabSearchHere;

  /// Search: hint shown when the query is too short
  ///
  /// In en, this message translates to:
  /// **'Type at least 5 characters to search'**
  String get searchMinChars;

  /// Floating brewery card: opens the full detail
  ///
  /// In en, this message translates to:
  /// **'View details'**
  String get breweryCardCta;

  /// Feed banner: location came from IP geolocation, with resolved place
  ///
  /// In en, this message translates to:
  /// **'Approximate location: {city}, {country}'**
  String locationBannerApproximate(String city, String country);

  /// Feed banner: no location at all (neither GPS nor IP)
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t get your location'**
  String get locationBannerNone;

  /// No description provided for @detailLoading.
  ///
  /// In en, this message translates to:
  /// **'Brewing details…'**
  String get detailLoading;

  /// No description provided for @detailAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get detailAddress;

  /// No description provided for @detailPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get detailPhone;

  /// No description provided for @detailWebsite.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get detailWebsite;

  /// No description provided for @detailErrorBody.
  ///
  /// In en, this message translates to:
  /// **'We\'re having trouble loading the brewery details. Please try again.'**
  String get detailErrorBody;

  /// No description provided for @detailGoHome.
  ///
  /// In en, this message translates to:
  /// **'Back to breweries'**
  String get detailGoHome;

  /// No description provided for @detailDiagnosticTitle.
  ///
  /// In en, this message translates to:
  /// **'We hit a snag loading the cellar.'**
  String get detailDiagnosticTitle;

  /// No description provided for @detailDiagnosticBody.
  ///
  /// In en, this message translates to:
  /// **'Our team has been notified. We\'re working to get the taps flowing again.'**
  String get detailDiagnosticBody;

  /// No description provided for @detailTryRefreshing.
  ///
  /// In en, this message translates to:
  /// **'Try refreshing'**
  String get detailTryRefreshing;

  /// No description provided for @detailLaunchError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open that link'**
  String get detailLaunchError;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
