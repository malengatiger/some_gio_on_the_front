import 'package:geo_monitor/library/bloc/geo_exception.dart';
import 'package:geo_monitor/library/emojis.dart';
import 'package:geo_monitor/library/errors/error_handler.dart';
import 'package:geo_monitor/library/functions.dart';
import 'package:geo_monitor/realm_data/data/schemas.dart' as mrm;
import 'package:realm/realm.dart' as rm;
import 'package:realm/realm.dart';

import '../../generic_utils/functions.dart';

const realmAppId = 'gio-0-htnzo';
const realmPublicKey = 'xtffryvl';
const privateKey = 'ff87d3e1-6366-4a9c-9ae0-8065540a8483';

late RealmSyncApi realmSyncApi;
late rm.User realmUser;
late rm.App app;
final schemas = [
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
  mrm.ActivityModel.schema,
  mrm.OrgMessage.schema,
  mrm.FieldMonitorSchedule.schema,
  mrm.Rating.schema,
  mrm.Pricing.schema,
  mrm.GioSubscription.schema,
  mrm.GioPaymentRequest.schema,
  mrm.State.schema,
];

void initialDataCallback(rm.Realm realm) {
  px('🍎🍎🍎🍎🍎 initialDataCallback ... 🍎do something on initial start up!');
}

class RealmSyncApi {
  final mm = '🌎🌎🌎🌎🌎🌎 RealmSyncApi 🌎';
  late rm.Realm realmRemote;
  late rm.Realm realmCities;

  RealmSyncApi() {
    // initialize();
  }

  var initialized = false;

  Future<bool> initialize() async {
    pp('$mm ........ initialize Realm with Device Sync ....');
    app = rm.App(rm.AppConfiguration(realmAppId));
    realmUser = app.currentUser ?? await app.logIn(rm.Credentials.anonymous());
    final config = rm.Configuration.flexibleSync(realmUser, schemas,
        syncErrorHandler: (SyncError err) {
      pp('\n\n\n$mm ${E.redDot}${E.redDot}${E.redDot}${E.redDot} '
          'Some kind of Realm SyncError; \n🍎codeValue: ${err.codeValue} '
          '\n🍎message: ${err.message}  \n🍎category: ${err.category.name} \n');
      //todo - handle this error condition!!!!
      switch (err.codeValue) {
        case 226:
          break;
      }
    });

    try {
      Realm.logger.level = RealmLogLevel.debug;
      //todo - use real creds when in prod
      //todo - save realm user in prefs and avoid unnecessary login
      if (await checkDeviceOnline()) {
        // If the device is online, download changes and then open the realm.
        realmRemote = await Realm.open(config, onProgressCallback: (cb) {
          pp('$mm transferableBytes: ${cb.transferableBytes} transferredBytes: ${cb.transferredBytes}');
        });
      } else {
        // If the device is offline, open the realm immediately
        // and automatically sync changes in the background when the device is online.
        realmRemote = Realm(config);
      }

      pp('\n\n$mm RealmApp configured  🥬 🥬 🥬 🥬; realmUser : '
          '\n🌎🌎state: ${realmUser.state.name} '
          '\n🌎🌎accessToken: ${realmUser.accessToken} '
          '\n🌎🌎id:${realmUser.id} \n🌎🌎name:${realmUser.profile.name}');

      for (var schema in realmRemote.schema) {
        pp('$mm RealmApp configured; schema : 🍎🍎${schema.name}');
      }
      pp('\n$mm RealmApp configured OK  🥬 🥬 🥬 🥬: 🔵 ${realmRemote.schema.length} Realm schemas \n\n');
      return true;
    } catch (e) {
      pp('$mm ${E.redDot}${E.redDot}${E.redDot}${E.redDot} Problem initializing Realm: $e');
    }
    return false;
  }

  static const email = 'aubrey@aftarobot.com',
      password = 'kkTiger3#',
      id = '6478402d6358d2b0e1ba6abe';

