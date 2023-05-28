import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart' as fb;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geo_monitor/library/api/data_api_og.dart';
import 'package:geo_monitor/library/bloc/data_refresher.dart';
import 'package:geo_monitor/library/bloc/isolate_handler.dart';
import 'package:geo_monitor/library/bloc/location_request_handler.dart';
import 'package:geo_monitor/library/data/activity_model.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:universal_platform/universal_platform.dart';

import '../../device_location/device_location_bloc.dart';
import '../api/prefs_og.dart';
import '../auth/app_auth.dart';
import '../cache_manager.dart';
import '../data/audio.dart';
import '../data/condition.dart';
import '../data/geofence_event.dart';
import '../data/location_request.dart';
import '../data/location_response.dart';
import '../data/org_message.dart';
import '../data/photo.dart';
import '../data/project.dart';
import '../data/project_polygon.dart';
import '../data/project_position.dart';
import '../data/settings_model.dart';
import '../data/user.dart';
import '../data/video.dart';
import '../emojis.dart';
import '../functions.dart';
import 'organization_bloc.dart';
import 'theme_bloc.dart';

late FCMBloc fcmBloc;
const mm = '🔵🔵🔵🔵🔵🔵 FCMBloc: 🔵🔵 ';

class FCMBloc {
  late IsolateDataHandler isolateHandler;
  final fb.FirebaseMessaging firebaseMessaging;
  final CacheManager cacheManager;
  final LocationRequestHandler locationRequestHandler;

  FCMBloc(
    this.firebaseMessaging,
    this.cacheManager,
    this.locationRequestHandler,
  ) {
    isolateHandler = IsolateDataHandler(
      prefsOGx,
      appAuth,
      cacheManager,
    );
  }

  final StreamController<User> userController = StreamController.broadcast();
  final StreamController<LocationResponse> _locationResponseController =
      StreamController.broadcast();

  final StreamController<Project> _projectController =
      StreamController.broadcast();
  final StreamController<ProjectPosition> _projectPositionController =
      StreamController.broadcast();
  final StreamController<ProjectPolygon> _projectPolygonController =
      StreamController.broadcast();
  final StreamController<Photo> _photoController = StreamController.broadcast();
  final StreamController<Video> _videoController = StreamController.broadcast();
  final StreamController<Audio> _audioController = StreamController.broadcast();

  final StreamController<ActivityModel> _activityController =
      StreamController.broadcast();

  final StreamController<Condition> _conditionController =
      StreamController.broadcast();
  final StreamController<OrgMessage> _messageController =
      StreamController.broadcast();
  final StreamController<String> _killController = StreamController.broadcast();

  final StreamController<SettingsModel> settingsStreamController =
      StreamController.broadcast();
  final StreamController<GeofenceEvent> _geofenceController =
      StreamController.broadcast();

  Stream<ActivityModel> get activityStream => _activityController.stream;
  Stream<LocationResponse> get locationResponseStream =>
      _locationResponseController.stream;

  Stream<GeofenceEvent> get geofenceStream => _geofenceController.stream;
  Stream<SettingsModel> get settingsStream => settingsStreamController.stream;

  Stream<User> get userStream => userController.stream;
  Stream<Project> get projectStream => _projectController.stream;
  Stream<ProjectPosition> get projectPositionStream =>
      _projectPositionController.stream;
  Stream<ProjectPolygon> get projectPolygonStream =>
      _projectPolygonController.stream;

  Stream<Photo> get photoStream => _photoController.stream;
  Stream<Video> get videoStream => _videoController.stream;
  Stream<Audio> get audioStream => _audioController.stream;
  Stream<Condition> get conditionStream => _conditionController.stream;
  Stream<OrgMessage> get messageStream => _messageController.stream;
  Stream<String> get killStream => _killController.stream;

  User? user;
  void closeStreams() {
    _geofenceController.close();
    userController.close();
    _projectController.close();
    _photoController.close();
    _videoController.close();
    _conditionController.close();
    _messageController.close();
    settingsStreamController.close();
    _killController.close();
    _projectPositionController.close();
    _projectPolygonController.close();
  }

