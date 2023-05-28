import 'package:geo_monitor/realm_data/data/schemas.dart';
import 'package:realm/realm.dart' as rm;

import '../../generic_utils/functions.dart';

final config = rm.Configuration.local([
  City.schema,
  Position.schema,
  AppError.schema,
  Organization.schema,
  Project.schema,
  ProjectPolygon.schema,
  ProjectPosition.schema,
  User.schema,
  Photo.schema,
  Video.schema,
  Audio.schema,
  GeofenceEvent.schema,
  LocationRequest.schema,
  LocationResponse.schema,
  SettingsModel.schema, Country.schema,
  FieldMonitorSchedule.schema,
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


  void addActivity(ActivityModel activity) {
    realm.write(() {
      realm.add(activity);
    });
    px('$mm activity added: ${activity.date}');

  }

  void addGeofenceEvent(GeofenceEvent geofenceEvent) {
    realm.write(() {
      realm.add(geofenceEvent);
    });
    px('$mm geofenceEvent added: ${geofenceEvent.date}');

  }
  void addRating(Rating rating) {
    realm.write(() {
      realm.add(rating);
    });
    px('$mm rating added: ${rating.created}');

  }
  void addSettings(SettingsModel settings) {
    realm.write(() {
      realm.add(settings);
    });
    px('$mm settings added: ${settings.created}');

  }
  void addPhoto(Photo photo) {
    realm.write(() {
      realm.add(photo);
    });
    px('$mm photo added: ${photo.created}');

  }
  void addVideo(Video video) {
    realm.write(() {
      realm.add(video);
    });
    px('$mm video added: ${video.created}');

  }
  void addAudio(Audio audio) {
    realm.write(() {
      realm.add(audio);
    });
    px('$mm audio added: ${audio.created}');
  }
  void addProjectPosition(ProjectPosition projectPosition) {
    realm.write(() {
      realm.add(projectPosition);
    });
    px('$mm project position added: ${projectPosition.name}');
  }
  void addProjectPolygon(ProjectPolygon projectPolygon) {
    realm.write(() {
      realm.add(projectPolygon);
    });
    px('$mm project polygon added: ${projectPolygon.name}');
  }
  void addProject(Project project) {
    realm.write(() {
      realm.add(project);
    });
    px('$mm project added: ${project.name}');
  }
  void addUser(User user) {
    realm.write(() {
      realm.add(user);
    });
    px('$mm user added: ${user.name}');
  }
  void addOrganization(Organization organization) {
    realm.write(() {
      realm.add(organization);
    });
    px('$mm organization added: ${organization.name}');
  }
  void addCountry(Country country) {
    realm.write(() {
      realm.add(country);
    });
    px('$mm country added: ${country.name}');
  }
  List<Country> getCountries() {
    final result = realm.all<Country>();
    px('$mm countries found: ${result.length}');
    return result.toList();
  }
}