  Future<bool> initializeForCities() async {
    pp('\n\n$mm ........ initialize Realm with Device Sync ....');
    app = rm.App(rm.AppConfiguration(realmAppId));
    realmUser = app.currentUser ?? await app.logIn(rm.Credentials.anonymous());
    final config = rm.Configuration.flexibleSync(realmUser, schemas,
        syncErrorHandler: (SyncError err) {
      pp('\n\n\n$mm ${E.redDot}${E.redDot}${E.redDot}${E.redDot} '
          'Some kind of Realm SyncError; \n🍎codeValue: ${err.codeValue} '
          '\n🍎message: ${err.message}  \n🍎category: ${err.category.name} \n');
      //todo - handle this error condition!!!!
      switch (err.codeValue) {
        case 226:
          break;
      }
    });

    try {
      Realm.logger.level = RealmLogLevel.debug;
      //todo - use real creds when in prod
      //todo - save realm user in prefs and avoid unnecessary login
      if (await checkDeviceOnline()) {
        // If the device is online, download changes and then open the realm.
        realmCities = await Realm.open(config, onProgressCallback: (cb) {
          pp('$mm transferableBytes: ${cb.transferableBytes} transferredBytes: ${cb.transferredBytes}');
        });
      } else {
        // If the device is offline, open the realm immediately
        // and automatically sync changes in the background when the device is online.
        realmCities = Realm(config);
      }
      //realmRemote = rm.Realm(config);

      pp('\n\n$mm RealmApp configured  🥬 🥬 🥬 🥬; realmUser : '
          '\n🌎🌎state: ${realmUser.state.name} '
          '\n🌎🌎accessToken: ${realmUser.accessToken} '
          '\n🌎🌎id:${realmUser.id} \n🌎🌎name:${realmUser.profile.name}');

      for (var schema in realmCities.schema) {
        pp('$mm RealmApp configured; schema : 🍎🍎${schema.name}');
      }
      pp('\n$mm RealmApp configured OK  🥬 🥬 🥬 🥬: 🔵 ${realmCities.schema.length} Realm schemas \n\n');

      return true;
    } catch (e) {
      pp('$mm ${E.redDot}${E.redDot}${E.redDot}${E.redDot} Problem initializing Realm: $e');
    }
    return false;
  }

  Future<bool> checkDeviceOnline() async {
    return true;
  }

  Future setSubscriptions(
      {required String? organizationId, required String? countryId}) async {
    try {
      await initialize();

      final orgUsersQuery = realmRemote
          .query<mrm.User>("organizationId == \$0", [organizationId]);

      final countryCitiesQuery =
          realmRemote.query<mrm.City>("countryId == \$0", [countryId]);

      final orgSettingsQuery = realmRemote
          .query<mrm.SettingsModel>("organizationId == \$0", [organizationId]);

      final allCountriesQuery = realmRemote.all<mrm.Country>();
      final orgPhotosQuery = realmRemote
          .query<mrm.Photo>("organizationId == \$0", [organizationId]);

      final orgVideosQuery = realmRemote
          .query<mrm.Video>("organizationId == \$0", [organizationId]);

      final orgAudiosQuery = realmRemote
          .query<mrm.Audio>("organizationId == \$0", [organizationId]);

      final orgGeofenceQuery = realmRemote
          .query<mrm.GeofenceEvent>("organizationId == \$0", [organizationId]);

      final orgsQuery = realmRemote.all<mrm.Organization>();

      final orgPositionsQuery = realmRemote.query<mrm.ProjectPosition>(
          "organizationId == \$0", [organizationId]);

      final orgPolygonsQuery = realmRemote
          .query<mrm.ProjectPolygon>("organizationId == \$0", [organizationId]);

      final orgActivitiesQuery = realmRemote
          .query<mrm.ActivityModel>("organizationId == \$0", [organizationId]);

      final orgProjectsQuery = realmRemote
          .query<mrm.Project>("organizationId == \$0", [organizationId]);

      final orgRatingsQuery = realmRemote
          .query<mrm.Rating>("organizationId == \$0", [organizationId]);
      //
      realmRemote.subscriptions
          .update((MutableSubscriptionSet mutableSubscriptions) {
        mutableSubscriptions.add(allCountriesQuery,
            name: 'all_countries', update: true);
        mutableSubscriptions.add(orgUsersQuery,
            name: 'org_users', update: true);
        mutableSubscriptions.add(countryCitiesQuery,
            name: 'country_cities', update: true);
        mutableSubscriptions.add(orgSettingsQuery,
            name: 'org_settings', update: true);
        mutableSubscriptions.add(orgsQuery, name: 'all_orgs', update: true);
        mutableSubscriptions.add(orgVideosQuery,
            name: 'org_videos', update: true);
        mutableSubscriptions.add(orgPhotosQuery,
            name: 'org_photos', update: true);
        mutableSubscriptions.add(orgAudiosQuery,
            name: 'org_audios', update: true);
        mutableSubscriptions.add(orgGeofenceQuery,
            name: 'org_geofence_events', update: true);
        mutableSubscriptions.add(orgPositionsQuery,
            name: 'org_positions', update: true);
        mutableSubscriptions.add(orgPolygonsQuery,
            name: 'org_polygons', update: true);
        mutableSubscriptions.add(orgActivitiesQuery,
            name: 'org_activities', update: true);
        mutableSubscriptions.add(orgProjectsQuery,
            name: 'org_projects', update: true);
        mutableSubscriptions.add(orgRatingsQuery,
            name: 'org_ratings', update: true);
      });

      // Sync all subscriptions
      await realmRemote.subscriptions.waitForSynchronization();
      for (var sub in realmRemote.subscriptions) {
        pp('$mm 😡 😡 😡 Realm Subscription: ${sub.name} - ${sub.objectClassName}');
      }
      pp('\n$mm RealmApp waitForSynchronization completed OK  🥬 🥬 🥬 🥬: 🔵\n');
    } catch (e) {
      pp('$mm ${E.redDot}${E.redDot}${E.redDot}${E.redDot} Problem setting up subscriptions to Realm: $e');
    }
  }

