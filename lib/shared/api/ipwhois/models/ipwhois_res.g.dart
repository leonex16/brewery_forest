// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ipwhois_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IpWhoisRes _$IpWhoisResFromJson(Map<String, dynamic> json) => IpWhoisRes(
  ip: json['ip'] as String?,
  success: json['success'] as bool?,
  type: json['type'] as String?,
  continent: json['continent'] as String?,
  continentCode: json['continent_code'] as String?,
  country: json['country'] as String?,
  countryCode: json['country_code'] as String?,
  region: json['region'] as String?,
  regionCode: json['region_code'] as String?,
  city: json['city'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  isEu: json['is_eu'] as bool?,
  postal: json['postal'] as String?,
  callingCode: json['calling_code'] as String?,
  capital: json['capital'] as String?,
  borders: json['borders'] as String?,
  flag: json['flag'] == null
      ? null
      : Flag.fromJson(json['flag'] as Map<String, dynamic>),
  connection: json['connection'] == null
      ? null
      : Connection.fromJson(json['connection'] as Map<String, dynamic>),
  timezone: json['timezone'] == null
      ? null
      : Timezone.fromJson(json['timezone'] as Map<String, dynamic>),
  currency: json['currency'] == null
      ? null
      : Currency.fromJson(json['currency'] as Map<String, dynamic>),
  security: json['security'] == null
      ? null
      : Security.fromJson(json['security'] as Map<String, dynamic>),
  rate: json['rate'] == null
      ? null
      : Rate.fromJson(json['rate'] as Map<String, dynamic>),
);

Map<String, dynamic> _$IpWhoisResToJson(IpWhoisRes instance) =>
    <String, dynamic>{
      'ip': instance.ip,
      'success': instance.success,
      'type': instance.type,
      'continent': instance.continent,
      'continent_code': instance.continentCode,
      'country': instance.country,
      'country_code': instance.countryCode,
      'region': instance.region,
      'region_code': instance.regionCode,
      'city': instance.city,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'is_eu': instance.isEu,
      'postal': instance.postal,
      'calling_code': instance.callingCode,
      'capital': instance.capital,
      'borders': instance.borders,
      'flag': instance.flag,
      'connection': instance.connection,
      'timezone': instance.timezone,
      'currency': instance.currency,
      'security': instance.security,
      'rate': instance.rate,
    };

Connection _$ConnectionFromJson(Map<String, dynamic> json) => Connection(
  asn: (json['asn'] as num?)?.toInt(),
  org: json['org'] as String?,
  isp: json['isp'] as String?,
  domain: json['domain'] as String?,
);

Map<String, dynamic> _$ConnectionToJson(Connection instance) =>
    <String, dynamic>{
      'asn': instance.asn,
      'org': instance.org,
      'isp': instance.isp,
      'domain': instance.domain,
    };

Currency _$CurrencyFromJson(Map<String, dynamic> json) => Currency(
  name: json['name'] as String?,
  code: json['code'] as String?,
  symbol: json['symbol'] as String?,
  plural: json['plural'] as String?,
  exchangeRate: (json['exchange_rate'] as num?)?.toDouble(),
);

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
  'name': instance.name,
  'code': instance.code,
  'symbol': instance.symbol,
  'plural': instance.plural,
  'exchange_rate': instance.exchangeRate,
};

Flag _$FlagFromJson(Map<String, dynamic> json) => Flag(
  img: json['img'] as String?,
  emoji: json['emoji'] as String?,
  emojiUnicode: json['emoji_unicode'] as String?,
);

Map<String, dynamic> _$FlagToJson(Flag instance) => <String, dynamic>{
  'img': instance.img,
  'emoji': instance.emoji,
  'emoji_unicode': instance.emojiUnicode,
};

Rate _$RateFromJson(Map<String, dynamic> json) => Rate(
  limit: (json['limit'] as num?)?.toInt(),
  remaining: (json['remaining'] as num?)?.toInt(),
);

Map<String, dynamic> _$RateToJson(Rate instance) => <String, dynamic>{
  'limit': instance.limit,
  'remaining': instance.remaining,
};

Security _$SecurityFromJson(Map<String, dynamic> json) => Security(
  anonymous: json['anonymous'] as bool?,
  proxy: json['proxy'] as bool?,
  vpn: json['vpn'] as bool?,
  tor: json['tor'] as bool?,
  hosting: json['hosting'] as bool?,
);

Map<String, dynamic> _$SecurityToJson(Security instance) => <String, dynamic>{
  'anonymous': instance.anonymous,
  'proxy': instance.proxy,
  'vpn': instance.vpn,
  'tor': instance.tor,
  'hosting': instance.hosting,
};

Timezone _$TimezoneFromJson(Map<String, dynamic> json) => Timezone(
  id: json['id'] as String?,
  abbr: json['abbr'] as String?,
  isDst: json['is_dst'] as bool?,
  offset: (json['offset'] as num?)?.toInt(),
  utc: json['utc'] as String?,
  currentTime: json['current_time'] == null
      ? null
      : DateTime.parse(json['current_time'] as String),
);

Map<String, dynamic> _$TimezoneToJson(Timezone instance) => <String, dynamic>{
  'id': instance.id,
  'abbr': instance.abbr,
  'is_dst': instance.isDst,
  'offset': instance.offset,
  'utc': instance.utc,
  'current_time': instance.currentTime?.toIso8601String(),
};
