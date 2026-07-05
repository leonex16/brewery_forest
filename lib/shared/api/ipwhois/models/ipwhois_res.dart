import 'package:freezed_annotation/freezed_annotation.dart';

part 'ipwhois_res.g.dart';

@JsonSerializable()
class IpWhoisRes {
  @JsonKey(name: "ip")
  final String? ip;
  @JsonKey(name: "success")
  final bool? success;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "continent")
  final String? continent;
  @JsonKey(name: "continent_code")
  final String? continentCode;
  @JsonKey(name: "country")
  final String? country;
  @JsonKey(name: "country_code")
  final String? countryCode;
  @JsonKey(name: "region")
  final String? region;
  @JsonKey(name: "region_code")
  final String? regionCode;
  @JsonKey(name: "city")
  final String? city;
  @JsonKey(name: "latitude")
  final double? latitude;
  @JsonKey(name: "longitude")
  final double? longitude;
  @JsonKey(name: "is_eu")
  final bool? isEu;
  @JsonKey(name: "postal")
  final String? postal;
  @JsonKey(name: "calling_code")
  final String? callingCode;
  @JsonKey(name: "capital")
  final String? capital;
  @JsonKey(name: "borders")
  final String? borders;
  @JsonKey(name: "flag")
  final Flag? flag;
  @JsonKey(name: "connection")
  final Connection? connection;
  @JsonKey(name: "timezone")
  final Timezone? timezone;
  @JsonKey(name: "currency")
  final Currency? currency;
  @JsonKey(name: "security")
  final Security? security;
  @JsonKey(name: "rate")
  final Rate? rate;

  IpWhoisRes({
    this.ip,
    this.success,
    this.type,
    this.continent,
    this.continentCode,
    this.country,
    this.countryCode,
    this.region,
    this.regionCode,
    this.city,
    this.latitude,
    this.longitude,
    this.isEu,
    this.postal,
    this.callingCode,
    this.capital,
    this.borders,
    this.flag,
    this.connection,
    this.timezone,
    this.currency,
    this.security,
    this.rate,
  });

  factory IpWhoisRes.fromJson(Map<String, dynamic> json) =>
      _$IpWhoisResFromJson(json);

  Map<String, dynamic> toJson() => _$IpWhoisResToJson(this);
}

@JsonSerializable()
class Connection {
  @JsonKey(name: "asn")
  final int? asn;
  @JsonKey(name: "org")
  final String? org;
  @JsonKey(name: "isp")
  final String? isp;
  @JsonKey(name: "domain")
  final String? domain;

  Connection({this.asn, this.org, this.isp, this.domain});

  factory Connection.fromJson(Map<String, dynamic> json) =>
      _$ConnectionFromJson(json);

  Map<String, dynamic> toJson() => _$ConnectionToJson(this);
}

@JsonSerializable()
class Currency {
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "code")
  final String? code;
  @JsonKey(name: "symbol")
  final String? symbol;
  @JsonKey(name: "plural")
  final String? plural;
  @JsonKey(name: "exchange_rate")
  final double? exchangeRate;

  Currency({this.name, this.code, this.symbol, this.plural, this.exchangeRate});

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyToJson(this);
}

@JsonSerializable()
class Flag {
  @JsonKey(name: "img")
  final String? img;
  @JsonKey(name: "emoji")
  final String? emoji;
  @JsonKey(name: "emoji_unicode")
  final String? emojiUnicode;

  Flag({this.img, this.emoji, this.emojiUnicode});

  factory Flag.fromJson(Map<String, dynamic> json) => _$FlagFromJson(json);

  Map<String, dynamic> toJson() => _$FlagToJson(this);
}

@JsonSerializable()
class Rate {
  @JsonKey(name: "limit")
  final int? limit;
  @JsonKey(name: "remaining")
  final int? remaining;

  Rate({this.limit, this.remaining});

  factory Rate.fromJson(Map<String, dynamic> json) => _$RateFromJson(json);

  Map<String, dynamic> toJson() => _$RateToJson(this);
}

@JsonSerializable()
class Security {
  @JsonKey(name: "anonymous")
  final bool? anonymous;
  @JsonKey(name: "proxy")
  final bool? proxy;
  @JsonKey(name: "vpn")
  final bool? vpn;
  @JsonKey(name: "tor")
  final bool? tor;
  @JsonKey(name: "hosting")
  final bool? hosting;

  Security({this.anonymous, this.proxy, this.vpn, this.tor, this.hosting});

  factory Security.fromJson(Map<String, dynamic> json) =>
      _$SecurityFromJson(json);

  Map<String, dynamic> toJson() => _$SecurityToJson(this);
}

@JsonSerializable()
class Timezone {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "abbr")
  final String? abbr;
  @JsonKey(name: "is_dst")
  final bool? isDst;
  @JsonKey(name: "offset")
  final int? offset;
  @JsonKey(name: "utc")
  final String? utc;
  @JsonKey(name: "current_time")
  final DateTime? currentTime;

  Timezone({
    this.id,
    this.abbr,
    this.isDst,
    this.offset,
    this.utc,
    this.currentTime,
  });

  factory Timezone.fromJson(Map<String, dynamic> json) =>
      _$TimezoneFromJson(json);

  Map<String, dynamic> toJson() => _$TimezoneToJson(this);
}
