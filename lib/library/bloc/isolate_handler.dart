import 'dart:async';
import 'dart:isolate';

import 'package:geo_monitor/library/api/prefs_og.dart';
import 'package:geo_monitor/library/bloc/data_refresher.dart';
import 'package:geo_monitor/library/bloc/project_bloc.dart';
import 'package:geo_monitor/library/bloc/user_bloc.dart';
import 'package:geo_monitor/library/data/activity_model.dart' as old;
import 'package:geo_monitor/library/data/audio.dart' as old;
import 'package:geo_monitor/library/data/city.dart' as old;
import 'package:geo_monitor/library/data/country.dart' as old;
import 'package:geo_monitor/library/data/geofence_event.dart' as old;
import 'package:geo_monitor/library/data/organization.dart' as old;
import 'package:geo_monitor/library/data/photo.dart' as old;
import 'package:geo_monitor/library/data/project.dart' as old;
import 'package:geo_monitor/library/data/project_polygon.dart' as old;
import 'package:geo_monitor/library/data/project_position.dart' as old;
import 'package:geo_monitor/library/data/settings_model.dart' as old;
import 'package:geo_monitor/library/data/user.dart' as old;
import 'package:geo_monitor/library/data/video.dart' as old;
import 'package:geo_monitor/library/functions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:realm/realm.dart' as realm;

import '../../realm_data/data/realm_sync_api.dart';
import '../../realm_data/data/schemas.dart';
import '../api/data_api_og.dart';
import '../auth/app_auth.dart';
import '../cache_manager.dart';
import '../data/data_bag.dart';
import 'organization_bloc.dart';

late IsolateDataHandler dataHandler;

class IsolateDataHandler {
  static const xx = ' 🎁 🎁 🎁 🎁 🎁 🎁 IsolateDataHandler:  🎁 ';

  IsolateDataHandler(
      this.prefsOGx, this.appAuth, this.cacheManager, this.realmSyncApi) {}

  final PrefsOGx prefsOGx;
  final AppAuth appAuth;
  final CacheManager cacheManager;
  final RealmSyncApi realmSyncApi;

  late ReceivePort myReceivePort;

  Future<DataBag?> getOrganizationData() async {
    pp('\n\n$xx getOrganizationData;  🦊collect parameters from SettingsModel, refresh date ...');
    final sett = await prefsOGx.getSettings();
    pp('$xx getOrganizationData, settings.activityStreamHours: ${sett.activityStreamHours}');
    final token = await appAuth.getAuthToken();
    final dir = await getApplicationDocumentsDirectory();

    var lastRefresh = await prefsOGx.getLastRefresh();
    var now = DateTime.now().toUtc().toIso8601String();
    pp('$xx getOrganizationData, lastRefresh startDate: ${lastRefresh.stringDate} endDate: $now'
        ' id:  ${sett.organizationId}\n');

    myReceivePort = ReceivePort();

    var gioParams = GioParams(
        organizationId: sett.organizationId!,
        directoryPath: dir.path,
        sendPort: myReceivePort.sendPort,
        token: token!,
        startDate: lastRefresh.stringDate,
        endDate: now,
        url: getUrl(),
        projectId: null,
        activityStreamHours: sett.activityStreamHours!,
        userId: null);

    final bag = await _spawnIsolate(gioParams);
    if (bag != null) {
      await prefsOGx.saveLastRefresh();
      await _cacheTheData(bag);
      _sendOrganizationDataToStreams(bag);
    }

    return bag;
  }

  Future<DataBag?> getProjectData(String projectId) async {
    pp('$xx getProjectData;  🦊...');
    myReceivePort = ReceivePort();

    final sett = await prefsOGx.getSettings();
    final token = await appAuth.getAuthToken();
    final map = await getStartEndDates(numberOfDays: sett.numberOfDays!);
    final dir = await getApplicationDocumentsDirectory();

    var gioParams = GioParams(
        organizationId: null,
        directoryPath: dir.path,
        sendPort: myReceivePort.sendPort,
        token: token!,
        startDate: map['startDate']!,
        endDate: map['endDate']!,
        url: getUrl(),
        activityStreamHours: sett.activityStreamHours!,
        projectId: projectId,
        userId: null);

    final bag = await _spawnIsolate(gioParams);
    if (bag != null) {
      await _cacheTheData(bag);
      _sendProjectDataToStreams(bag);
    }
    return bag;
  }

