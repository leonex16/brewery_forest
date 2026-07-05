String? countryCodeFromName(String? name) {
  if (name == null) return null;
  switch (name.trim().toLowerCase()) {
    case 'united states':
    case 'united states of america':
    case 'usa':
      return 'us';
    case 'united kingdom':
    case 'england':
    case 'scotland':
    case 'wales':
    case 'northern ireland':
    case 'isle of man':
      return 'gb';
    case 'ireland':
      return 'ie';
    case 'france':
      return 'fr';
    case 'germany':
      return 'de';
    case 'austria':
      return 'at';
    case 'poland':
      return 'pl';
    case 'portugal':
      return 'pt';
    case 'spain':
      return 'es';
    case 'italy':
      return 'it';
    case 'netherlands':
      return 'nl';
    case 'belgium':
      return 'be';
    case 'switzerland':
      return 'ch';
    case 'czech republic':
    case 'czechia':
      return 'cz';
    case 'australia':
      return 'au';
    case 'new zealand':
      return 'nz';
    case 'south korea':
      return 'kr';
    case 'singapore':
      return 'sg';
    case 'japan':
      return 'jp';
    case 'china':
      return 'cn';
    case 'canada':
      return 'ca';
    case 'brazil':
      return 'br';
    case 'mexico':
      return 'mx';
    case 'south africa':
      return 'za';
    default:
      return null;
  }
}

String? flagImageUrl(String? code) {
  if (code == null || code.isEmpty) return null;
  return 'https://flagcdn.com/w80/${code.toLowerCase()}.png';
}
