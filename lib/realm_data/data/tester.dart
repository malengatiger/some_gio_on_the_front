import 'package:geo_monitor/realm_data/data/schemas.dart';
import 'package:realm/realm.dart';

import '../../main.dart';

void createCities() async {
  print('starting ...');


  // realm.deleteAll();

  var city1 = City(id: ObjectId(),cityId: 'city001', name: 'Harties', cityLocation: Position(coordinates: [0.0,0.1], type: 'Point'));
  var city2 = City(id: ObjectId(),cityId: 'city002', name: 'Brits', cityLocation: Position(coordinates: [0.0,0.1], type: 'Point'));
  var city3 = City(id: ObjectId(),cityId: 'city003', name: 'Fourways', cityLocation: Position(coordinates: [0.0,0.1], type: 'Point'));
  var city4 = City(id: ObjectId(),cityId: 'city004', name: 'Sandton', cityLocation: Position(coordinates: [0.0,0.1], type: 'Point'));
  var city5 = City(id: ObjectId(),cityId: 'city005', name: 'Harties', cityLocation: Position(coordinates: [0.0,0.1], type: 'Point'));

  var appError = AppError(id: ObjectId(), errorMessage: 'error message', manufacturer: 'Samsung', model: 'S20');

  realm.write(() {
    realm.add(city1);
  });
  realm.write(() {
    realm.add(city2);
  });
  realm.write(() {
    realm.add(city3);
  });
  realm.write(() {
    realm.add(city4);
  });
  realm.write(() {
    realm.add(city5);
  });


  realm.write(() {
    realm.add(appError);
  });

}

List<City> getCities() {
  final cities = realm.all<City>();
  for (var value in cities) {
    print('🥬🥬🥬 ... city: ${value.name} ${value.cityLocation?.coordinates}');
  }
  return cities.toList();
}
List<AppError> getAppErrors() {
  final errors = realm.all<AppError>();
  for (var value in errors) {
    print('🍎🍎🍎 ... error: ${value.errorMessage} ${value.manufacturer}');
  }
  return errors.toList();
}