  Future<DataBag?> getUserData(String userId) async {
    pp('$xx handleOrganization;  🦊collect parameters from SettingsModel ...');
    myReceivePort = ReceivePort();
    userBloc = UserBloc(dataApiDog, cacheManager, this);

    final sett = await prefsOGx.getSettings();
    final token = await appAuth.getAuthToken();
    final map = await getStartEndDates(numberOfDays: sett.numberOfDays!);
    final dir = await getApplicationDocumentsDirectory();

    var gioParams = GioParams(
        organizationId: null,
        directoryPath: dir.path,
        sendPort: myReceivePort.sendPort,
        token: token!,
        startDate: map['startDate']!,
        endDate: map['endDate']!,
        url: getUrl(),
        activityStreamHours: sett.activityStreamHours!,
        projectId: null,
        userId: userId);

    final bag = await _spawnIsolate(gioParams);
    if (bag != null) {
      await _cacheTheData(bag);
      _sendUserDataToStreams(bag);
    }
    return bag;
  }

  Future<DataBag?> _spawnIsolate(GioParams gioParams) async {
    pp('$xx starting Isolate with gioParams ... .................');
    pp('$xx starting Isolate with gioParams ... activityStreamHours: ${gioParams.activityStreamHours}');

    final bag = await Isolate.run(() => _heavyTaskInsideIsolate(gioParams));
    return bag;
  }

  void _sendOrganizationDataToStreams(DataBag bag) async {
    organizationBloc.dataBagController.sink.add(bag);
    pp('$xx Organization Data sent to dataBagStream  ...');
  }

  void _sendProjectDataToStreams(DataBag bag) {
    projectBloc.dataBagController.sink.add(bag);
    pp('$xx Project Data sent to dataBagStream  ...');
  }

  void _sendUserDataToStreams(DataBag bag) {
    userBloc?.dataBagController.sink.add(bag);
    pp('$xx User Data sent to dataBagStream  ...');
  }

  Future _cacheTheData(DataBag? bag) async {
    pp('$xx zipped Data returned from server, adding to Hive cache ...');
    if (bag == null) {
      return;
    }

    final start = DateTime.now();
    await cacheManager.addProjects(projects: bag!.projects!);
    await cacheManager.addProjectPolygons(polygons: bag.projectPolygons!);
    await cacheManager.addProjectPositions(positions: bag.projectPositions!);
    await cacheManager.addUsers(users: bag.users!);
    await cacheManager.addPhotos(photos: bag.photos!);
    await cacheManager.addVideos(videos: bag.videos!);
    await cacheManager.addAudios(audios: bag.audios!);
    await cacheManager.deleteActivityModels();
    await cacheManager.addActivityModels(activities: bag.activityModels!);
    bag.settings!.sort((a, b) => DateTime.parse(b.created!)
        .millisecondsSinceEpoch
        .compareTo(DateTime.parse(a.created!).millisecondsSinceEpoch));
    if (bag.settings!.isNotEmpty) {
      await cacheManager.addSettings(settings: bag.settings!.first);
    }
    await cacheManager.addFieldMonitorSchedules(
        schedules: bag.fieldMonitorSchedules!);

    final user = await prefsOGx.getUser();
    for (var element in bag.users!) {
      if (element.userId == user!.userId) {
        await prefsOGx.saveUser(element);
      }
    }
    final end = DateTime.now();

    pp('$xx Organization Data saved in Hive cache ... 🍎 '
        '${end.difference(start).inSeconds} seconds elapsed');
  }


