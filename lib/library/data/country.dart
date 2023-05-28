import 'package:geo_monitor/library/data/position.dart';
import 'package:hive/hive.dart';

part 'country.g.dart';

@HiveType(typeId: 1)
class Country extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? countryId;

  @HiveField(2)
  String? countryCode;

  @HiveField(3)
  int population = 0;
  @HiveField(4)
  Position? position;

  Country(
      {required this.name,
        required this.countryId,
        required this.population,
        required this.position,
        required this.countryCode});

  Country.fromJson(Map data) {
    name = data['name'];
    countryId = data['countryId'];
    countryCode = data['countryCode'];
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
      'countryCode': countryCode,
      'population':  population,
      'position': position == null? null: position!.toJson(),
    };
    return map;
  }
}
