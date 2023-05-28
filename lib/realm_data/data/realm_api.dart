import 'package:geo_monitor/realm_data/data/schemas.dart' as mrm;
import 'package:realm/realm.dart' as rm;
import 'package:geo_monitor/library/data/country.dart' as data;
import 'package:geo_monitor/library/data/activity_model.dart' as data;
import 'package:geo_monitor/library/data/organization.dart' as data;
import 'package:geo_monitor/library/data/geofence_event.dart' as data;
import 'package:geo_monitor/library/data/photo.dart' as data;
import 'package:geo_monitor/library/data/audio.dart' as data;
import 'package:geo_monitor/library/data/video.dart' as data;
import 'package:geo_monitor/library/data/settings_model.dart' as data;







import '../../generic_utils/functions.dart';
import '../../library/data/position.dart' as data;

final config = rm.Configuration.local([
  mrm.City.schema,
  mrm.Position.schema,
  mrm.AppError.schema,
  mrm.Organization.schema,
  mrm.Project.schema,
  mrm.ProjectPolygon.schema,
  mrm.ProjectPosition.schema,
  mrm.User.schema,
  mrm.Photo.schema,
  mrm.Video.schema,
  mrm.Audio.schema,
  mrm.GeofenceEvent.schema,
  mrm.LocationRequest.schema,
  mrm.LocationResponse.schema,
  mrm.SettingsModel.schema,
  mrm.Country.schema,
  mrm.FieldMonitorSchedule.schema,
], schemaVersion: 0, initialDataCallback: initialDataCallback);

final realm = rm.Realm(config);

late RealmApi realmApi;

void initialDataCallback(rm.Realm realm) {
  px('🍎🍎🍎🍎🍎 initialDataCallback ... 🍎do something on initial start up!');
}

class RealmApi {
  final mm = '🌎🌎🌎🌎🌎🌎 RealmApi 🌎';
  final rm.Realm realm;

  RealmApi(this.realm);

  // void addActivity(data.ActivityModel d) {
  //
  //   realm.write(() {
  //     realm.add(activity);
  //   });
  //   px('$mm activity added: ${activity.date}');
  // }
  //
  // void addGeofenceEvent(mrm.GeofenceEvent geofenceEvent) {
  //   realm.write(() {
  //     realm.add(geofenceEvent);
  //   });
  //   px('$mm geofenceEvent added: ${geofenceEvent.date}');
  // }
  //
  // void addRating(mrm.Rating rating) {
  //   realm.write(() {
  //     realm.add(rating);
  //   });
  //   px('$mm rating added: ${rating.created}');
  // }
  //
  // void addSettings(SettingsModel settings) {
  //   realm.write(() {
  //     realm.add(settings);
  //   });
  //   px('$mm settings added: ${settings.created}');
  // }
  //
  // void addPhoto(Photo photo) {
  //   realm.write(() {
  //     realm.add(photo);
  //   });
  //   px('$mm photo added: ${photo.created}');
  // }
  //
  // void addVideo(Video video) {
  //   realm.write(() {
  //     realm.add(video);
  //   });
  //   px('$mm video added: ${video.created}');
  // }
  //
  // void addAudio(Audio audio) {
  //   realm.write(() {
  //     realm.add(audio);
  //   });
  //   px('$mm audio added: ${audio.created}');
  // }
  //
  // void addProjectPosition(ProjectPosition projectPosition) {
  //   realm.write(() {
  //     realm.add(projectPosition);
  //   });
  //   px('$mm project position added: ${projectPosition.name}');
  // }
  //
  // void addProjectPolygon(ProjectPolygon projectPolygon) {
  //   realm.write(() {
  //     realm.add(projectPolygon);
  //   });
  //   px('$mm project polygon added: ${projectPolygon.name}');
  // }
  //
  // void addProject(Project project) {
  //   realm.write(() {
  //     realm.add(project);
  //   });
  //   px('$mm project added: ${project.name}');
  // }
  //
  // void addUser(User user) {
  //   realm.write(() {
  //     realm.add(user);
  //   });
  //   px('$mm user added: ${user.name}');
  // }
  //
  // void addOrganization(Organization organization) {
  //   realm.write(() {
  //     realm.add(organization);
  //   });
  //   px('$mm organization added: ${organization.name}');
  // }
  //
  // void addCountry(data.Country country) {
  //   var data = Country(
  //       countryId: country.countryId,
  //       name: country.name,
  //       countryCode: country.countryCode,
  //       position: Position(
  //           type: 'Point', coordinates: country.position!.coordinates));
  //   realm.write(() {
  //     realm.add(data);
  //   });
  //   px('$mm country added to Realm: ${country.name}');
  // }
  //
  // List<data.Country> getCountries() {
  //   final result = realm.all<Country>();
  //   var list = <data.Country>[];
  //   for (var value in result.toList()) {
  //     var c = data.Country(
  //         countryId: value.countryId,
  //         name: value.name,
  //         countryCode: value.countryCode,
  //         population: value.population!,
  //         position: data.Position(
  //           type: 'Point',
  //           coordinates: value.position!.coordinates,
  //         ));
  //     list.add(c);
  //   }
  //   px('$mm countries found in Realm: ${list.length}');
  //
  //   return list;
  // }
}
