import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geo_monitor/library/api/prefs_og.dart';
import 'package:geo_monitor/library/bloc/fcm_bloc.dart';
import 'package:geo_monitor/library/bloc/organization_bloc.dart';
import 'package:geo_monitor/library/bloc/refresh_bloc.dart';
import 'package:geo_monitor/library/data/activity_model.dart';
import 'package:geo_monitor/library/data/activity_type_enum.dart';
import 'package:geo_monitor/library/data/settings_model.dart';
import 'package:geo_monitor/realm_data/data/realm_sync_api.dart';
import 'package:realm/realm.dart';

import '../library/data/data_bag.dart';
import '../library/emojis.dart';
import '../library/functions.dart';
import 'package:geo_monitor/realm_data/data/schemas.dart' as mrm;

class RecentEventList extends StatefulWidget {
  final Function(mrm.ActivityModel) onEventTapped;
  final String locale;
  final OrganizationBloc organizationBloc;
  final PrefsOGx prefsOGx;
  final FCMBloc fcmBloc;
  final RealmSyncApi realmSyncApi;

  const RecentEventList(
      {super.key,
      required this.onEventTapped,
      required this.locale,
      required this.organizationBloc,
      required this.prefsOGx,
      required this.fcmBloc,
      required this.realmSyncApi});

  @override
  State<RecentEventList> createState() => _RecentEventListState();
}

class _RecentEventListState extends State<RecentEventList> {
  var activities = <mrm.ActivityModel>[];
  bool busy = false;
  final mm = '🔵🔵🔵 RecentEventList 🔵🔵🔵🔵🔵🔵 : ';

  @override
  void initState() {
    super.initState();
    pp('$mm initState ..............');
    _getData();
  }

  Future _getData() async {
    setState(() {
      busy = true;
    });
    try {
      pp('$mm ........ getting activity data .....');
      final sett = await widget.prefsOGx.getSettings();
      var dates = getStartEndDatesFromDays(numberOfDays: sett.numberOfDays!);
      var actQuery = widget.realmSyncApi
          .getOrganizationActivitiesQuery(sett.organizationId!, dates.$1);
      actQuery.changes.listen((event) {
        pp('$mm ........ getting activity stream fired! ..... ${E.appleRed} '
            '${event.results.length} documents delivered');
        activities.clear();
        for (var act in event.results) {
          activities.add(act);
        }
        setState(() {});
      });
    } catch (e) {
      showSnackBar(message: '$e', context: context);
    }
    if (mounted) {
      setState(() {
        busy = false;
      });
    }
  }

  @override
  void dispose() {
    // actSub.cancel();
    // bagSub.cancel();
    // refreshSub.cancel();
    // settingsSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = 340.0;
    final deviceType = getThisDeviceType();
    if (deviceType == 'phone') {
      width = 332.0;
    }
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {}
        return SizedBox(
          height: 64,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: activities.length,
              itemBuilder: (_, index) {
                final act = activities.elementAt(index);
                return GestureDetector(
                    onTap: () {
                      widget.onEventTapped(act);
                    },
                    child: EventView(
                      activity: act,
                      height: 84,
                      width: width,
                      locale: widget.locale,
                    ));
              }),
        );
      },
    );
  }
}

class EventView extends StatelessWidget {
  const EventView(
      {Key? key,
      required this.activity,
      required this.height,
      required this.width,
      required this.locale})
      : super(key: key);
  final mrm.ActivityModel activity;
  final double height, width;
  final String locale;