  Future initialize() async {
    // pp("$mm initialize ....... FIREBASE MESSAGING ...........................");
    user = await prefsOGx.getUser();

    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    pp('$mm initialize: User granted permission: ${settings.authorizationStatus}');

    firebaseMessaging.setAutoInitEnabled(true);
    firebaseMessaging.onTokenRefresh.listen((newToken) {
      pp("$mm onTokenRefresh: 🍎 🍎 🍎 update user: token: $newToken ... 🍎 🍎 ");
      user!.fcmRegistration = newToken;
      dataApiDog.updateUser(user!);
    });

    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);

    FlutterLocalNotificationsPlugin().initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

    fb.FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // RemoteNotification? notification = message.notification;
      // AndroidNotification? android = message.notification?.android;
      if (message.data['activity'] != null) {
        pp("$mm onMessage: 🍎 🍎 activity message has arrived!  ... 🍎 🍎 ");
      } else if (message.data['geofenceEvent'] != null) {
        pp("$mm onMessage: 🍎 🍎 geofenceEvent message has arrived!  ... 🍎 🍎 ");
      } else if (message.data['locationRequest'] != null) {
        pp("$mm onMessage: 🍎 🍎 locationRequest message has arrived!  ... 🍎 🍎 ");
      } else if (message.data['locationResponse'] != null) {
        pp("$mm onMessage: 🍎 🍎 locationResponse message has arrived!  ... 🍎 🍎 ");
      } else if (message.data['user'] != null) {
        pp("$mm onMessage: 🍎 🍎 user message has arrived!  ... 🍎 🍎\n ");
      } else {
        pp("$mm onMessage: 🍎 🍎 some other geo message has arrived!  ... 🍎 🍎 ");
      }
      processFCMMessage(message);
    });

    fb.FirebaseMessaging.onBackgroundMessage(
        geoFirebaseMessagingBackgroundHandler);

    fb.FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      pp('$mm onMessageOpenedApp:  🍎 🍎 A new onMessageOpenedApp event was published! ${message.data}');
    });
    subscribeToTopics();
  }

  Future subscribeToTopics() async {
    var user = await prefsOGx.getUser();
    if (user == null) {
      pp('User is null ... what de fuck??? ${E.redDot}${E.redDot}${E.redDot}${E.redDot}${E.redDot}${E.redDot}${E.redDot}${E.redDot}');
      return;
    }

    pp("$mm ..... subscribe to Gio FCM Topics ...........................");
    final start = DateTime.now();
    try {
      await firebaseMessaging
          .subscribeToTopic('activities_${user.organizationId}');
      pp('$mm ..... subscribed to activities');
      await firebaseMessaging
          .subscribeToTopic('projects_${user.organizationId}');
      pp('$mm ..... subscribed to projects');
      await firebaseMessaging
          .subscribeToTopic('projectPositions_${user.organizationId}');
      pp('$mm ..... subscribed to projectPositions_');
      await firebaseMessaging
          .subscribeToTopic('projectPolygons_${user.organizationId}');
      pp('$mm ..... subscribed to projectPolygons_');
      await firebaseMessaging.subscribeToTopic('photos_${user.organizationId}');
      pp('$mm ..... subscribed to photos_');
      await firebaseMessaging.subscribeToTopic('videos_${user.organizationId}');
      pp('$mm ..... subscribed to videos_');
      await firebaseMessaging
          .subscribeToTopic('conditions_${user.organizationId}');
      pp('$mm ..... subscribed to conditions_');
      await firebaseMessaging
          .subscribeToTopic('messages_${user.organizationId}');
      pp('$mm ..... subscribed to messages_');
      await firebaseMessaging.subscribeToTopic('users_${user.organizationId}');
      pp('$mm ..... subscribed to users_');
      await firebaseMessaging.subscribeToTopic('audios_${user.organizationId}');
      pp('$mm ..... subscribed to audios_');
      await firebaseMessaging.subscribeToTopic('kill_${user.organizationId}');
      pp('$mm ..... subscribed to kill_');
      await firebaseMessaging
          .subscribeToTopic('locationRequests_${user.organizationId}');
      pp('$mm ..... subscribed to locationRequests_');
      await firebaseMessaging
          .subscribeToTopic('locationResponses_${user.organizationId}');
      pp('$mm ..... subscribed to locationResponses_');
      await firebaseMessaging
          .subscribeToTopic('settings_${user.organizationId}');
      pp('$mm ..... subscribed to settings_');
      await firebaseMessaging
          .subscribeToTopic('geofenceEvents_${user.organizationId}');
      pp('$mm ..... subscribed to geofenceEvents_');
      final end = DateTime.now();
      // prefsOGz.setFCMSubscriptionFlag();
      pp("\n\n$mm subscribeToTopics: 🍎 subscription process has been started for all 14 organization topics 🍎"
          " Elapsed time: ${end.difference(start).inMilliseconds} milliseconds\n");
    } catch (e) {
      pp('$mm Problem with subscribing to topics! \n$e');
    }
    return null;
  }

  final blue = '🔵🔵🔵';
  Future processFCMMessage(fb.RemoteMessage message) async {
    // pp('$mm processFCMMessage: $blue processing newly arrived FCM message; messageId:: ${message.messageId}');

    Map data = message.data;
    if (data['settings'] != null) {
      pp('$mm Yebo! Settings have arrived! $data');
    }

    await parseRemoteMessage(data);

    return null;
  }

  Future<void> parseRemoteMessage(Map<dynamic, dynamic> data) async {
    await GetStorage.init(cacheName);
    User? user = await prefsOGx.getUser();
    if (data['kill'] != null) {
      pp("$mm processFCMMessage:  $blue ........................... 🍎🍎🍎🍎🍎🍎kill USER!!  🍎  🍎 ");
      var m = jsonDecode(data['kill']);
      var receivedUser = User.fromJson(m);

      if (receivedUser.userId! == user!.userId!) {
        pp("$mm processFCMMessage  $blue This act is about to be killed: ${receivedUser.name!} ......");
        prefsOGx.deleteUser();
        auth.FirebaseAuth.instance.signOut();
        pp('$mm 🌀🌀🌀🌀  🍎 Signed out of Firebase!!! 🍎 ');

        await _handleCache(receivedUser);
        _killController.sink.add(
            "Your app has been disabled. If you need to, please talk to your supervisor or administrator");
      } else {
        await _handleCache(receivedUser);
        pp('🌀🌀🌀🌀🍎 User should be deleted from Hive cache by now! 🍎 ');
      }
    }
    if (data['locationRequest'] != null) {
      pp("$mm processFCMMessage  🔵 🔵 🔵 ........................... LOCATION REQUEST  🍎  🍎 ");
      var m = jsonDecode(data['locationRequest']);
      var req = LocationRequest.fromJson(m);

      if (user!.userId == req.userId) {
        pp("$mm processFCMMessage  🔵 🔵 🔵 ........................... sending location response");
        var loc = await locationBloc.getLocation();
        if (loc != null) {
          await locationRequestHandler.sendLocationResponse(
              user: user,
              latitude: loc.latitude!,
              longitude: loc.longitude!,
              requesterId: req.requesterId!,
              requesterName: req.requesterName!);

          pp('$mm act responded to location request');
        } else {
          pp('$mm Location not available');
        }
      }
    }
    if (data['locationResponse'] != null) {
      pp("$mm processFCMMessage  🔵 🔵 🔵 ........................... LOCATION RESPONSE  🍎  🍎 ");
      var m = jsonDecode(data['locationResponse']);
      var locationResponse = LocationResponse.fromJson(m);

      if (user!.userId == locationResponse.requesterId) {
        pp('$mm act responded to location request ... do something with response');
        await cacheManager.addLocationResponse(
            locationResponse: locationResponse);

        _locationResponseController.sink.add(locationResponse);
      }
    }
    if (data['activity'] != null) {
      pp("$mm processFCMMessage  🔵 🔵 🔵 ........................... cache ACTIVITY  🍎  🍎 ");
      var m = jsonDecode(data['activity']);
      var act = ActivityModel.fromJson(m);
      await cacheManager.addActivityModel(activity: act);
      _activityController.sink.add(act);
    }
    if (data['user'] != null) {
      pp("$mm processFCMMessage  🔵 🔵 🔵 ........................... cache USER  🍎  🍎 ");
      var m = jsonDecode(data['user']);
      var mUser = User.fromJson(m);
      if (mUser.userId == user!.userId) {
        await prefsOGx.saveUser(mUser);
      }
      await cacheManager.addUser(user: user);
      userController.sink.add(user);
    }
    if (data['project'] != null) {
      pp("$mm processFCMMessage  🔵 🔵 🔵 ........................... cache PROJECT  🍎  🍎");
      var m = jsonDecode(data['project']);
      var project = Project.fromJson(m);
      await cacheManager.addProject(project: project);
      _projectController.sink.add(project);
    }
    if (data['projectPosition'] != null) {
      pp("$mm processFCMMessage  🔵 🔵 🔵 ........................... cache PROJECT POSITION 🍎  🍎");
      var m = jsonDecode(data['projectPosition']);
      var projectPosition = ProjectPosition.fromJson(m);
      await cacheManager.addProjectPosition(projectPosition: projectPosition);
      _projectPositionController.sink.add(projectPosition);
    }
    if (data['projectPolygon'] != null) {
      pp("$mm processFCMMessage  🔵 🔵 🔵 ........................... cache PROJECT POLYGON 🍎  🍎");
      var m = jsonDecode(data['projectPolygon']);
      var projectPolygon = ProjectPolygon.fromJson(m);
      await cacheManager.addProjectPolygon(projectPolygon: projectPolygon);
      _projectPolygonController.sink.add(projectPolygon);
    }
    if (data['photo'] != null) {
      pp("$mm processFCMMessage  🔵 🔵 🔵 ........................... cache PHOTO  🍎  🍎");
      var m = jsonDecode(data['photo']);
      var photo = Photo.fromJson(m);
      var res = await cacheManager.addPhoto(photo: photo);
      pp('$mm Photo received added to local cache:  🔵 🔵 ${photo.projectName} result: $res, sending to photo stream');
      _photoController.sink.add(photo);
    }
    if (data['video'] != null) {
      pp("$mm processFCMMessage  🔵 🔵 🔵 ........................... cache VIDEO  🍎  🍎");
      var m = jsonDecode(data['video']);
      var video = Video.fromJson(m);
      await cacheManager.addVideo(video: video);
      pp('$mm Video received added to local cache:  🔵 🔵 ${video.projectName}, sending to video stream');
      _videoController.sink.add(video);
    }
    if (data['audio'] != null) {
      pp("$mm processFCMMessage  🔵 🔵 🔵 ........................... cache AUDIO  🍎  🍎");
      var m = jsonDecode(data['audio']);
      var audio = Audio.fromJson(m);
      await cacheManager.addAudio(audio: audio);
      pp('$mm Audio received added to local cache:  🔵 🔵 ${audio.projectName}, sending to audio stream');
      _audioController.sink.add(audio);
    }
    if (data['condition'] != null) {
      pp("$mm processFCMMessage  🔵 🔵 🔵 ........................... cache CONDITION  🍎  🍎");
      var m = jsonDecode(data['condition']);
      var condition = Condition.fromJson(m);
      await cacheManager.addCondition(condition: condition);
      pp('$mm condition received added to local cache:  🔵 🔵 ${condition.projectName}, sending to condition stream');
      _conditionController.sink.add(condition);
    }
    if (data['message'] != null) {
      pp("$mm processFCMMessage  🔵 🔵 🔵 ........................... cache ORG MESSAGE  🍎  🍎");
      var m = jsonDecode(data['message']);
      var msg = OrgMessage.fromJson(m);
      await cacheManager.addOrgMessage(message: msg);
      if (user!.userId != msg.adminId) {
        _messageController.sink.add(msg);
      }
    }
    if (data['settings'] != null) {
      pp("$mm processFCMMessage  🔵 🔵 🔵 ........................... cache SETTINGS and change THEME  🍎  🍎");
      var m = jsonDecode(data['settings']);
      var settings = SettingsModel.fromJson(m);
      await cacheManager.addSettings(settings: settings);
      if (settings.projectId == null) {
        pp('$mm This is an organization-wide setting, update the cached settings ...');
        await prefsOGx.saveSettings(settings);
        await cacheManager.addSettings(settings: settings);
        await themeBloc.changeToTheme(settings.themeIndex!);
        settingsStreamController.sink.add(settings);
        await isolateHandler.getOrganizationData();
        pp('$mm This is an organization-wide setting,  🍎 🍎 🍎 hopefully the ui changes to new color ...');
      }
    }
    if (data['geofenceEvent'] != null) {
      pp("$mm processFCMMessage  🔵 🔵 🔵 ........................... cache GEOFENCE EVENT  🍎  🍎");
      var m = jsonDecode(data['geofenceEvent']);
      var msg = GeofenceEvent.fromJson(m);
      await cacheManager.addGeofenceEvent(geofenceEvent: msg);
      _geofenceController.sink.add(msg);
    }
  }

  Future<void> _handleCache(User receivedUser) async {
    pp('$mm handling cache and removing user from cache');
    await cacheManager.deleteUser(user: receivedUser);
    var list = await cacheManager.getUsers();
    organizationBloc.userController.sink.add(list);
  }

  void onDidReceiveNotificationResponse(NotificationResponse details) {
    pp('$mm onDidReceiveNotificationResponse ... details: ${details.payload}');
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    pp('$mm onDidReceiveLocalNotification:  🍎 maybe display a dialog with the notification details - maybe put this on a stream ...');
    pp('$mm title: $title  🍎 body: $body with some payload ...');
    pp('$mm payload: $payload  🍎');
  }
}

