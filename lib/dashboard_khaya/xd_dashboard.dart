import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geo_monitor/dashboard_khaya/project_list.dart';
import 'package:geo_monitor/dashboard_khaya/real_dashboard.dart';
import 'package:geo_monitor/dashboard_khaya/recent_event_list.dart';
import 'package:geo_monitor/dashboard_khaya/xd_header.dart';
import 'package:geo_monitor/library/api/prefs_og.dart';
import 'package:geo_monitor/library/bloc/ios_polling_control.dart';
import 'package:geo_monitor/library/bloc/old_to_realm.dart';
import 'package:geo_monitor/library/bloc/organization_bloc.dart';
import 'package:geo_monitor/library/bloc/refresh_bloc.dart';
import 'package:geo_monitor/library/data/activity_model.dart';
import 'package:geo_monitor/library/data/audio.dart';
import 'package:geo_monitor/library/data/geofence_event.dart';
import 'package:geo_monitor/library/data/location_request.dart';
import 'package:geo_monitor/library/data/location_response.dart';
import 'package:geo_monitor/library/data/org_message.dart';
import 'package:geo_monitor/library/data/photo.dart';
import 'package:geo_monitor/library/data/project_polygon.dart';
import 'package:geo_monitor/library/data/project_position.dart';
import 'package:geo_monitor/library/data/user.dart';
import 'package:geo_monitor/library/data/video.dart';
import 'package:geo_monitor/library/functions.dart';
import 'package:geo_monitor/library/generic_functions.dart';
import 'package:geo_monitor/library/ui/camera/gio_video_player.dart';
import 'package:geo_monitor/library/ui/maps/project_map_mobile.dart';
import 'package:geo_monitor/library/ui/media/time_line/project_media_timeline.dart';
import 'package:geo_monitor/library/ui/project_list/gio_projects.dart';
import 'package:geo_monitor/realm_data/data/realm_sync_api.dart';
import 'package:geo_monitor/ui/activity/gio_activities.dart';
import 'package:geo_monitor/ui/audio/gio_audio_player.dart';
import 'package:geo_monitor/ui/dashboard/photo_frame.dart';
import 'package:geo_monitor/ui/intro/intro_main.dart';
import 'package:geo_monitor/ui/subscription/subscription_selection.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:universal_platform/universal_platform.dart';

import '../l10n/translation_handler.dart';
import '../library/api/data_api_og.dart';
import '../library/bloc/cloud_storage_bloc.dart';
import '../library/bloc/fcm_bloc.dart';
import '../library/bloc/geo_uploader.dart';
import '../library/bloc/isolate_handler.dart';
import '../library/bloc/project_bloc.dart';
import '../library/bloc/theme_bloc.dart';
import '../library/cache_manager.dart';
import '../library/data/activity_type_enum.dart';
import '../library/data/data_bag.dart';
import '../library/data/project.dart';
import '../library/data/settings_model.dart';
import '../library/ui/loading_card.dart';
import '../library/ui/maps/geofence_map_tablet.dart';
import '../library/ui/maps/org_map_mobile.dart';
import '../library/ui/maps/project_polygon_map_mobile.dart';
import '../library/ui/settings/settings_main.dart';
import '../library/users/edit/user_edit_main.dart';
import '../library/users/list/geo_user_list.dart';
import '../library/utilities/transitions.dart';
import '../stitch/stitch_service.dart';
import 'member_list.dart';
import 'package:geo_monitor/realm_data/data/schemas.dart' as mrm;

class DashboardKhaya extends StatefulWidget {
  const DashboardKhaya(
      {Key? key,
      required this.dataApiDog,
      required this.fcmBloc,
      required this.organizationBloc,
      required this.projectBloc,
      required this.prefsOGx,
      required this.cacheManager,
      required this.dataHandler,
      required this.geoUploader,
      required this.cloudStorageBloc,
      required this.firebaseAuth,
      required this.stitchService,
      required this.refreshBloc,
      required this.realmSyncApi})
      : super(key: key);

  final DataApiDog dataApiDog;
  final FCMBloc fcmBloc;
  final OrganizationBloc organizationBloc;
  final ProjectBloc projectBloc;
  final PrefsOGx prefsOGx;
  final CacheManager cacheManager;
  final IsolateDataHandler dataHandler;
  final GeoUploader geoUploader;
  final CloudStorageBloc cloudStorageBloc;
  final auth.FirebaseAuth firebaseAuth;
  final StitchService stitchService;
  final RefreshBloc refreshBloc;
  final RealmSyncApi realmSyncApi;

  @override
  State<DashboardKhaya> createState() => DashboardKhayaState();
}

