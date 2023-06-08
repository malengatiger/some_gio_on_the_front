import 'dart:async';
import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geo_monitor/dashboard_khaya/project_list.dart';
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

class TopCardList extends StatefulWidget {
  const TopCardList(
      {Key? key,
      required this.organizationBloc,
      required this.fcmBloc,
      required this.prefsOGx,
      required this.projectBloc,
      required this.dataApiDog,
      required this.cacheManager,
      required this.geoUploader,
      required this.cloudStorageBloc,
      required this.realmSyncApi})
      : super(key: key);

  final OrganizationBloc organizationBloc;
  final FCMBloc fcmBloc;
  final PrefsOGx prefsOGx;
  final ProjectBloc projectBloc;
  final DataApiDog dataApiDog;
  final CacheManager cacheManager;
  final GeoUploader geoUploader;
  final CloudStorageBloc cloudStorageBloc;
  final RealmSyncApi realmSyncApi;

  @override
  State<TopCardList> createState() => TopCardListState();
}

class TopCardListState extends State<TopCardList> {
  final mm = '🛎🛎🛎🛎TopCardList: 🐸';
  // late StreamSubscription<DataBag> bagSub;
  // late StreamSubscription<SettingsModel> settingsSub;
  // late StreamSubscription<ActivityModel> actSub;
  // late StreamSubscription<bool> refreshSub;

  bool busy = false;

  // DataBag? dataBag;
  var eventsText = 'Events',
      projectsText = 'Projects',
      membersText = 'Members',
      photosText = 'Photos',
      videosText = 'Videos',
      audiosText = 'Audios',
      locationsText = 'Locations',
      areasText = 'Areas';
  var topCardSpacing = 24.0;

  var events = 0,
      projects = 0,
      members = 0,
      photos = 0,
      videos = 0,
      audios = 0,
      locations = 0,
      geofenceEvents = 0,
      areas = 0;

  @override
  void initState() {
    super.initState();
    _setTexts();
    _getData();
  }

  int cnt = 0;

  Future _getData() async {
    pp('$mm _getData: 🔵🔵 set up realmSyncApi stream listeners ... ............');
    try {
      setState(() {
        busy = true;
      });

      widget.realmSyncApi.projectStream.listen((event) {
        pp('$mm projectStream delivered ${event.length}');
        setState(() {
          projects = event.length;
        });
      });

      widget.realmSyncApi.activityStream.listen((event) {
        pp('$mm activityStream delivered ${event.length}');
        setState(() {
          events = event.length;
        });
      });

      widget.realmSyncApi.userStream.listen((event) {
        pp('$mm userStream delivered ${event.length}');
        setState(() {
          projects = event.length;
        });
      });

      widget.realmSyncApi.organizationPhotoStream.listen((event) {
        pp('$mm organizationPhotoStream delivered ${event.length}');
        setState(() {
          photos = event.length;
        });
      });
      widget.realmSyncApi.organizationVideoStream.listen((event) {
        pp('$mm organizationVideoStream delivered ${event.length}');
        setState(() {
          videos = event.length;
        });
      });
      widget.realmSyncApi.organizationAudioStream.listen((event) {
        pp('$mm organizationAudioStream delivered ${event.length}');
        setState(() {
          audios = event.length;
        });
      });
      widget.realmSyncApi.organizationPositionStream.listen((event) {
        pp('$mm organizationPositionStream delivered ${event.length}');
        setState(() {
          locations = event.length;
        });
      });
      widget.realmSyncApi.organizationPolygonStream.listen((event) {
        pp('$mm organizationPolygonStream delivered ${event.length}');
        setState(() {
          areas = event.length;
        });
      });
      widget.realmSyncApi.organizationGeofenceStream.listen((event) {
        pp('$mm organizationGeofenceStream delivered ${event.length}');
        setState(() {
          geofenceEvents = event.length;
        });
      });

    } catch (e) {
      pp(e);
    }

    if (mounted) {
      pp('$mm _getData ; setting state ..');
      setState(() {
        busy = false;
      });
    }
  }

  late SettingsModel settings;