  Future migrateOneOrganization({required String organizationId, required String name}) async {
    pp('\n\n\n$x2 migrateOneOrganization: '
        ' ..................... $nn adding to Realm DB ... $name');
    //todo REMOVE the data migration code when done!!!!!

    final start = DateTime.now();
    await realmSyncApi.setSubscriptions(organizationId: organizationId, countryId: null);

    await migrateUsers(organizationId: organizationId, name: name);
    await migrateProjects(organizationId: organizationId, name: name);
    await migratePhotos(organizationId: organizationId, name: name);
    await migrateVideos(organizationId: organizationId, name: name);
    await migrateAudios(organizationId: organizationId, name: name);
    await migrateActivities(organizationId: organizationId, name: name);
    await migrateSettings(organizationId: organizationId, name: name);
    await migrateGeofenceEvents(organizationId: organizationId, name: name);
    await migratePositions(organizationId: organizationId, name: name);
    await migratePolygons(organizationId: organizationId, name: name);

    final end = DateTime.now();
    pp('$x2 migrateOneOrganization: Data saved in Realm database for $name ... 🍎🍎🍎🍎🍎🍎 '
        '${end.difference(start).inSeconds} seconds elapsed 🍎🍎\n');

    pp('\n\n$x2$x2$x2$x2$x2$x2 CHECKING DATA MIGRATED .... $x2$x2');

    var users = realmSyncApi.getOrganizationUsers(organizationId: organizationId);
    pp('$x2 realmSyncApi.getOrganizationUsers: $name has ${users.length} users');
    var setts = realmSyncApi.getOrganizationSettings(organizationId: organizationId);
    pp('$x2 realmSyncApi.getOrganizationSettings: $name has ${setts.length} settings');


    var projects = realmSyncApi.getProjects(organizationId);
    pp('$x2 realmSyncApi. $name has ${projects.length} projects');

    for (var p in projects) {
      var videos = realmSyncApi.getProjectVideos(projectId: p.projectId!, numberOfDays: 400);
      pp('$x2 realmSyncApi.getProjectVideos: $name has ${videos.length} videos');
      var photos = realmSyncApi.getProjectPhotos(projectId: p.projectId!, numberOfDays: 400);
      pp('$x2 realmSyncApi.getProjectPhotos: $name has ${photos.length} photos');
      var audios = realmSyncApi.getProjectAudios(projectId: p.projectId!, numberOfDays: 400);
      pp('$x2 realmSyncApi.getProjectAudios: $name has ${audios.length} audios');
      var acts = realmSyncApi.getProjectActivities(projectId: p.projectId!, numberOfHours: 365 * 400);
      pp('$x2 realmSyncApi.getProjectActivities: $name has ${acts.length} activities');
      var geos = realmSyncApi.getProjectGeofenceEvents(projectId: p.projectId!, numberOfDays: 400);
      pp('$x2 realmSyncApi.getProjectGeofenceEvents: $name has ${geos.length} geofence events');

      var poss = realmSyncApi.getProjectPositions(projectId: p.projectId!, numberOfDays: 400);
      pp('$x2 realmSyncApi.getProjectPositions: $name has ${poss.length} ProjectPositions');

    }
    return '$name - data migration completed';
  }

  Future migrateCities() async {

    var countries = await dataApiDog.getCountries();

    pp('\n\n$x2 migrating ${countries.length} countries\'s cities .....');
    for (var country in countries) {
      await realmSyncApi.setSubscriptionsForCities(countryId: country.countryId);
      var cities = await dataApiDog.getCitiesByCountry(country.countryId!);
      var countryCities = <City>[];
      for (var c in cities) {
        final k = _getCity(c);
        countryCities.add(k);
      }
      realmSyncApi.addCities(countryCities);
      pp('$x2 added ${countryCities.length} cities for country: ${country.name} \n');
    }
  }

  Future migrateSettings(
      {required String organizationId, required String name}) async {
    pp('$x2 ..................... $nn process settings ... $name');
    var settings = await dataApiDog.getOrganizationSettings(organizationId);
    var mSettings = <SettingsModel>[];
    for (var element in settings) {
      var f = _getSetting(element);
      mSettings.add(f);
    }
    realmSyncApi.addSettings(mSettings);
    pp('$x2 added ${mSettings.length} settings');
  }

  Future migrateGeofenceEvents(
      {required String organizationId, required String name}) async {
    pp('$x2 ..................... $nn process geofences ... $name');

    var events =
        await dataApiDog.getGeofenceEventsByOrganization(organizationId);

    var mEvents = <GeofenceEvent>[];
    for (var element in events) {
      var f = _getGeofenceEvent(element);
      mEvents.add(f);
    }
    realmSyncApi.addGeofenceEvents(mEvents);
    pp('$x2 added ${mEvents.length} geofence events');
  }

  Future migrateOrganizations() async {
    pp('$x2 ..................... $nn process organizations ... ');
    var orgs = await dataApiDog.getOrganizations();
    await realmSyncApi.setSubscriptions(organizationId: null, countryId: null);
    var mOrgs = <Organization>[];
    for (var element in orgs) {
      var f = _getOrganization(element);
      mOrgs.add(f);
    }
    realmSyncApi.addOrganizations(mOrgs);
    pp('$x2 added ${mOrgs.length} organizations');
  }

