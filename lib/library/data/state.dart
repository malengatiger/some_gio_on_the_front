import 'package:geo_monitor/library/data/position.dart';

class CountryState  {
  String? name;
  String? countryId;

  String? stateCode;
  Position? position;
  String? id;
  double? latitude;
  double? longitude;
  String? stateId;
  String? countryName;

  CountryState(
      {required this.name,
        required this.countryId,
        this.id,
        this.latitude,
        this.longitude, this.stateCode,
        required this.position,
        required this.countryName,
        required this.stateId});

  CountryState.fromJson(Map data) {
    name = data['name'];
    countryId = data['countryId'];
    stateCode = data['stateCode'];
    latitude = data['latitude'];
    longitude = data['longitude'];
    countryName = data['countryName'];
    stateId = data['stateId'];
    id = data['id'];
    if (data['position'] != null) {
      position = Position.fromJson(data['position']);
    }
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'name': name,
      'countryId': countryId,
      'stateCode': stateCode,
      'latitude': latitude,
      'longitude': longitude,
      'id': id,
      'stateId': stateId,
      'countryName': countryName,
      'position': position == null ? null : position!.toJson(),
    };
    return map;
  }
}