  Future _setTexts() async {
    settings = await prefsOGx.getSettings();
    photosText = await translator.translate('photos', settings.locale!);
    videosText = await translator.translate('videos', settings.locale!);
    audiosText = await translator.translate('audioClips', settings.locale!);
    locationsText = await translator.translate('locations', settings.locale!);
    areasText = await translator.translate('areas', settings.locale!);
    projectsText = await translator.translate('projects', settings.locale!);
    membersText = await translator.translate('members', settings.locale!);
    eventsText = await translator.translate('events', settings.locale!);

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {;
    super.dispose();
  }

  void _navigateToProjects() {
    pp(' 🌀🌀🌀🌀 .................. _navigateToProjects  ....');
    if (mounted) {
      navigateWithScale(
          GioProjects(
            projectBloc: widget.projectBloc,
            organizationBloc: widget.organizationBloc,
            prefsOGx: widget.prefsOGx,
            dataApiDog: widget.dataApiDog,
            cacheManager: widget.cacheManager,
            instruction: 0,
            realmSyncApi: widget.realmSyncApi,
            fcmBloc: widget.fcmBloc,
            geoUploader: widget.geoUploader,
            cloudStorageBloc: widget.cloudStorageBloc,
          ),
          context);
    }
  }

  void _navigateToMembers() {
    pp(' 🌀🌀🌀🌀 .................. _navigateToMembers  ....');
    if (mounted) {
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
  }

  void _navigateToMap() {
    pp(' 🌀🌀🌀🌀 .................. _navigateToMap ....');
    if (mounted) {
      navigateWithScale(
          OrganizationMap(
            organizationBloc: widget.organizationBloc,
            prefsOGx: widget.prefsOGx,
          ),
          context);
    }
  }

  void _navigateToTimeline() {
    pp(' 🌀🌀🌀🌀 .................. _navigateToTimeline  ....');
    if (mounted) {
      navigateWithScale(
          ProjectMediaTimeline(
              projectBloc: widget.projectBloc,
              prefsOGx: widget.prefsOGx,
              organizationBloc: widget.organizationBloc,
              cacheManager: widget.cacheManager,
              dataApiDog: widget.dataApiDog,
              geoUploader: widget.geoUploader,
              cloudStorageBloc: widget.cloudStorageBloc,
              fcmBloc: widget.fcmBloc),
          context);
    }
  }

  void _navigateToActivities() async {
    pp(' 🌀🌀🌀🌀 .................. _navigateToActivities  ....');
    final deviceScreenType = getThisDeviceType();
    if (mounted) {
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
              pp('$mm navigateWithScale ... onPhotoTapped');
              if ((deviceScreenType == 'phone')) {
                navigateWithScale(
                    PhotoFrame(
                        photo: p,
                        onMapRequested: (p) {},
                        onRatingRequested: (p) {},
                        elevation: 0,
                        onPhotoCardClose: (p) {},
                        translatedDate: 'translatedDate',
                        locale: settings.locale!,
                        cacheManager: cacheManager,
                        dataApiDog: dataApiDog,
                        prefsOGx: prefsOGx,
                        fcmBloc: fcmBloc,
                        projectBloc: projectBloc,
                        organizationBloc: organizationBloc,
                        geoUploader: geoUploader,
                        cloudStorageBloc: cloudStorageBloc),
                    context);
              }
            },
            onVideoTapped: (p) {
              pp('$mm navigateWithScale ... onVideoTapped');
            },
            onAudioTapped: (p) {
              pp('$mm navigateWithScale ... onAudioTapped');
            },
            onRefreshRequested: () {},
            onUserTapped: (p) {},
            onProjectTapped: (p) {},
            onProjectPositionTapped: (p) {},
            onPolygonTapped: (p) {},
            onGeofenceEventTapped: (p) {},
            onOrgMessage: (p) {},
            onLocationResponse: (p) {},
            onLocationRequest: (p) {},
            prefsOGx: widget.prefsOGx,
            cacheManager: widget.cacheManager,
          ),
          context);
    }
  }


  @override
  Widget build(BuildContext context) {
    final type = getThisDeviceType();
    var padding1 = 16.0;
    var padding2 = 48.0;
    if (type == 'phone') {
      padding1 = 8;
      padding2 = 24;
    }
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    if (!isDarkMode) {}
    return Stack(children: [
      SizedBox(
        height: 144,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: busy
              ? const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 4,
                      backgroundColor: Colors.greenAccent,
                    ),
                  ),
                )
              : ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    DashboardTopCard(
                        width: events > 999 ? 140 : 128,
                        number: events,
                        title: eventsText,
                        onTapped: () {
                          _onTapped(0);
                        }),
                    SizedBox(
                      width: padding1,
                    ),
                    DashboardTopCard(
                        width: projects > 999 ? 140 : 128,
                        number: projects,
                        title: projectsText,
                        onTapped: () {
                          _onTapped(1);
                        }),
                    SizedBox(
                      width: padding1,
                    ),
                    DashboardTopCard(
                        width: members > 999 ? 140 : 128,
                        number: members,
                        title: membersText,
                        onTapped: () {
                          _onTapped(2);
                        }),
                    SizedBox(
                      width: padding2,
                    ),
                    DashboardTopCard(
                        width: photos > 999 ? 140 : 128,
                        textStyle:
                            myNumberStyleLargerPrimaryColorLight(context),
                        number: photos,
                        title: photosText,
                        onTapped: () {
                          _onTapped(3);
                        }),
                    SizedBox(
                      width: padding1,
                    ),
                    DashboardTopCard(
                        textStyle:
                            myNumberStyleLargerPrimaryColorLight(context),
                        width: videos > 999 ? 140 : 128,
                        number: videos,
                        title: videosText,
                        onTapped: () {
                          _onTapped(4);
                        }),
                    SizedBox(
                      width: padding1,
                    ),
                    DashboardTopCard(
                        width: audios > 999 ? 140 : 128,
                        textStyle:
                            myNumberStyleLargerPrimaryColorLight(context),
                        number: audios,
                        title: audiosText,
                        onTapped: () {
                          _onTapped(5);
                        }),
                    SizedBox(
                      width: padding2,
                    ),
                    DashboardTopCard(
                        textStyle: myNumberStyleLargerPrimaryColorDark(context),
                        width: locations > 999 ? 140 : 128,
                        number: locations,
                        title: locationsText,
                        onTapped: () {
                          _onTapped(6);
                        }),
                    SizedBox(
                      width: padding1,
                    ),
                    DashboardTopCard(
                        textStyle: myNumberStyleLargerPrimaryColorDark(context),
                        width: areas > 999 ? 140 : 128,
                        number: areas,
                        title: areasText,
                        onTapped: () {
                          _onTapped(7);
                        }),
                    SizedBox(
                      width: padding1,
                    ),
                    DashboardTopCard(
                        textStyle: myNumberStyleLargerPrimaryColor(context),
                        width: geofenceEvents > 999 ? 140 : 128,
                        number: geofenceEvents,
                        title: 'Geofence Events',
                        onTapped: () {
                          _onTapped(7);
                        }),
                  ],
                ),
        ),
      ),

    ]);
  }

  void _onTapped(int id) {
    pp('$mm top card tapped: id: $id ............');
    switch (id) {
      case 0:
        _navigateToActivities();
        break;
      case 1:
        _navigateToProjects();
        break;
      case 2:
        _navigateToMembers();
        break;
      case 3:
        _navigateToTimeline();
        break;
      case 4:
        _navigateToTimeline();
        break;
      case 5:
        _navigateToTimeline();
        break;
      case 6:
        _navigateToMap();
        break;
      case 7:
        _navigateToMap();
        break;
    }
  }
}