class DashboardKhayaState extends State<DashboardKhaya>
    with WidgetsBindingObserver {
  var totalEvents = 0;
  var totalProjects = 0;
  var totalUsers = 0;
  mrm.User? user;
  String? dashboardText;
  String? eventsText, recentEventsText;
  String? projectsText;
  String? membersText, loadingDataText;
  bool busy = false;

  var projects = <mrm.Project>[];
  var events = <mrm.ActivityModel>[];
  var users = <mrm.User>[];
  late StreamSubscription<Photo> photoSubscriptionFCM;
  late StreamSubscription<Video> videoSubscriptionFCM;
  late StreamSubscription<Audio> audioSubscriptionFCM;
  late StreamSubscription<ProjectPosition> projectPositionSubscriptionFCM;
  late StreamSubscription<ProjectPolygon> projectPolygonSubscriptionFCM;
  late StreamSubscription<Project> projectSubscriptionFCM;
  late StreamSubscription<GeofenceEvent> geofenceSubscriptionFCM;
  late StreamSubscription<User> userSubscriptionFCM;
  late StreamSubscription<SettingsModel> settingsSubscriptionFCM;
  late StreamSubscription<String> killSubscriptionFCM;
  late StreamSubscription<bool> connectionSubscription;
  late StreamSubscription<GeofenceEvent> geofenceSubscription;

  //
  late StreamSubscription<Photo> photoSubscription;
  late StreamSubscription<Video> videoSubscription;
  late StreamSubscription<Audio> audioSubscription;
  late StreamSubscription<ProjectPosition> projectPositionSubscription;
  late StreamSubscription<ProjectPolygon> projectPolygonSubscription;
  late StreamSubscription<Project> projectSubscription;

  late StreamSubscription<SettingsModel> settingsSubscription;
  late StreamSubscription<ActivityModel> activitySubscription;

  late StreamSubscription<DataBag> dataBagSubscription;
  late StreamSubscription<bool> refreshSub;
  static const mm = '🥬🥬🥬🥬🥬🥬DashboardKhaya: 🥬🥬';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _getUser();
  }

  AppLifecycleState? _notification;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    pp('$mm Gio app is Flipping background state to: $state }');
    bool isBackground = false;
    switch (state.index) {
      case 0:
        break;
      case 1:
        isBackground = true;
        break;
    }
    backgroundObserver.backgroundObserverStreamController.sink
        .add(isBackground);
    setState(() {
      _notification = state;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    settingsSubscription.cancel();
    activitySubscription.cancel();
    dataBagSubscription.cancel();
    audioSubscription.cancel();
    photoSubscription.cancel();
    videoSubscription.cancel();
    settingsSubscriptionFCM.cancel();
    userSubscriptionFCM.cancel();
    geofenceSubscription.cancel();
    projectPositionSubscription.cancel();
    projectPositionSubscriptionFCM.cancel();
    projectPolygonSubscription.cancel();
    projectPolygonSubscriptionFCM.cancel();
    super.dispose();
  }

  Future<void> _handleGeofenceEvent(GeofenceEvent event) async {
    pp('$mm _handleGeofenceEvent ... ');
    //events.insert(0, event);
    var settings = await prefsOGx.getSettings();
    var arr = await translator.translate('memberArrived', settings.locale!);

    if (event.projectName != null) {
      var arrivedAt = arr.replaceAll('\$project', event.projectName!);
      if (mounted) {
        var color = getTextColorForBackground(Theme.of(context).primaryColor);
        var brightness = MediaQuery.of(context).platformBrightness;
        bool isDarkMode = brightness == Brightness.dark;

        if (!isDarkMode) {
          color = Colors.white;
        }
        showToast(
            duration: const Duration(seconds: 5),
            backgroundColor: Theme.of(context).primaryColor,
            padding: 20,
            toastGravity: ToastGravity.TOP,
            textStyle: myTextStyleSmallWithColor(context, color),
            message: arrivedAt,
            context: context);
      }
    }
  }

  Future<void> _handleNewSettings(SettingsModel settings) async {
    Locale newLocale = Locale(settings.locale!);
    _setTexts();
    final m =
        LocaleAndTheme(themeIndex: settings.themeIndex!, locale: newLocale);
    themeBloc.themeStreamController.sink.add(m);
    _getData();
  }

  // void _listenForFCM() async {
  //   var android = UniversalPlatform.isAndroid;
  //   var ios = UniversalPlatform.isIOS;
  //   // if (android || ios) {
  //   pp('$mm 🍎 🍎 _listen to FCM message streams ... 🍎 🍎');
  //   geofenceSubscriptionFCM =
  //       widget.fcmBloc.geofenceStream.listen((GeofenceEvent event) async {
  //     pp('$mm: 🍎geofenceSubscriptionFCM: 🍎 GeofenceEvent: '
  //         'user ${event.userName} arrived: ${event.projectName} ');
  //     _handleGeofenceEvent(event);
  //   });
  //
  //   activitySubscription =
  //       widget.fcmBloc.activityStream.listen((ActivityModel event) async {
  //     pp('\n\n$mm: 🍎activitySubscription delivered 🍎 ActivityModel: '
  //         ' ${event.date} \n');
  //     events.insert(0, event);
  //     totalEvents++;
  //     if (mounted) {
  //       setState(() {});
  //     }
  //   });
  //
  //   projectSubscriptionFCM =
  //       widget.fcmBloc.projectStream.listen((Project project) async {
  //     _getCachedData();
  //     if (mounted) {
  //       pp('$mm: 🍎 🍎 project arrived: ${project.name} ... 🍎 🍎');
  //       setState(() {});
  //     }
  //   });
  //
  //   settingsSubscriptionFCM =
  //       widget.fcmBloc.settingsStream.listen((settings) async {
  //     pp('$mm: 🍎🍎 settingsSubscriptionFCM: settings arrived with themeIndex: ${settings.themeIndex}... 🍎🍎');
  //     _handleNewSettings(settings);
  //   });
  //
  //   userSubscriptionFCM = widget.fcmBloc.userStream.listen((u) async {
  //     pp('$mm: 🍎 🍎 user arrived... 🍎 🍎');
  //     if (u.userId == user!.userId!) {
  //       user = u;
  //     }
  //     _getCachedData();
  //   });
  //
  //   photoSubscriptionFCM = widget.fcmBloc.photoStream.listen((photo) async {
  //     pp('$mm: 🍎 🍎 photoSubscriptionFCM photo arrived... 🍎 🍎');
  //     _getCachedData();
  //   });
  //
  //   videoSubscriptionFCM =
  //       widget.fcmBloc.videoStream.listen((Video message) async {
  //     pp('$mm: 🍎 🍎 videoSubscriptionFCM video arrived... 🍎 🍎');
  //     _getCachedData();
  //   });
  //
  //   audioSubscriptionFCM =
  //       widget.fcmBloc.audioStream.listen((Audio message) async {
  //     pp('$mm: 🍎 🍎 audioSubscriptionFCM audio arrived... 🍎 🍎');
  //     _getCachedData();
  //   });
  //
  //   projectPositionSubscriptionFCM = widget.fcmBloc.projectPositionStream
  //       .listen((ProjectPosition message) async {
  //     pp('$mm: 🍎 🍎 projectPositionSubscriptionFCM position arrived... 🍎 🍎');
  //     _getCachedData();
  //   });
  //
  //   projectPolygonSubscriptionFCM = widget.fcmBloc.projectPolygonStream
  //       .listen((ProjectPolygon message) async {
  //     pp('$mm: 🍎 🍎 projectPolygonSubscriptionFCM polygon arrived... 🍎 🍎');
  //     _getCachedData();
  //     if (mounted) {}
  //   });
  //
  //   dataBagSubscription =
  //       widget.organizationBloc.dataBagStream.listen((DataBag bag) async {
  //     pp('$mm: 🍎 🍎 dataBagStream bag arrived... 🍎 🍎');
  //     if (bag.projects != null) {
  //       projects = bag.projects!;
  //       totalProjects = projects.length;
  //     }
  //     if (bag.users != null) {
  //       users = bag.users!;
  //       totalUsers = users.length;
  //     }
  //     if (bag.activityModels != null) {
  //       events = bag.activityModels!;
  //       totalEvents = events.length;
  //     }
  //     if (mounted) {
  //       setState(() {});
  //     }
  //   });
  //
  //   refreshSub = widget.refreshBloc.refreshStream.listen((event) {
  //     pp('$mm refreshStream delivered a command, call getData with forceRefresh = true ... ');
  //     _getData();
  //   });
  // }

  var images = <Image>[];
  late SettingsModel settingsModel;

  void _getUser() async {
    var u = await widget.prefsOGx.getUser();
    user = OldToRealm.getUser(u!);
    settingsModel = await widget.prefsOGx.getSettings();
    setState(() {});
    _setTexts();
  }

  void _getData() async {
    try {
      pp('$mm _getData ...................................... forceRefresh: $forceRefresh  ');
      setState(() {
        busy = true;
      });
      final m =
          await getStartEndDates(numberOfDays: settingsModel.numberOfDays!);
      // final bag = await widget.organizationBloc.getOrganizationData(
      //     organizationId: user!.organizationId!,
      //     forceRefresh: true,
      //     startDate: m['startDate']!,
      //     endDate: m['endDate']!);
      final counts = await widget.dataApiDog.getOrganizationDataCounts(
          settingsModel.organizationId!,
          m['startDate']!,
          m['endDate']!,
          settingsModel.activityStreamHours!);

      totalProjects = counts.projects!;
      totalEvents = counts.activities!;
      totalUsers = counts.users!;

      // events = await organizationBloc.getCachedOrganizationActivity(
      //     organizationId: settingsModel.organizationId!,
      //     hours: settingsModel.activityStreamHours!);
      // users = bag.users!;
      //
      // totalEvents = events.length;
      /*
      projectId: "someId",
    name: "Studio 3T",
    organization: "829c3f4e-eaa7-42b5-9a38-7d57f097b074"
       */
      // totalUsers = users.length;
      // totalProjects = projects.length;
    } catch (e) {
      if (mounted) {
        pp('$mm showSnack with error : $e');
        showSnackBar(
            message: serverProblem == null ? 'Server Problem' : serverProblem!,
            context: context,
            backgroundColor: Theme.of(context).primaryColorDark,
            duration: const Duration(seconds: 15),
            padding: 16);
      }
    }
    setState(() {
      busy = false;
    });
  }

  String? serverProblem, videoTitle;
  late String deviceType, startDate;
  late SettingsModel settings;

  void _setTexts() async {
    settings = await widget.prefsOGx.getSettings();
    loadingDataText =
        await translator.translate('loadingActivities', settings.locale!);
    dashboardText = await translator.translate('dashboard', settings.locale!);
    eventsText = await translator.translate('events', settings.locale!);
    projectsText = await translator.translate('projects', settings.locale!);
    membersText = await translator.translate('members', settings.locale!);
    videoTitle = await translator.translate('videos', settings.locale!);

    recentEventsText =
        await translator.translate('recentEvents', settings.locale!);
    serverProblem =
        await translator.translate('serverProblem', settings.locale!);

    deviceType = getThisDeviceType();
    startDate =
        getStartEndDatesFromDays(numberOfDays: settings.numberOfDays!).$1;
    setState(() {});
  }

  bool refreshRequired = false;

  void _navigateToSettings() {
    pp(' 🌀🌀🌀🌀 .................. _navigateToSettings to Settings ....');
    navigateWithScale(
        SettingsMain(
          dataHandler: widget.dataHandler,
          dataApiDog: widget.dataApiDog,
          prefsOGx: widget.prefsOGx,
          cacheManager: widget.cacheManager,
          realmSyncApi: realmSyncApi,
          project: null,
          fcmBloc: widget.fcmBloc,
          geoUploader: widget.geoUploader,
          cloudStorageBloc: widget.cloudStorageBloc,
          organizationBloc: widget.organizationBloc,
          projectBloc: widget.projectBloc,
        ),
        context);
  }

  void _navigateToActivities() {
    pp(' 🌀🌀🌀🌀 .................. _navigateToActivities  ....');
    navigateWithScale(
        GioActivities(
          fcmBloc: widget.fcmBloc,
          organizationBloc: widget.organizationBloc,
          projectBloc: widget.projectBloc,
          dataApiDog: widget.dataApiDog,
          geoUploader: widget.geoUploader,
          cloudStorageBloc: widget.cloudStorageBloc,
          project: null,
          onPhotoTapped: (p) {
            onPhotoTapped(OldToRealm.getPhotoString(p));
          },
          onVideoTapped: (p){
            onVideoTapped(OldToRealm.getVideoString(p));
          },
          onAudioTapped: (p){
            onAudioTapped(OldToRealm.getAudioString(p));
          },
          onUserTapped: (p){
            onUserTapped(OldToRealm.getUserString(p));
          },
          onProjectTapped: (p){
            onProjectTapped(OldToRealm.getProjectString(p));
          },
          onProjectPositionTapped: (p){
            onProjectPositionTapped(OldToRealm.getProjectPositionString(p));
          },
          onPolygonTapped: (p){
            onPolygonTapped(OldToRealm.getProjectPolygonString(p));

          },
          onGeofenceEventTapped: (p){
            onGeofenceEventTapped(OldToRealm.getGeofenceString(p));
          },
          onOrgMessage: (p){},
          onLocationResponse: (p){
            onLocationResponse(OldToRealm.getLocationResponseString(p));
          },
          onLocationRequest: (p){
            onLocationRequest(OldToRealm.getLocationRequestString(p));
          },
          prefsOGx: widget.prefsOGx,
          cacheManager: widget.cacheManager,
          onRefreshRequested: _onRefreshRequested,
        ),
        context);
  }

  void navigateToIntro() {
    navigateWithScale(
        IntroMain(
          prefsOGx: widget.prefsOGx,
          dataApiDog: widget.dataApiDog,
          cacheManager: widget.cacheManager,
          isolateHandler: widget.dataHandler,
          fcmBloc: widget.fcmBloc,
          organizationBloc: widget.organizationBloc,
          geoUploader: widget.geoUploader,
          cloudStorageBloc: widget.cloudStorageBloc,
          stitchService: widget.stitchService,
          refreshBloc: widget.refreshBloc,
          realmSyncApi: realmSyncApi,
          projectBloc: widget.projectBloc,
          firebaseAuth: widget.firebaseAuth,
        ),
        context);
  }

  void navigateToSubscription() {
    navigateWithScale(
        SubscriptionSelection(
          prefsOGx: widget.prefsOGx,
          dataApiDog: widget.dataApiDog,
          stitchService: widget.stitchService,
        ),
        context);
  }

  void _navigateToProjects() {
    pp(' 🌀🌀🌀🌀 .................. _navigateToSettings to Settings ....');

    navigateWithScale(
        GioProjects(
          projectBloc: widget.projectBloc,
          organizationBloc: widget.organizationBloc,
          prefsOGx: widget.prefsOGx,
          dataApiDog: widget.dataApiDog,
          cacheManager: widget.cacheManager,
          instruction: 0,
          realmSyncApi: realmSyncApi,
          fcmBloc: widget.fcmBloc,
          cloudStorageBloc: widget.cloudStorageBloc,
          geoUploader: widget.geoUploader,
        ),
        context);
  }

  void _navigateToMembers() {
    pp(' 🌀🌀🌀🌀 .................. _navigateToSettings to users ....');

    navigateWithScale(
        GioUserList(
            fcmBloc: widget.fcmBloc,
            organizationBloc: widget.organizationBloc,
            projectBloc: widget.projectBloc,
            prefsOGx: widget.prefsOGx,
            cacheManager: widget.cacheManager,
            geoUploader: widget.geoUploader,
            cloudStorageBloc: widget.cloudStorageBloc,
            dataApiDog: widget.dataApiDog),
        context);
  }

  void _onSearchTapped() {
    pp(' ✅✅✅ _onSearchTapped ...');
  }

  void _onDeviceUserTapped() {
    pp('✅✅✅ _onDeviceUserTapped ...');

    navigateWithScale(
        UserEditMain(
          user,
          fcmBloc: widget.fcmBloc,
          organizationBloc: widget.organizationBloc,
          projectBloc: widget.projectBloc,
          dataApiDog: widget.dataApiDog,
          prefsOGx: widget.prefsOGx,
          geoUploader: widget.geoUploader,
          cloudStorageBloc: widget.cloudStorageBloc,
          cacheManager: widget.cacheManager,
        ),
        context);
  }

  bool forceRefresh = false;

  void _onRefreshRequested() {
    pp(' ✅✅✅ .... _onRefreshRequested ... calling broadcastRefresh with true');
    widget.refreshBloc.broadcastRefresh();
  }

  void _onSettingsRequested() {
    pp(' ✅✅✅ _onSettingsRequested ...');
    _navigateToSettings();
  }

  void _onEventsSubtitleTapped() {
    pp('💚💚💚💚 events subtitle tapped');
    _navigateToActivities();
  }

  void _onProjectSubtitleTapped() {
    pp('💚💚💚💚 projects subtitle tapped');
    _navigateToProjects();
  }

  void _onUserSubtitleTapped() {
    pp('💚💚💚💚 users subtitle tapped');
    _navigateToMembers();
  }

  void _onEventTapped(mrm.ActivityModel act) async {
    switch (act.activityType!) {
      case 'projectAdded':
        // TODO: Handle this case.
        break;
      case 'photoAdded':
        onPhotoTapped(act.photo!);
        break;
      case 'videoAdded':
        onVideoTapped(act.video!);
        break;
      case 'audioAdded':
        onAudioTapped(act.audio!);
        break;
      case 'messageAdded':
        onOrgMessage(act.orgMessage!);
        break;
      case 'userAddedOrModified':
        onUserTapped(act.user!);
        break;
      case 'positionAdded':
        onProjectPositionTapped(act.projectPosition!);
        break;
      case 'polygonAdded':
        onProjectPolygonTapped(act.projectPolygon!);
        break;
      case 'settingsChanged':
        onSettingsChanged();
        break;
      case 'geofenceEventAdded':
        onGeofenceEventTapped(act.geofenceEvent!);
        break;
      case 'conditionAdded':
        // TODO: Handle this case.
        break;
      case 'locationRequest':
        onLocationRequest(act.locationRequest!);
        break;
      case 'locationResponse':
        onLocationResponse(act.locationResponse!);
        break;
      case 'kill':
        // TODO: Handle the KILL case.
        break;
    }
  }

  onSettingsChanged() {
    navigateWithScale(
        SettingsMain(
            dataHandler: widget.dataHandler,
            dataApiDog: widget.dataApiDog,
            prefsOGx: widget.prefsOGx,
            organizationBloc: widget.organizationBloc,
            cacheManager: widget.cacheManager,
            projectBloc: widget.projectBloc,
            realmSyncApi: realmSyncApi,
            geoUploader: widget.geoUploader,
            cloudStorageBloc: widget.cloudStorageBloc,
            fcmBloc: widget.fcmBloc),
        context);
  }

  onLocationRequest(String p1) {
    if (deviceType == 'phone') {}
  }

  onUserTapped(String p1) {
    var bb = User.fromJson(jsonDecode(p1));
    var mp = OldToRealm.getUser(bb);
    navigateToUserEdit(mp);
  }

  void navigateToUserEdit(mrm.User? user) async {
    if (user != null) {
      if (user.userType == UserType.fieldMonitor) {
        if (user.userId != user.userId!) {
          return;
        }
      }
    }
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.scale,
            alignment: Alignment.topLeft,
            duration: const Duration(seconds: 1),
            child: UserEditMain(
              user,
              fcmBloc: widget.fcmBloc,
              organizationBloc: widget.organizationBloc,
              projectBloc: widget.projectBloc,
              dataApiDog: widget.dataApiDog,
              geoUploader: widget.geoUploader,
              cloudStorageBloc: widget.cloudStorageBloc,
              prefsOGx: widget.prefsOGx,
              cacheManager: widget.cacheManager,
            )));
  }

  onLocationResponse(String p1) {
    if (deviceType == 'phone') {}
  }

  onPhotoTapped(String p1) {
    deviceType = getThisDeviceType();
    var bb = Photo.fromJson(jsonDecode(p1));
    var mPhoto = OldToRealm.getPhoto(bb);
    setState(() {
      photo = mPhoto;
    });
    if (deviceType == 'phone') {
      if (mounted) {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.scale,
                alignment: Alignment.topLeft,
                duration: const Duration(milliseconds: 1000),
                child: PhotoFrame(
                  photo: mPhoto,
                  onMapRequested: (photo) {},
                  onRatingRequested: (photo) {},
                  elevation: 8.0,
                  cacheManager: widget.cacheManager,
                  dataApiDog: widget.dataApiDog,
                  geoUploader: widget.geoUploader,
                  cloudStorageBloc: widget.cloudStorageBloc,
                  onPhotoCardClose: () {},
                  translatedDate: '',
                  locale: settingsModel.locale!,
                  prefsOGx: widget.prefsOGx,
                  fcmBloc: widget.fcmBloc,
                  projectBloc: widget.projectBloc,
                  organizationBloc: widget.organizationBloc,
                )));
      }
    } else {
      setState(() {
        showPhoto = true;
        showAudio = false;
        playVideo = false;
      });
    }
  }

  onVideoTapped(String p1) {
    deviceType = getThisDeviceType();
    var bb = Video.fromJson(jsonDecode(p1));
    var mVideo = OldToRealm.getVideo(bb);
    setState(() {
      video = mVideo;
    });
    if (deviceType == 'phone') {
      navigateWithSlide(
          PhoneVideoPlayer(
            video: mVideo,
            onCloseRequested: () {},
            dataApiDog: widget.dataApiDog,
            title: videoTitle!,
          ),
          context);
    } else {
      setState(() {
        playAudio = false;
        showPhoto = false;
        playVideo = true;
      });
    }
  }

  mrm.Audio? audio;
  mrm.Video? video;
  mrm.Photo? photo;

  onAudioTapped(String p1) {
    var bb = Audio.fromJson(jsonDecode(p1));
    var mAudio = OldToRealm.getAudio(bb);
    setState(() {
      audio = mAudio;
    });
    deviceType = getThisDeviceType();
    if (deviceType == 'phone') {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => GioAudioPlayer(
              cacheManager: widget.cacheManager,
              prefsOGx: widget.prefsOGx,
              audio: audio!,
              onCloseRequested: () {
                setState(() {
                  playAudio = false;
                });
              },
              dataApiDog: widget.dataApiDog)));
    } else {
      setState(() {
        showAudio = true;
        showPhoto = false;
        playVideo = false;
      });
    }
  }

  onProjectPositionTapped(String p1) async {
    //todo - stop using cacheManager
    var bb = ProjectPosition.fromJson(jsonDecode(p1));
    var ps = OldToRealm.getProjectPosition(bb);
    final proj =
         widget.realmSyncApi.getProject( ps.projectId!);
    if (mounted) {
      navigateWithScale(
          ProjectMapMobile(
            project: proj!,
          ),
          context);
    }
  }

  onProjectPolygonTapped(String p1) async {
    var bb = ProjectPolygon.fromJson(jsonDecode(p1));
    var pp = OldToRealm.getProjectPolygon(bb);
    final proj =
        widget.realmSyncApi.getProject(pp.projectId!);

    if (mounted) {
      navigateWithScale(
          ProjectPolygonMapMobile(
            project: proj!,
          ),
          context);
    }
  }

  onPolygonTapped(String p1) async {
    var bb = ProjectPolygon.fromJson(jsonDecode(p1));
    var mp = OldToRealm.getProjectPolygon(bb);
    final proj =
        widget.realmSyncApi.getProject(mp.projectId!);

    if (mounted) {
      navigateWithScale(
          ProjectPolygonMapMobile(
            project: proj!,
          ),
          context);
    }
  }

  onGeofenceEventTapped(String p1) {
    var bb = GeofenceEvent.fromJson(jsonDecode(p1));
    var mp = OldToRealm.getGeofenceEvent(bb);

    navigateWithScale(
        GeofenceMap(
          geofenceEvent: mp,
        ),
        context);
  }

  onOrgMessage(String p1) {
    if (deviceType == 'phone') {}
  }

  void onProjectTapped(String p1) async {
    if (deviceType == 'phone') {}
    var bb = Project.fromJson(jsonDecode(p1));
    var mp = OldToRealm.getProject(bb);
        if (mounted) {
      navigateWithScale(
          ProjectMediaTimeline(
            projectBloc: widget.projectBloc,
            prefsOGx: widget.prefsOGx,
            project: mp,
            fcmBloc: widget.fcmBloc,
            organizationBloc: widget.organizationBloc,
            cacheManager: widget.cacheManager,
            dataApiDog: widget.dataApiDog,
            geoUploader: widget.geoUploader,
            cloudStorageBloc: widget.cloudStorageBloc,
          ),
          context);
    }
  }

  void _onProjectsAcquired(int projects) async {
    pp('🌀🌀🌀🌀 _onProjectsAcquired; $projects');
    setState(() {
      totalProjects = projects;
    });
  }

  void _onEventsAcquired(int events) async {
    pp('🌀🌀🌀🌀 _onEventsAcquired; $events');
    setState(() {
      totalEvents = events;
    });
  }

  void _onUsersAcquired(int users) async {
    pp('🌀🌀🌀🌀 _onUsersAcquired; $users');
    setState(() {
      totalUsers = users;
    });
  }

  bool isPlaying = false;
  bool isPaused = false;
  bool isStopped = true;
  bool isBuffering = false;
  bool isLoading = false;

  bool playAudio = false;
  bool playVideo = false;
  bool showAudio = false;
  bool showPhoto = false;

  @override
  Widget build(BuildContext context) {
    var sigmaX = 12.0;
    var sigmaY = 12.0;

    var width = MediaQuery.of(context).size.width;
    final deviceType = getThisDeviceType();
    if (deviceType != 'phone') {}
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    var color = getTextColorForBackground(Theme.of(context).primaryColor);

    if (isDarkMode) {
      color = Theme.of(context).primaryColor;
    }
    return Scaffold(
        backgroundColor:
            isDarkMode ? Theme.of(context).canvasColor : Colors.brown[50],
        body: Stack(
          children: [
            ScreenTypeLayout.builder(
              mobile: (ctx) {
                return user == null
                    ? const SizedBox()
                    : RealDashboard(
                        projects: projects,
                        users: users,
                        locale: settings.locale!,
                        totalEvents: totalEvents,
                        totalProjects: totalProjects,
                        totalUsers: totalUsers,
                        sigmaX: sigmaX,
                        sigmaY: sigmaY,
                        user: user!,
                        startDate: startDate,
                        organizationId: user!.organizationId!,
                        width: width,
                        forceRefresh: forceRefresh,
                        membersText: membersText!,
                        projectsText: projectsText!,
                        eventsText: eventsText!,
                        dashboardText: dashboardText!,
                        recentEventsText: recentEventsText!,
                        cacheManager: widget.cacheManager,
                        prefsOGx: widget.prefsOGx,
                        dataApiDog: widget.dataApiDog,
                        geoUploader: widget.geoUploader,
                        cloudStorageBloc: widget.cloudStorageBloc,
                        projectBloc: widget.projectBloc,
                        onEventTapped: (event) {
                          _onEventTapped(event);
                        },
                        onProjectSubtitleTapped: () {
                          _onProjectSubtitleTapped();
                        },
                        onProjectsAcquired: (projects) {
                          _onProjectsAcquired(projects);
                        },
                        onProjectTapped: (project) {
                          var s = OldToRealm.getProjectString(project);
                          onProjectTapped(s);
                        },
                        onUserSubtitleTapped: () {
                          _onUserSubtitleTapped();
                        },
                        onUsersAcquired: (users) {
                          _onUsersAcquired(users);
                        },
                        onUserTapped: (user) {
                          onUserTapped(OldToRealm.getUserString(user));
                        },
                        onEventsSubtitleTapped: () {
                          _onEventsSubtitleTapped();
                        },
                        onEventsAcquired: (events) {
                          _onEventsAcquired(events);
                        },
                        onRefreshRequested: () {
                          _onRefreshRequested();
                        },
                        onSearchTapped: () {
                          _onSearchTapped();
                        },
                        onSettingsRequested: () {
                          _onSettingsRequested();
                        },
                        onDeviceUserTapped: () {
                          _onDeviceUserTapped();
                        },
                        centerTopCards: true,
                        navigateToIntro: () {
                          navigateToIntro();
                        },
                        navigateToActivities: () {
                          _navigateToActivities();
                        },
                        organizationBloc: widget.organizationBloc,
                        fcmBloc: widget.fcmBloc,
                        onGioSubscriptionRequired: navigateToSubscription,
                        realmSyncApi: widget.realmSyncApi,
                      );
              },
              tablet: (ctx) {
                return Stack(
                  children: [
                    OrientationLayoutBuilder(
                      portrait: (context) {
                        return user == null
                            ? const SizedBox()
                            : RealDashboard(
                                topCardSpacing: 16.0,
                                centerTopCards: true,
                                projects: projects,
                                users: users,
                                organizationId: user!.organizationId!,
                                fcmBloc: widget.fcmBloc,
                                navigateToActivities: () {
                                  _navigateToActivities();
                                },
                                cacheManager: widget.cacheManager,
                                prefsOGx: widget.prefsOGx,
                                dataApiDog: widget.dataApiDog,
                                organizationBloc: widget.organizationBloc,
                                geoUploader: widget.geoUploader,
                                cloudStorageBloc: widget.cloudStorageBloc,
                                projectBloc: widget.projectBloc,
                                realmSyncApi: widget.realmSyncApi,
                                locale: settings.locale!,
                                forceRefresh: forceRefresh,
                                totalEvents: totalEvents,
                                totalProjects: totalProjects,
                                totalUsers: totalUsers,
                                sigmaX: sigmaX,
                                sigmaY: sigmaY,
                                startDate: startDate,
                                user: user!,
                                width: width,
                                membersText: membersText!,
                                projectsText: projectsText!,
                                eventsText: eventsText!,
                                dashboardText: dashboardText!,
                                recentEventsText: recentEventsText!,
                                onGioSubscriptionRequired:
                                    navigateToSubscription,
                                onEventTapped: (event) {
                                  _onEventTapped(event);
                                },
                                onProjectSubtitleTapped: () {
                                  _onProjectSubtitleTapped();
                                },
                                onProjectsAcquired: (projects) {
                                  _onProjectsAcquired(projects);
                                },
                                onProjectTapped: (project) {
                                  var s = OldToRealm.getProjectString(project);
                                  onProjectTapped(s);
                                },
                                onUserSubtitleTapped: () {
                                  _onUserSubtitleTapped();
                                },
                                onUsersAcquired: (users) {
                                  _onUsersAcquired(users);
                                },
                                onUserTapped: (user) {
                                  onUserTapped(OldToRealm.getUserString(user));
                                },
                                onEventsSubtitleTapped: () {
                                  _onEventsSubtitleTapped();
                                },
                                onEventsAcquired: (events) {
                                  _onEventsAcquired(events);
                                },
                                onRefreshRequested: () {
                                  _onRefreshRequested();
                                },
                                onSearchTapped: () {
                                  _onSearchTapped();
                                },
                                onSettingsRequested: () {
                                  _onSettingsRequested();
                                },
                                onDeviceUserTapped: () {
                                  _onDeviceUserTapped();
                                },
                                navigateToIntro: () {
                                  navigateToIntro();
                                },
                              );
                      },
                      landscape: (context) {
                        return user == null
                            ? const SizedBox()
                            : RealDashboard(
                                topCardSpacing: 16,
                                forceRefresh: forceRefresh,
                                projects: projects,
                                users: users,
                                organizationId: user!.organizationId!,
                                fcmBloc: widget.fcmBloc,
                                navigateToActivities: () {
                                  _navigateToActivities();
                                },
                                cacheManager: widget.cacheManager,
                                prefsOGx: widget.prefsOGx,
                                dataApiDog: widget.dataApiDog,
                                organizationBloc: widget.organizationBloc,
                                geoUploader: widget.geoUploader,
                                cloudStorageBloc: widget.cloudStorageBloc,
                                projectBloc: widget.projectBloc,
                                realmSyncApi: widget.realmSyncApi,
                                totalEvents: totalEvents,
                                totalProjects: totalProjects,
                                totalUsers: totalUsers,
                                sigmaX: sigmaX,
                                sigmaY: sigmaY,
                                membersText: membersText!,
                                projectsText: projectsText!,
                                eventsText: eventsText!,
                                dashboardText: dashboardText!,
                                recentEventsText: recentEventsText!,
                                user: user!,
                                startDate: startDate,
                                width: width,
                                navigateToIntro: () {
                                  navigateToIntro();
                                },
                                onEventTapped: (event) {
                                  _onEventTapped(event);
                                },
                                onProjectSubtitleTapped: () {
                                  _onProjectSubtitleTapped();
                                },
                                onProjectsAcquired: (projects) {
                                  _onProjectsAcquired(projects);
                                },
                                onProjectTapped: (project) {
                                  var s = OldToRealm.getProjectString(project);

                                  onProjectTapped(s);
                                },
                                onUserSubtitleTapped: () {
                                  _onUserSubtitleTapped();
                                },
                                onUsersAcquired: (users) {
                                  _onUsersAcquired(users);
                                },
                                onUserTapped: (user) {
                                  onUserTapped(OldToRealm.getUserString(user));
                                },
                                onEventsSubtitleTapped: () {
                                  _onEventsSubtitleTapped();
                                },
                                onEventsAcquired: (events) {
                                  _onEventsAcquired(events);
                                },
                                onRefreshRequested: () {
                                  _onRefreshRequested();
                                },
                                onSearchTapped: () {
                                  _onSearchTapped();
                                },
                                onSettingsRequested: () {
                                  _onSettingsRequested();
                                },
                                onDeviceUserTapped: () {
                                  _onDeviceUserTapped();
                                },
                                centerTopCards: true,
                                locale: settings.locale!,
                                onGioSubscriptionRequired:
                                    navigateToSubscription,
                              );
                      },
                    ),
                    playAudio
                        ? Positioned(
                            child: GioAudioPlayer(
                            cacheManager: widget.cacheManager,
                            prefsOGx: widget.prefsOGx,
                            audio: audio!,
                            onCloseRequested: () {},
                            dataApiDog: widget.dataApiDog,
                          ))
                        : const SizedBox()
                  ],
                );
              },
            ),
            busy
                ? Positioned(child: LoadingCard(loadingData: loadingDataText!))
                : const SizedBox(),
            showAudio
                ? Positioned(
                    left: 160,
                    right: 160,
                    top: 120,
                    child: SizedBox(
                      width: 440,
                      child: GioAudioPlayer(
                          cacheManager: widget.cacheManager,
                          prefsOGx: widget.prefsOGx,
                          audio: audio!,
                          onCloseRequested: () {
                            setState(() {
                              showAudio = false;
                            });
                          },
                          dataApiDog: dataApiDog),
                    ))
                : const SizedBox(),
            showPhoto
                ? Positioned(
                    left: 100,
                    right: 100,
                    top: 48,
                    child: SizedBox(
                      width: 600,
                      child: PhotoCard(
                        photo: photo!,
                        onMapRequested: (photo) {},
                        onRatingRequested: (photo) {},
                        elevation: 8.0,
                        onPhotoCardClose: () {
                          setState(() {
                            showPhoto = false;
                          });
                        },
                        translatedDate: '',
                      ),
                    ))
                : const SizedBox(),
            playVideo
                ? Positioned(
                    left: 100,
                    right: 100,
                    top: 48,
                    child: SizedBox(
                      width: 600,
                      child: GioVideoPlayer(
                        video: video!,
                        onCloseRequested: () {
                          setState(() {
                            playVideo = false;
                          });
                        },
                        width: 600,
                        dataApiDog: widget.dataApiDog,
                      ),
                    ))
                : const SizedBox(),
          ],
        ));
  }
}