  Future migrateActivities(
      {required String organizationId, required String name}) async {
    pp('$x2 ..................... $nn process activities ... $name');

    var actions =
        await dataApiDog.getAllOrganizationActivity(organizationId);

    try {
      var mList = <ActivityModel>[];
      for (var x in actions) {
        final k = _getActivity(x);
        mList.add(k);
      }
      realmSyncApi.addActivities(mList);
      pp('$x2 added ${mList.length} activities');
    } catch (e) {
      pp(e);
      throw Exception('We have a Realm issue, Boss! $e');
    }
  }

  Future migrateAudios(
      {required String organizationId, required String name}) async {
    pp('$x2 ..................... $nn process audios ... $name');
    var audios = await dataApiDog.getOrganizationAudios(organizationId);

    try {
      var mList = <Audio>[];
      for (var x in audios!) {
        final a = _getAudio(x);
        mList.add(a);
      }
      realmSyncApi.addAudios(mList);
      pp('$x2 added ${mList.length} audios');
    } catch (e) {
      pp(e);
      throw Exception('We have a Realm issue, Boss! $e');
    }
  }

  Future migrateVideos(
      {required String organizationId, required String name}) async {
    pp('$x2 ..................... $nn process videos ... $name');

    var videos = await dataApiDog.getOrganizationVideos(
        organizationId);

    try {
      var mList = <Video>[];
      for (var x in videos) {
        var v = _getVideo(x);
        mList.add(v);
      }
      realmSyncApi.addVideos(mList);
      pp('$x2 added ${mList.length} videos');
    } catch (e) {
      pp(e);
      throw Exception('We have a Realm issue, Boss! $e');
    }
  }

  Future migratePhotos(
      {required String organizationId, required String name}) async {
    pp('$x2 ..................... $nn process photos ... $name');
    var photos = await dataApiDog.getOrganizationPhotos(organizationId);
    try {
      var mList = <Photo>[];
      for (var x in photos) {
        var proj = _getPhoto(x);
        mList.add(proj);
      }
      realmSyncApi.addPhotos(mList);
      pp('$x2 added ${mList.length} photos');
    } catch (e) {
      pp(e);
      throw Exception('We have a Realm issue, Boss! $e');
    }
  }

  Future migratePolygons(
      {required String organizationId, required String name}) async {
    pp('$x2 ..................... $nn process project polygons ...');
    var positions =
        await dataApiDog.getOrganizationPolygons(organizationId);

    try {
      var mList = <ProjectPolygon>[];
      for (var x in positions) {
        final p = _getPolygon(x);
        mList.add(p);
      }
      realmSyncApi.addProjectPolygons(mList);
      pp('$x2 added ${mList.length} polygons, aka areas');
    } catch (e) {
      pp(e);
      throw Exception('We have a Realm issue, Boss! $e');
    }
  }

  Future migratePositions(
      {required String organizationId, required String name}) async {
    pp('$x2 ..................... $nn process project positions ... $name');
    var positions =
        await dataApiDog.getOrganizationPositions(organizationId);

    try {
      var mList = <ProjectPosition>[];
      for (var x in positions) {
        final p = _getPosition(x);
        mList.add(p);
      }
      realmSyncApi.addProjectPositions(mList);
      pp('$x2 added ${mList.length} project positions');
    } catch (e) {
      pp(e);
      throw Exception('We have a Realm issue, Boss! $e');
    }
  }

  Future migrateProjects(
      {required String organizationId, required String name}) async {
    pp('$x2 ..................... $nn process projects ... $name');
    var projects = await dataApiDog.getOrganizationProjects(organizationId);

    try {
      var mList = <Project>[];
      for (var x in projects) {
        final p = _getProject(x);
        mList.add(p);
      }
      realmSyncApi.addProjects(mList);
      pp('$x2 added ${mList.length} projects');
    } catch (e) {
      pp(e);
      throw Exception('We have a Realm issue, Boss! $e');
    }
  }

  Future migrateUsers(
      {required String organizationId, required String name}) async {
    pp('$x2 ..................... $nn process users from : $name...');
    var users = await dataApiDog.getOrganizationUsers(organizationId);
    try {
      var mList = <User>[];
      for (var x in users) {
        final user = _getUser(x);
        mList.add(user);
      }
      realmSyncApi.addUsers(mList);
      pp('$x2 added ${mList.length} users');
    } catch (e) {
      pp(e);
      throw Exception('We have a Realm issue, Boss! $e');
    }
  }

