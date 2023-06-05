import 'package:geo_monitor/library/data/position.dart';
import 'package:geo_monitor/library/data/timezone.dart';

import '../functions.dart';

class Country {
  String? name;

  String? countryId;

  int population = 0;
  //(4)
  Position? position;
  //(5)
  String? id;
  //
  //(6)
  String? capital;
  //(7)
  String? iso2;
  //(8)
  String? iso3;
  //(9)
  String? currency;
  //(10)
  String? currencyName;
  //(11)
  String? currencySymbol;
  //(12)
  String? region;
  //(13)
  String? subregion;
//
  //(14)
  double? latitude;
  //(15)
  double? longitude;
  //(16)
  String? emoji;
  //(17)//(18)

  Country({
    required this.name,
    required this.countryId,
    this.id,
    required this.population,
    required this.position,
    this.longitude,
    this.latitude,
    this.currency,
    this.capital,
    this.currencyName,
    this.currencySymbol,
    this.emoji,
    this.iso2,
    this.iso3,
    this.region,
    this.subregion,
  });

  Country.fromJson(Map data) {
    // pp(' Country.fromJson data: $data \n\n');
    name = data['name'];
    countryId = data['countryId'];
    id = data['id'];
    //
    longitude = data['longitude'];
    latitude = data['latitude'];
    currency = data['currency'];
    capital = data['capital'];
    currencyName = data['currency_name'];
    currencySymbol = data['currency_symbol'];
    emoji = data['emoji'];
    region = data['region'];
    iso2 = data['iso2'];
    iso3 = data['iso3'];
    subregion = data['subregion'];

    if (data['population'] != null) {
      population = data['population'];
    } else {
      population = 0;
    }
    if (data['position'] != null) {
      position = Position.fromJson(data['position']);
    }
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'name': name,
      'countryId': countryId,
      'id': id,
      'longitude': longitude,
      'latitude': latitude,
      'currency': currency,
      'capital': capital,
      'currencyName': currencyName,
      'currencySymbol': currencySymbol,
      'emoji': emoji,
      'region': region,
      'subregion': subregion,
      'iso2': iso2,
      'iso3': iso3,
      'population': population,
      'position': position == null ? null : position!.toJson(),
    };
    return map;
  }
}

/*
private String zoneName;
    private int gmtOffset;
    private String gmtOffsetName;
    private String abbreviation;
    private String tzName;
 */