class SubTitleWidget extends StatelessWidget {
  const SubTitleWidget(
      {Key? key,
      required this.title,
      required this.onTapped,
      required this.number,
      required this.color})
      : super(key: key);

  final String title;
  final Function onTapped;
  final int number;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapped();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: myTextStyleSubtitle(context),
          ),
          const SizedBox(
            width: 2,
          ),
          // MyBadge(number: number),
          SizedBox(
            width: 1,
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: color,
                  size: 20,
                )),
          ),
          const SizedBox(
            width: 36,
          ),
          Text(
            '$number',
            style: myTextStyleMediumLargeWithOpacity(context, 0.25),
          )
        ],
      ),
    );
  }
}

class PhoneVideoPlayer extends StatelessWidget {
  const PhoneVideoPlayer(
      {Key? key,
      required this.video,
      required this.onCloseRequested,
      required this.dataApiDog,
      this.width,
      required this.title})
      : super(key: key);

  final mrm.Video video;
  final Function onCloseRequested;
  final DataApiDog dataApiDog;
  final double? width;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: myTextStyleMediumLarge(context),
          ),
        ),
        body: GioVideoPlayer(
          video: video,
          onCloseRequested: () {
            onCloseRequested();
          },
          width: width == null ? 600 : width!,
          dataApiDog: dataApiDog,
        ),
      ),
    );
  }
}