  Future migrateCountries() async {
    pp('$x2 ..................... $nn process countries ...');
    var countries = await dataApiDog.getCountries();
    try {
      await realmSyncApi.setSubscriptions(organizationId: null, countryId: null);

      realmSyncApi.deleteCountries();
      var mList = <Country>[];
      for (var x in countries) {
        final country = _getCountry(x);
        mList.add(country);
      }
      realmSyncApi.addCountries(mList);
      pp('$x2 added ${mList.length} countries');
    } catch (e) {
      pp(e);
      throw Exception('We have a Realm issue, Boss! $e');
    }
  }

  String toShortString(ActivityType activityType) {
    return toString().split('.').last;
  }

  final nn = ' 😡😡😡';
  final x21 = '🥬🥬🥬🥬🥬🥬🥬🥬🥬🥬🥬🥬 ';
  final x2 = '🔵🔵';

  GeofenceEvent _getGeofenceEvent(old.GeofenceEvent x) {
    var g = GeofenceEvent(realm.ObjectId(),
        organizationId: x.organizationId,
        projectId: x.projectId,
        projectName: x.projectName,
        date: x.date,
        status: null,
        geofenceEventId: x.geofenceEventId,
        projectPositionId: x.projectPositionId!,
        position: Position(
          type: x.position!.type,
          coordinates: x.position!.coordinates,
          latitude: x.position!.coordinates.last,
          longitude: x.position!.coordinates.first,
        ),
        user: _getUser(x.user!));
    return g;
  }

  SettingsModel _getSetting(old.SettingsModel x) {
    var g = SettingsModel(
      realm.ObjectId(),
      organizationId: x.organizationId,
      projectId: x.projectId,
      organizationName: null,
      numberOfDays: x.numberOfDays,
      created: x.created,
      photoSize: x.photoSize,
      activityStreamHours: x.activityStreamHours,
      distanceFromProject: x.distanceFromProject,
      maxAudioLengthInMinutes: x.maxAudioLengthInMinutes,
      maxVideoLengthInSeconds: x.maxVideoLengthInSeconds,
      refreshRateInMinutes: x.refreshRateInMinutes,
      settingsId: x.settingsId,
      themeIndex: x.themeIndex,
      locale: x.locale,
      translatedMessage: x.translatedTitle,
      translatedTitle: x.translatedTitle,
    );
    return g;
  }

  Organization _getOrganization(old.Organization x) {
    final proj = Organization(
      realm.ObjectId(),
      organizationId: x.organizationId,
      created: x.created,
      name: x.name,
      translatedTitle: null,
      translatedMessage: null,
      countryId: null,
      email: x.email,
      admin: null,
      countryName: x.countryName,
    );
    return proj;
  }

  Project _getProject(old.Project x) {
    final proj = Project(
      realm.ObjectId(),
      projectId: x.projectId,
      organizationId: x.organizationId,
      organizationName: x.organizationName,
      created: x.created,
      name: x.name,
      translatedTitle: x.translatedTitle,
      translatedMessage: x.translatedMessage,
    );
    return proj;
  }

  Photo _getPhoto(old.Photo x) {
    final proj = Photo(
      realm.ObjectId(),
      projectId: x.projectId,
      projectPositionId: x.projectPositionId,
      projectName: x.projectName,
      caption: x.caption,
      userId: x.userId,
      userName: x.userName,
      distanceFromProjectPosition: x.distanceFromProjectPosition,
      landscape: x.landscape,
      url: x.url,
      thumbnailUrl: x.thumbnailUrl,
      photoId: x.photoId,
      userUrl: x.userUrl,
      projectPolygonId: x.projectPolygonId,
      projectPosition: Position(
        longitude: x.projectPosition!.coordinates.first,
        latitude: x.projectPosition!.coordinates.last,
        coordinates: x.projectPosition!.coordinates,
      ),
      organizationId: x.organizationId,
      created: x.created,
      translatedTitle: x.translatedTitle,
      translatedMessage: x.translatedMessage,
    );
    return proj;
  }