  Future setSubscriptionsForCities({required String? countryId}) async {
    try {
      await initializeForCities();

      final countryCitiesQuery =
          realmCities.query<mrm.City>("countryId == \$0", [countryId]);

      //
      realmCities.subscriptions
          .update((MutableSubscriptionSet mutableSubscriptions) {
        mutableSubscriptions.add(countryCitiesQuery,
            name: 'country_cities', update: true);
      });

      // Sync all subscriptions
      await realmCities.subscriptions.waitForSynchronization();
      for (var sub in realmCities.subscriptions) {
        pp('$mm 😡 😡 😡 Realm Subscription: ${sub.name} - ${sub.objectClassName}');
      }
      pp('\n$mm RealmApp waitForSynchronization completed OK  🥬 🥬 🥬 🥬: 🔵\n');
    } catch (e) {
      pp('$mm ${E.redDot}${E.redDot}${E.redDot}${E.redDot} Problem setting up subscriptions to Realm: $e');
    }
  }

  RealmResults<mrm.Country> getCountry(String name) {
    late RealmResults<mrm.Country> results;
    realmRemote.write(() {
      results = realmRemote.query('name == \$0', [name]);
    });
    pp('$mm ${results.length} elements in results object');
    return results;
  }

  int addActivities(List<mrm.ActivityModel> activityModels) {
    try {
      realmRemote.write(() {
        realmRemote.addAll(activityModels);
      });
      px('$mm activities added: ${activityModels.length} ');
      return 0;
    } catch (e) {
      _handleError(e);
    }
    return 1;
  }

  int addGeofenceEvents(List<mrm.GeofenceEvent> geofenceEvents) {
    try {
      realmRemote.write(() {
        realmRemote.addAll(geofenceEvents);
      });
      px('$mm geofenceEvents added: ${geofenceEvents.length} ');
      return 0;
    } catch (e) {
      _handleError(e);
    }
    return 1;
  }

  int addRatings(List<mrm.Rating> ratings) {
    try {
      realmRemote.write(() {
        realmRemote.addAll(ratings);
      });
      px('$mm ratings added: ${ratings.length}');
      return 0;
    } catch (e) {
      _handleError(e);
    }
    return 1;
  }

  int addSettings(List<mrm.SettingsModel> settingsModels) {
    try {
      realmRemote.write(() {
        realmRemote.addAll(settingsModels);
      });
      px('$mm settings added: ${settingsModels.length}');
      return 0;
    } catch (e) {
      _handleError(e);
    }
    return 1;
  }

  int addPhotos(List<mrm.Photo> photos) {
    try {
      realmRemote.write(() {
        realmRemote.addAll(photos);
      });
      px('$mm photos added: ${photos.length} ');
      return 0;
    } catch (e) {
      _handleError(e);
    }
    return 1;
  }