class DashboardTopCard extends StatelessWidget {
  const DashboardTopCard(
      {Key? key,
      required this.number,
      required this.title,
      this.height,
      this.topPadding,
      this.textStyle,
      this.labelTitleStyle,
      required this.onTapped,
      this.width})
      : super(key: key);
  final int number;
  final String title;
  final double? height, topPadding, width;
  final TextStyle? textStyle, labelTitleStyle;
  final Function() onTapped;

  @override
  Widget build(BuildContext context) {
    // pp('primary color ${Theme.of(context).primaryColor} canvas color ${Theme.of(context).canvasColor}');

    Color color = Theme.of(context).primaryColor;
    if (Theme.of(context).canvasColor.value == const Color(0xff121212).value) {
      color = Theme.of(context).primaryColor;
    } else {
      color = Theme.of(context).canvasColor;
    }
    // var style = GoogleFonts.roboto(
    //     textStyle: Theme.of(context).textTheme.titleLarge,
    //     fontSize: 40,
    //     color: color,
    //     fontWeight: FontWeight.w900);

    var style2 = GoogleFonts.roboto(
        textStyle: Theme.of(context).textTheme.bodyMedium,
        fontSize: 12,
        color: color,
        fontWeight: FontWeight.normal);
    final fmt = NumberFormat.decimalPattern();
    final mNumber = fmt.format(number);
    var color2 = Colors.white;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    if (!isDarkMode) {
      color2 = Colors.black;
    }

    return GestureDetector(
      onTap: () {
        onTapped();
      },
      child: Card(
        shape: getRoundedBorder(radius: 16),
        elevation: 4,
        child: SizedBox(
          height: height == null ? 104 : height!,
          width: width == null ? 128 : width!,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: topPadding == null ? 8 : topPadding!,
                ),
                Text(mNumber,
                    style: textStyle == null
                        ? myNumberStyleLargerPrimaryColor(context)
                        : textStyle!),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  title,
                  style: myTextStyleSmallWithColor(context, color2),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