  Video _getVideo(old.Video x) {
    final proj = Video(
      realm.ObjectId(),
      projectId: x.projectId,
      projectPositionId: x.projectPositionId,
      projectName: x.projectName,
      caption: x.caption,
      userId: x.userId,
      userName: x.userName,
      distanceFromProjectPosition: x.distanceFromProjectPosition,
      durationInSeconds: x.durationInSeconds,
      url: x.url,
      thumbnailUrl: x.thumbnailUrl,
      videoId: x.videoId,
      userUrl: x.userUrl,
      projectPolygonId: x.projectPolygonId,
      projectPosition: Position(
        longitude: x.projectPosition!.coordinates.first,
        latitude: x.projectPosition!.coordinates.last,
        coordinates: x.projectPosition!.coordinates,
      ),
      organizationId: x.organizationId,
      created: x.created,
      translatedTitle: x.translatedTitle,
      translatedMessage: x.translatedMessage,
    );
    return proj;
  }

  Audio _getAudio(old.Audio x) {
    final proj = Audio(
      realm.ObjectId(),
      projectId: x.projectId,
      projectPositionId: x.projectPositionId,
      projectName: x.projectName,
      caption: x.caption,
      userId: x.userId,
      userName: x.userName,
      distanceFromProjectPosition: x.distanceFromProjectPosition,
      durationInSeconds: x.durationInSeconds,
      url: x.url,
      audioId: x.audioId,
      userUrl: x.userUrl,
      projectPolygonId: x.projectPolygonId,
      projectPosition: Position(
        longitude: x.projectPosition!.coordinates.first,
        latitude: x.projectPosition!.coordinates.last,
        coordinates: x.projectPosition!.coordinates,
      ),
      organizationId: x.organizationId,
      created: x.created,
      translatedTitle: x.translatedTitle,
      translatedMessage: x.translatedMessage,
    );
    return proj;
  }

  ProjectPolygon _getPolygon(old.ProjectPolygon x) {
    var poss = <Position>[];
    for (var p in x.positions) {
      var position = Position(
        longitude: p.coordinates.first,
        latitude: p.coordinates.last,
        coordinates: p.coordinates,
      );
      poss.add(position);
    }
    final proj = ProjectPolygon(
      realm.ObjectId(),
      projectId: x.projectId,
      projectPolygonId: x.projectPolygonId,
      projectName: x.projectName,
      userId: x.userId,
      userName: x.userName,
      positions: poss,
      organizationId: x.organizationId,
      created: x.created,
      translatedTitle: x.translatedTitle,
      translatedMessage: x.translatedMessage,
      nearestCities: [],
    );

    return proj;
  }

  ProjectPosition _getPosition(old.ProjectPosition x) {
    final proj = ProjectPosition(
      realm.ObjectId(),
      projectId: x.projectId,
      projectPositionId: x.projectPositionId,
      possibleAddress: x.possibleAddress,
      projectName: x.projectName,
      caption: x.caption,
      userId: x.userId,
      userName: x.userName,
      position: Position(
        longitude: x.position!.coordinates.first,
        latitude: x.position!.coordinates.last,
        coordinates: x.position!.coordinates,
      ),
      organizationId: x.organizationId,
      created: x.created,
      name: x.name,
      translatedTitle: x.translatedTitle,
      translatedMessage: x.translatedMessage,
    );
    return proj;
  }

  User _getUser(old.User x) {
    final user = User(
      realm.ObjectId(),
      email: x.email,
      cellphone: x.cellphone,
      userId: x.userId,
      organizationId: x.organizationId,
      organizationName: x.organizationName,
      userType: x.userType,
      updated: DateTime.now().toUtc().toIso8601String(),
      imageUrl: x.imageUrl,
      thumbnailUrl: x.thumbnailUrl,
      created: x.created,
      fcmRegistration: x.fcmRegistration,
      countryId: null,
      active: x.active,
      name: x.name,
      translatedTitle: x.translatedTitle,
      translatedMessage: x.translatedMessage,
      gender: x.gender,
    );

    return user;
  }

  Country _getCountry(old.Country x) {
    final country = Country(realm.ObjectId(),
        population: x.population,
        capital: x.capital,
        currency: x.currency,
        currencyName: x.currencyName,
        currencySymbol: x.currencySymbol,
        countryId: x.countryId,
        emoji: x.emoji,
        iso2: x.iso2,
        iso3: x.iso3,
        latitude: x.latitude,
        longitude: x.longitude,
        name: x.name,
        subregion: x.subregion,
        region: x.region,
        position: Position(
            latitude: x.latitude,
            longitude: x.longitude,
            type: 'Point',
            coordinates: [x.longitude!, x.latitude!]));

    return country;
  }