  int addVideos(List<mrm.Video> videos) {
    try {
      realmRemote.write(() {
        realmRemote.addAll(videos);
      });
      px('$mm videos added: ${videos.length}');
      return 0;
    } catch (e) {
      _handleError(e);
    }
    return 1;
  }

  int addAudios(List<mrm.Audio> audios) {
    try {
      realmRemote.write(() {
        realmRemote.addAll(audios);
      });
      px('$mm audios added: ${audios.length}');
      return 0;
    } catch (e) {
      _handleError(e);
    }
    return 1;
  }

  int addProjectPositions(List<mrm.ProjectPosition> projectPositions) {
    try {
      realmRemote.write(() {
        realmRemote.addAll(projectPositions);
      });
      px('$mm ProjectPositions added,: ${projectPositions.length}}');
      return 0;
    } catch (e) {
      _handleError(e);
    }
    return 1;
  }

  int addProjectPolygons(List<mrm.ProjectPolygon> projectPolygons) {
    try {
      realmRemote.write(() {
        realmRemote.addAll(projectPolygons);
      });
      px('$mm ProjectPolygons added: ${projectPolygons.length} ');
      return 0;
    } catch (e) {
      _handleError(e);
    }
    return 1;
  }

  int addProjects(List<mrm.Project> projects) {
    try {
      realmRemote.write(() {
        return realmRemote.addAll(projects);
      });
      px('$mm projects added: ${projects.length}');
      return 0;
    } catch (e) {
      _handleError(e);
    }
    return 1;
  }

  final err = '🍎🍎🍎🍎 Realm Error 🍎🍎🍎🍎';

  int addUsers(List<mrm.User> users) {
    try {
      realmRemote.write(() {
        realmRemote.addAll(users);
      });
      px('$mm users added: ${users.length}');
      return 0;
    } catch (e) {
      _handleError(e);
    }
    return 1;
  }

  int addOrganizations(List<mrm.Organization> organizations) {
    try {
      realmRemote.write(() {
        realmRemote.addAll(organizations);
      });
      px('$mm organizations added: ${organizations.length}');
      return 0;
    } catch (e) {
      _handleError(e);
    }
    return 1;
  }

  int addLocationRequests(List<mrm.LocationRequest> requests) {
    try {
      realmRemote.write(() {
        realmRemote.addAll(requests);
      });
      px('$mm requests added: ${requests.length}');
      return 0;
    } catch (e) {
      _handleError(e);
    }
    return 1;
  }

  int addLocationResponses(List<mrm.LocationResponse> responses) {
    try {
      realmRemote.write(() {
        realmRemote.addAll(responses);
      });
      px('$mm responses added: ${responses.length}');
      return 0;
    } catch (e) {
      _handleError(e);
    }
    return 1;
  }

  int addCountries(List<mrm.Country> countries) {
    try {
      if (countries.length == 1) {
        realmRemote.write(() {
          return realmRemote.add(countries.first);
        });
      } else {
        realmRemote.write(() {
          return realmRemote.addAll(countries);
        });
        px('$mm Countries added to Realm: 🔶 ${countries.length} countries');
      }
      return 0;
    } catch (e) {
      _handleError(e);
    }
    return 1;
  }

  int addCities(List<mrm.City> cities) {
    try {
      if (cities.length == 1) {
        realmRemote.write(() {
          return realmRemote.add(cities.first);
        });
      } else {
        realmRemote.write(() {
          return realmRemote.addAll(cities);
        });
        px('$mm Cities added to Realm: 🔶 ${cities.length} cities');
      }
      return 0;
    } catch (e) {
      _handleError(e);
    }
    return 1;
  }

  void deleteCountries() {
    pp('$mm DELETE all countries ...');
    realmRemote.write(() {
      realmRemote.deleteAll<mrm.Country>();
    });
    pp('$mm all countries deleted ...');
    realmRemote.write(() {
      var s = realmRemote.all<mrm.Country>();
      pp('$mm check countries deleted: ... ${s.length}; cool if ZERO!');
    });
  }

