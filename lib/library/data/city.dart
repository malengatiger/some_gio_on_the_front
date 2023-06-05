import 'package:geo_monitor/library/data/position.dart';

/*
private String _id;
    private String name;
    private String cityId;
    private String country;
    private String countryId;
    private String stateId;
    private String stateName;
    private String countryName;
    private String province;
    private Position position;
    private double latitude;
    private double longitude;
 */
// @HiveType(typeId: 7)
class City  {
  //(0)
  String? name;
  //(1)
  String? countryId;
  //(2)
  String? country;
  //(3)
  String? province;
  //(4)
  String? cityId;
  //(5)
  String? created;
  //(6)
  Position? position;
  //(7)
  String? id;
  //(8)
  double? latitude;
  //(9)
  double? longitude;
  String? stateId;
  String? stateName;
  String? countryName;

  City(
      {required this.name,
      required this.countryId,
      required this.province,
      required this.country,
      this.id,
      this.latitude,
      this.longitude,
      required this.position,
        required this.stateName,
        required this.countryName,
      required this.stateId});

  City.fromJson(Map data) {
    name = data['name'];
    countryId = data['countryId'];
    country = data['country'];
    province = data['province'];
    stateName = data['stateName'];
    latitude = data['latitude'];
    longitude = data['longitude'];
    countryName = data['countryName'];
    stateId = data['stateId'];
    id = data['id'];
    cityId = data['cityId'];
    if (data['position'] != null) {
      position = Position.fromJson(data['position']);
    }
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'name': name,
      'countryId': countryId,
      'country': country,
      'province': province,
      'cityId': cityId,
      'latitude': latitude,
      'longitude': longitude,
      'id': id,
      'stateId': stateId,
      'countryName': countryName,
      'stateName': stateName,
      'position': position == null ? null : position!.toJson(),
    };
    return map;
  }
}