  ActivityModel _getActivity(old.ActivityModel x) {
    var z = x.getActivityTypeString();
    GeofenceEvent? event;
    Project? project;
    Photo? photo;
    Video? video;
    Audio? audio;
    ProjectPosition? projectPosition;
    ProjectPolygon? projectPolygon;
    if (x.photo != null) {
      photo = _getPhoto(x.photo!);
    }
    if (x.video != null) {
      video = _getVideo(x.video!);
    }
    if (x.audio != null) {
      audio = _getAudio(x.audio!);
    }
    if (x.projectPolygon != null) {
      projectPolygon = _getPolygon(x.projectPolygon!);
    }
    if (x.projectPosition != null) {
      projectPosition = _getPosition(x.projectPosition!);
    }
    if (x.geofenceEvent != null) {
      event = _getGeofenceEvent(x.geofenceEvent!);
    }
    if (x.project != null) {
      project = _getProject(x.project!);
    }
    final proj = ActivityModel(
      realm.ObjectId(),
      projectId: x.projectId,
      activityType: z,
      projectName: x.projectName,
      userId: x.userId,
      userName: x.userName,
      organizationId: x.organizationId,
      date: x.date,
      organizationName: x.organizationName,
      userType: x.userType,
      activityModelId: x.activityModelId,
      translatedUserType: x.translatedUserType,
      intDate: x.intDate,
      userThumbnailUrl: x.userThumbnailUrl,
      geofenceEvent: event,
      project: project,
      photo: photo,
      video: video,
      audio: audio,
      projectPolygon: projectPolygon,
      projectPosition: projectPosition,
    );

    return proj;
  }

  City _getCity(old.City x) {
    final k = City(
      realm.ObjectId(),
      countryName: x.countryName,
      countryId: x.countryId,
      name: x.name,
      cityId: x.cityId,
      stateId: x.stateId,
      stateName: x.stateName,
      position: Position(
        type: x.position!.type,
        coordinates: x.position!.coordinates,
        longitude: x.position!.coordinates.first,
        latitude: x.position!.coordinates.last,
      ),
    );
    return k;
  }
}

class GioParams {
  String? organizationId;
  String? projectId;
  String? userId;

  late String directoryPath;
  late SendPort sendPort;
  late String token;
  late String startDate;
  late String endDate;
  late String url;
  late int activityStreamHours;

  GioParams(
      {required this.organizationId,
      required this.directoryPath,
      required this.sendPort,
      required this.token,
      required this.startDate,
      required this.endDate,
      required this.url,
      required this.projectId,
      required this.userId,
      required this.activityStreamHours});
}

///running inside isolate
Future<DataBag?> _heavyTaskInsideIsolate(GioParams gioParams) async {
  final xx = '🐤🐤🐤🐤 _heavyTaskInsideIsolate: 🐤🐤🐤🐤 '
      'activityStreamHours: ${gioParams.activityStreamHours}';

  pp('$xx starting ................');
  // gioParams.sendPort.send(
  //     'Heavy Task starting .... call method for org or project or user ...');

  DataBag? bag;
  if (gioParams.organizationId != null) {
    bag = await refreshOrganizationDataInIsolate(
        token: gioParams.token,
        organizationId: gioParams.organizationId!,
        startDate: gioParams.startDate,
        endDate: gioParams.endDate,
        url: gioParams.url,
        activityStreamHours: gioParams.activityStreamHours,
        directoryPath: gioParams.directoryPath);
  }
  if (gioParams.projectId != null) {
    bag = await refreshProjectDataInIsolate(
        token: gioParams.token,
        projectId: gioParams.projectId!,
        startDate: gioParams.startDate,
        endDate: gioParams.endDate,
        url: gioParams.url,
        activityStreamHours: gioParams.activityStreamHours,
        directoryPath: gioParams.directoryPath);
  }
  if (gioParams.userId != null) {
    bag = await refreshUserDataInIsolate(
        token: gioParams.token,
        userId: gioParams.userId!,
        startDate: gioParams.startDate,
        endDate: gioParams.endDate,
        url: gioParams.url,
        activityStreamHours: gioParams.activityStreamHours,
        directoryPath: gioParams.directoryPath);
  }

  pp('🔷🔷🔷🔷 heavyTaskInsideIsolate completed, 🔷bag to be returned to the other side via sendPort');
  //gioParams.sendPort.send(bag);
  return bag;
}