  List<mrm.Country> getCountries() {
    px('$mm getCountries ... ');

    final result = realmRemote.all<mrm.Country>();
    var list = <mrm.Country>[];
    for (var value in result.toList()) {
      list.add(value);
    }
    px('$mm countries found in Realm: ${list.length}');

    return list;
  }

  List<mrm.Project> getProjects(String organizationId) {
    final result = realmRemote.all<mrm.Project>();
    var list = <mrm.Project>[];
    for (var value in result.toList()) {
      list.add(value);
    }
    px('$mm projects found in Realm: ${list.length}');

    return list;
  }

  List<mrm.User> getUsers(String organizationId) {
    final result = realmRemote.all<mrm.User>();
    var list = <mrm.User>[];
    for (var value in result.toList()) {
      list.add(value);
    }
    px('$mm users found in Realm: ${list.length}');

    return list;
  }

  List<mrm.ActivityModel> getOrganizationActivities(
      {required String organizationId, required int numberOfHours}) {
    final map = getStartEndDatesFromHours(numberOfHours: numberOfHours);
    final result = realmRemote.query<mrm.ActivityModel>(
        "date >= \$0 AND date <= \$1", [map.$1, map.$2]);
    var list = <mrm.ActivityModel>[];
    var resList = result.toList();
    for (var value in resList) {
      list.add(value);
    }
    px('$mm Activities found in Realm: ${list.length}');

    return list;
  }

  List<mrm.ActivityModel> getProjectActivities(
      {required String projectId, required int numberOfHours}) {
    final map = getStartEndDatesFromHours(numberOfHours: numberOfHours);
    final result = realmRemote.query<mrm.ActivityModel>(
        "date >= \$0 AND date <= \$1 ", [map.$1, map.$2, projectId]);
    var list = <mrm.ActivityModel>[];
    var resList = result.toList();
    for (var value in resList) {
      list.add(value);
    }
    px('$mm Activities found in Realm: ${list.length}');
    list.sort((a, b) => b.date!.compareTo(a.date!));

    return list;
  }

  List<mrm.GeofenceEvent> getOrganizationGeofenceEvents(
      {required String organizationId, required int numberOfDays}) {
    final map = getStartEndDatesFromDays(numberOfDays: numberOfDays);
    final result = realmRemote.query<mrm.GeofenceEvent>(
        "date >= \$0 AND date <= \$1 AND organizationId == \$2",
        [map.$1, map.$2, organizationId]);
    var list = <mrm.GeofenceEvent>[];
    var resList = result.toList();
    for (var value in resList) {
      list.add(value);
    }
    px('$mm GeofenceEvents found in Realm: ${list.length}');

    return list;
  }

  List<mrm.User> getOrganizationUsers({required String organizationId}) {
    final result =
        realmRemote.query<mrm.User>("organizationId >= \$0", [organizationId]);
    var list = <mrm.User>[];
    var resList = result.toList();
    for (var value in resList) {
      list.add(value);
    }
    px('$mm Users found in Realm: ${list.length}');

    return list;
  }

  List<mrm.SettingsModel> getOrganizationSettings(
      {required String organizationId}) {
    final result = realmRemote
        .query<mrm.SettingsModel>("organizationId >= \$0", [organizationId]);
    var list = <mrm.SettingsModel>[];
    var resList = result.toList();
    for (var value in resList) {
      list.add(value);
    }
    px('$mm Settings found in Realm: ${list.length}');

    return list;
  }

  List<mrm.GeofenceEvent> getProjectGeofenceEvents(
      {required String projectId, required int numberOfDays}) {
    final map = getStartEndDatesFromDays(numberOfDays: numberOfDays);

    final result = realmRemote.query<mrm.GeofenceEvent>(
      "(date >= \$0 AND date <= \$1) AND projectId == \$3",
      [map.$1, map.$2, projectId],
    );

    result.changes.listen((changes) {
      pp('$mm Inserted indexes: ${changes.inserted}');
      pp('$mm Deleted indexes: ${changes.deleted}');
      pp('$mm Modified indexes: ${changes.modified}');
    });
    var list = <mrm.GeofenceEvent>[];
    var resList = result.toList();
    for (var value in resList) {
      list.add(value);
    }
    px('$mm GeofenceEvents found in Realm: ${list.length}');
    list.sort((a, b) => b.date!.compareTo(a.date!));
    return list;
  }