const vv = '🔵🔵🔵🔵🔵🔵 geoFirebaseMessagingBackgroundHandler: ';

///
/// handling fcm messages that arrive when app is the background
///
@pragma('vm:entry-point')
Future<void> geoFirebaseMessagingBackgroundHandler(
    fb.RemoteMessage message) async {
  pp('\n\n\n$vv  Received FCM messaging while in the background ... ');
  pp("\n\n$vv  onMessage: 🍎 🍎 data: ${message.data} ... 🍎 🍎\n ");

  await GetStorage.init(cacheName);
  var user = await prefsOGx.getUser();
  Map data = message.data;
  if (data['locationRequest'] == null) {
    //todo - ignoring other message types
    pp('$vv ignoring other message types while in background');
    return;
  }
  try {
    await Firebase.initializeApp();
  } catch (e) {
    pp(e);
  }

  var pos = await locationBloc.getLocation();
  pp('$vv location update happened: $pos - handle particular messages '
      'eg. location request and response');

  pp('$vv calling fcmBloc.parseRemoteMessage in background mode');

  if (data['locationRequest'] != null) {
    pp("$vv processFCMMessage  🔵 🔵 🔵 ........................... "
        "LOCATION REQUEST  🍎  🍎 ");
    var m = jsonDecode(data['locationRequest']);
    var req = LocationRequest.fromJson(m);

    if (user!.userId == req.userId) {
      pp("$vv handling loc request!  🔵 🔵 🔵 ......... I am the target of a location request "
          "sending location response ... ");

      await locationRequestHandler.sendLocationResponse(
          user: user,
          latitude: pos!.latitude!,
          longitude: pos.longitude!,
          requesterId: req.requesterId!,
          requesterName: req.requesterName!);

      pp('$vv user has responded to location request in background! yea!');
    }
  }
}