  @override
  Widget build(BuildContext context) {
    String? userUrl;
    Icon icon = const Icon(Icons.access_time);
    if (activity.photo != null) {
      icon = const Icon(
        Icons.camera_alt_outlined,
        color: Colors.teal,
      );
      var json = jsonDecode(activity.photo!);
      userUrl = json['userUrl'];
    }
    if (activity.audio != null) {
      icon = const Icon(
        Icons.mic,
        color: Colors.deepOrange,
      );
      var json = jsonDecode(activity.audio!);
      userUrl = json['userUrl'];
    }
    if (activity.video != null) {
      icon = const Icon(Icons.video_camera_back_outlined);
      var json = jsonDecode(activity.video!);
      userUrl = json['userUrl'];
    }
    if (activity.geofenceEvent != null) {
      icon = const Icon(
        Icons.person,
        color: Colors.blue,
      );
      var json = jsonDecode(activity.geofenceEvent!);
      userUrl = json['userUrl'];
    }
    if (activity.project != null) {
      icon = const Icon(
        Icons.home,
        color: Colors.deepPurple,
      );
      var json = jsonDecode(activity.project!);
      userUrl = json['userUrl'];
    }
    if (activity.projectPosition != null) {
      icon = const Icon(
        Icons.location_on_sharp,
        color: Colors.green,
      );
      var json = jsonDecode(activity.projectPosition!);
      userUrl = json['userUrl'];
    }
    if (activity.projectPolygon != null) {
      icon = const Icon(
        Icons.location_on_rounded,
        color: Colors.yellow,
      );
      var json = jsonDecode(activity.projectPolygon!);
      userUrl = json['userUrl'];
    }
    if (activity.activityType == 'settingsChanged') {
      icon = const Icon(
        Icons.settings,
        color: Colors.pink,
      );
      userUrl = activity.userThumbnailUrl;
    }

    final date = getFmtDate(activity.date!, locale);

    return SizedBox(
        width: width,
        height: 100,
        child: Card(
          shape: getRoundedBorder(radius: 12),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  const SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    height: 48,
                    child: Column(
                      children: [
                        activity.projectName == null
                            ? const SizedBox()
                            : Flexible(
                                child: Text(
                                  activity.projectName!,
                                  style: myTextStyleSmallPrimaryColor(context),
                                ),
                              ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          date,
                          style: myTextStyleTiny(context),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  userUrl == null
                      ? const SizedBox()
                      : CircleAvatar(
                          backgroundImage: NetworkImage(userUrl),
                          radius: 14,
                        )
                ],
              ),
            ),
          ),
        ));
  }
}

class RecentActivitiesHorizontal extends StatefulWidget {
  const RecentActivitiesHorizontal(
      {Key? key,
      required this.realmSyncApi,
      required this.organizationId,
      this.projectId,
      this.userId,
      required this.onEventTapped,
      required this.startDate, required this.locale})
      : super(key: key);

  final RealmSyncApi realmSyncApi;
  final String organizationId, startDate, locale;
  final String? projectId, userId;
  final Function(mrm.ActivityModel) onEventTapped;

  @override
  State<RecentActivitiesHorizontal> createState() => _RecentActivitiesHorizontalState();
}

class _RecentActivitiesHorizontalState extends State<RecentActivitiesHorizontal> {

  bool busy = false;
  @override
  void initState() {
    super.initState();
    _subscribe();

  }
  void _subscribe() {
    setState(() {
      busy = true;
    });
    widget.realmSyncApi.setSubscriptions(
        organizationId: widget.organizationId,
        countryId: null,
        projectId: widget.projectId,
        startDate: widget.startDate);
    setState(() {
      busy = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _subscribe();
    var width = 340.0;
    final deviceType = getThisDeviceType();
    if (deviceType == 'phone') {
      width = 332.0;
    }
    if (busy) {
      return const Center(
        child: SizedBox(width: 28, height: 28,
          child: CircularProgressIndicator(
            strokeWidth: 6, backgroundColor: Colors.pink,
          ),
        ),
      );
    }
    return StreamBuilder<List<mrm.ActivityModel>>(
      stream: widget.realmSyncApi.activityStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        var activities = <mrm.ActivityModel>[];
        if (snapshot.hasData) {
          activities = snapshot.data!;
        }
        return SizedBox(
          height: 64,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: activities.length,
              itemBuilder: (_, index) {
                final act = activities.elementAt(index);
                return GestureDetector(
                    onTap: () {
                      widget.onEventTapped(act);
                    },
                    child: EventView(
                      activity: act,
                      height: 84,
                      width: width,
                      locale: widget.locale,
                    ));
              }),
        );
      },
    );
  }
}