  List<mrm.ProjectPosition> getProjectPositions(
      {required String projectId, required int numberOfDays}) {
    final map = getStartEndDatesFromDays(numberOfDays: numberOfDays);

    final result = realmRemote.query<mrm.ProjectPosition>(
      "(date >= \$0 AND date <= \$1) AND projectId == \$3",
      [map.$1, map.$2, projectId],
    );

    result.changes.listen((changes) {
      pp('$mm Inserted indexes: ${changes.inserted}');
      pp('$mm Deleted indexes: ${changes.deleted}');
      pp('$mm Modified indexes: ${changes.modified}');
    });
    var list = <mrm.ProjectPosition>[];
    var resList = result.toList();
    for (var value in resList) {
      list.add(value);
    }
    px('$mm ProjectPositions found in Realm: ${list.length}');
    list.sort((a, b) => b.created!.compareTo(a.created!));
    return list;
  }
  List<mrm.ProjectPolygon> getProjectPolygons(
      {required String projectId, required int numberOfDays}) {
    final map = getStartEndDatesFromDays(numberOfDays: numberOfDays);

    final result = realmRemote.query<mrm.ProjectPolygon>(
      "(date >= \$0 AND date <= \$1) AND projectId == \$3",
      [map.$1, map.$2, projectId],
    );

    result.changes.listen((changes) {
      pp('$mm Inserted indexes: ${changes.inserted}');
      pp('$mm Deleted indexes: ${changes.deleted}');
      pp('$mm Modified indexes: ${changes.modified}');
    });
    var list = <mrm.ProjectPolygon>[];
    var resList = result.toList();
    for (var value in resList) {
      list.add(value);
    }
    px('$mm ProjectPolygons found in Realm: ${list.length}');
    list.sort((a, b) => b.created!.compareTo(a.created!));
    return list;
  }
  List<mrm.Photo> getProjectPhotos(
      {required String projectId, required int numberOfDays}) {
    final map = getStartEndDatesFromDays(numberOfDays: numberOfDays);
    final result = realmRemote.query<mrm.Photo>(
        "created >= \$0 AND created <= \$1", [map.$1, map.$2, projectId]);
    var list = <mrm.Photo>[];
    var resList = result.toList();
    for (var value in resList) {
      list.add(value);
    }

    px('$mm Photos found in Realm: ${list.length}');
    list.sort((a, b) => b.created!.compareTo(a.created!));
    return list;
  }

  List<mrm.Video> getProjectVideos(
      {required String projectId, required int numberOfDays}) {
    final map = getStartEndDatesFromDays(numberOfDays: numberOfDays);
    final result = realmRemote.query<mrm.Video>(
        "created >= \$0 AND created <= \$1", [map.$1, map.$2]);
    var list = <mrm.Video>[];
    var resList = result.toList();
    for (var value in resList) {
      list.add(value);
    }
    px('$mm Videos found in Realm: ${list.length}');
    list.sort((a, b) => b.created!.compareTo(a.created!));
    return list;
  }

  List<mrm.Audio> getProjectAudios(
      {required String projectId, required int numberOfDays}) {
    final map = getStartEndDatesFromDays(numberOfDays: numberOfDays);
    final result = realmRemote.query<mrm.Audio>(
        "created >= \$0 AND created <= \$1", [map.$1, map.$2, projectId]);
    var list = <mrm.Audio>[];
    var resList = result.toList();
    for (var value in resList) {
      list.add(value);
    }

    px('$mm Audios found in Realm: ${list.length}');
    list.sort((a, b) => b.created!.compareTo(a.created!));

    return list;
  }

  void _handleError(Object e) {
    if (e is rm.RealmException) {
      if (e.message.contains('1013')) {
        //pp('$err Object already exists: $e');
      } else {
        pp('$err handle Realm error: $err $e');
        errorHandler.handleError(
            exception: GeoException(
                message: 'Realm error: $e',
                translationKey: 'realmExists',
                errorType: 'duplicate',
                url: ''));
      }
    } else {
      pp('$err handle unknown error (is not RealmException ): $e');
      errorHandler.handleError(
          exception: GeoException(
              message: 'Unknown error: $e',
              translationKey: 'unknownError',
              errorType: 'deviceError',
              url: ''));
    }
  }
}
