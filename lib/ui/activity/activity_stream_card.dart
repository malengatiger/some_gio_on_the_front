import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geo_monitor/library/data/settings_model.dart';
import 'package:geo_monitor/library/functions.dart';
import 'package:geo_monitor/ui/activity/user_profile_card.dart';

import '../../l10n/translation_handler.dart';
import '../../library/api/prefs_og.dart';
import '../../library/data/activity_type_enum.dart';
import '../../library/data/geofence_event.dart';
import '../../library/data/location_request.dart';
import '../../library/data/location_response.dart';
import 'activity_cards.dart';
import 'package:geo_monitor/realm_data/data/schemas.dart' as mrm;

/// This widget manages the display of an ActivityModel
/// and handles the text translation of needed strings
class ActivityStreamCard extends StatefulWidget {
  const ActivityStreamCard(
      {Key? key,
      required this.activityModel,
      required this.frontPadding,
      required this.thinMode,
      required this.width,
      required this.activityStrings,
      required this.translatedUserType, required this.avatarRadius, required this.namePictureHorizontal, required this.users})
      : super(key: key);

  final mrm.ActivityModel activityModel;
  final double frontPadding;
  final bool thinMode;
  final double width;
  final ActivityStrings activityStrings;
  // final String locale;
  final String translatedUserType;
  final double avatarRadius;
  final bool namePictureHorizontal;
  final List<mrm.User> users;

  @override
  ActivityStreamCardState createState() => ActivityStreamCardState();
}

class ActivityStreamCardState extends State<ActivityStreamCard> {
  int count = 0;

  static const mm = '🌿🌿🌿🌿🌿🌿 ActivityStreamCard: 🌿 ';
  late String locale;
  bool busy = false;
  late SettingsModel settings;
  @override
  void initState() {
    super.initState();
    _getLocaleAndUser();
  }

  mrm.User? activityUser;
  String? translatedUserType;

  void _getLocaleAndUser() async {
    setState(() {
      busy = true;
    });
    settings = await prefsOGx.getSettings();
    locale = settings.locale!;
    if (widget.activityModel.userId != null) {
      for (var user in widget.users) {
        if (user.userId == widget.activityModel.userId) {
          activityUser = user;
        }
      }
    }

    setState(() {
      busy = false;
    });
  }

  Widget _getUserAdded(Icon icon, String msg) {
    final dt = getFmtDate(widget.activityModel.date!, locale);
    final ori = MediaQuery.of(context).orientation;
    var width = 128.0;
    if (ori.name == 'landscape') {
      width = 200;
    }
    return activityUser == null
        ? const SizedBox()
        : Card(
            shape: getRoundedBorder(radius: 16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        dt,
                        style: myTextStyleSmallPrimaryColor(context),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  activityUser!.thumbnailUrl == null
                      ? const CircleAvatar(
                          radius: 16,
                        )
                      : Row(mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          UserProfileCard(
                              userName: widget.activityModel.userName!,
                              padding: 0,
                              elevation: 2,
                              avatarRadius: widget.avatarRadius,
                              userThumbUrl: widget.activityModel.userThumbnailUrl,
                              namePictureHorizontal: widget.namePictureHorizontal),
                        ],
                      ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    msg,
                    style: myTextStyleSmallBoldPrimaryColor(context),
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                ],
              ),
            ),
          );
  }

  Widget _getGeneric(Icon icon, String msg, double height) {
    // pp('$mm _getGeneric, msg: $msg');
    return activityUser == null
        ? const SizedBox()
        : ThinCard(
            model: widget.activityModel,
            locale: locale!,
            width: 428,
            avatarRadius: 14.0,
            height: height,
            userType: translatedUserType == null
                ? activityUser!.userType!
                : translatedUserType!,
            icon: icon,
            message: msg,
            namePictureHorizontal: true,
          );
  }

  Widget _getShortie(Icon icon, String msg) {
    final dt = getFmtDate(widget.activityModel.date!, locale!);
    // pp('$mm _getShortie, msg: $msg');
    return Card(
      shape: getRoundedBorder(radius: 16),
      elevation: 4,
      child: SizedBox(
        height: 80,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  icon,
                  const SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    child: Text(
                      msg,
                      style: myTextStyleSmall(context),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dt,
                    style: myTextStyleTinyPrimaryColor(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (busy) {
      return const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(),);
    }
    late Icon icon;
    late String message;
    // pp('$mm activityType: ${widget.activityModel.activityType}');
    switch (widget.activityModel.activityType!) {
      case 'projectAdded':
        icon = Icon(Icons.access_time, color: Theme.of(context).primaryColor);
        message = widget.activityStrings.projectAdded == null
            ? '${widget.activityStrings.projectAdded}: ${widget.activityModel.projectName}'
            : '${widget.activityStrings.projectAdded}: ${widget.activityModel.projectName}';
        return _getGeneric(icon, message, 80.0);

      case 'photoAdded':
        icon = Icon(Icons.camera_alt, color: Theme.of(context).primaryColor);
        message = '${widget.activityModel.projectName}';
        return _getGeneric(icon, message, 160.0);

      case 'videoAdded':
        icon = Icon(Icons.video_camera_front,
            color: Theme.of(context).primaryColorLight);
        message = '${widget.activityModel.projectName}';
        return _getGeneric(icon, message, 160.0);

      case 'audioAdded':
        icon = Icon(Icons.mic, color: Theme.of(context).primaryColor);
        message = '${widget.activityModel.projectName}';
        return _getGeneric(icon, message, 160.0);

      case 'messageAdded':
        icon = Icon(Icons.message, color: Theme.of(context).primaryColor);
        message = 'Message added';
        return _getGeneric(icon, message, 100);

      case 'userAddedOrModified':
        icon = Icon(Icons.person, color: Theme.of(context).primaryColor);
        message = '${widget.activityStrings.memberAddedChanged}';
        return _getUserAdded(icon, message);

      case 'positionAdded':
        icon = Icon(Icons.home, color: Theme.of(context).primaryColor);
        message =
            '${widget.activityStrings.projectLocationAdded}: ${widget.activityModel.projectName}';
        return _getGeneric(icon, message, 160);

      case 'polygonAdded':
        icon =
            Icon(Icons.circle_outlined, color: Theme.of(context).primaryColor);
        message =
            '${widget.activityStrings.projectAreaAdded} ${widget.activityModel.projectName}';
        return _getGeneric(icon, message, 160);

      case 'settingsChanged':
        icon = Icon(Icons.settings, color: Theme.of(context).primaryColor);
        message = widget.activityStrings.settingsChanged!;
        return _getShortie(icon, message);

      case 'geofenceEventAdded':
        icon = Icon(Icons.person_2, color: Theme.of(context).primaryColor);
        var bb = GeofenceEvent.fromJson(jsonDecode(widget.activityModel.geofenceEvent!));
        message =
            '${widget.activityStrings.arrivedAt} - ${bb.projectName}';
        return _getUserAdded(icon, message);

      case 'conditionAdded':
        icon = Icon(Icons.access_alarm, color: Theme.of(context).primaryColor);
        message = 'Project Condition added';
        return _getGeneric(icon, message, 120);

      case 'locationRequest':
        icon = Icon(Icons.location_on, color: Theme.of(context).primaryColor);
        var bb = LocationRequest.fromJson(jsonDecode(widget.activityModel.locationRequest!));
        message =
            '${widget.activityStrings.requestMemberLocation} ${bb.userName}';
        return _getGeneric(icon, message, 160);

      case 'locationResponse':
        icon =
            Icon(Icons.location_history, color: Theme.of(context).primaryColor);
        var bb = LocationResponse.fromJson(jsonDecode(widget.activityModel.locationRequest!));

        message =
            '${widget.activityStrings.memberLocationResponse} : ${bb.userName}';
        return _getGeneric(icon, message, 160);

      case 'kill':
        icon = Icon(Icons.cancel, color: Theme.of(context).primaryColor);
        message =
            'User KILL request made, cancel ${widget.activityModel.userName}';
        return _getGeneric(icon, message, 120);

      default:
        return const SizedBox(
          width: 300,
          child: Text('We got a Really Big Problem, Senor!'),
        );
    }
  }
}

class ActivityStrings {
  late String? projectAdded,
      projectLocationAdded,
      projectAreaAdded,
      at,
      loadingActivities,
      memberLocationResponse,
      conditionAdded,
      arrivedAt,
      noActivities,
      memberAtProject,
      memberAddedChanged,
      requestMemberLocation,
      tapToRefresh,
      settingsChanged;

  ActivityStrings(
      {required this.projectAdded,
      required this.projectLocationAdded,
      required this.projectAreaAdded,
      required this.at,
      required this.loadingActivities,
      required this.noActivities,
      required this.tapToRefresh,
      required this.memberLocationResponse,
      required this.conditionAdded,
      required this.arrivedAt,
      required this.memberAtProject,
      required this.memberAddedChanged,
      required this.requestMemberLocation,
      required this.settingsChanged});

  static Future<ActivityStrings?> getTranslated(String locale) async {
    final projectAdded = await translator.translate('projectAdded', locale);
    final projectLocationAdded =
        await translator.translate('projectLocationAdded', locale);
    final projectAreaAdded =
        await translator.translate('projectAreaAdded', locale);
    final memberAtProject =
        await translator.translate('memberAtProject', locale);
    final settingsChanged =
        await translator.translate('settingsChanged', locale);
    final memberAddedChanged =
        await translator.translate('memberAddedChanged', locale);
    final at = await translator.translate('at', locale);
    final arr = await translator.translate('arrivedAt', locale);
    final arrivedAt = arr.replaceAll('\$project', '');
    final conditionAdded =
        await translator.translate('conditionAdded', locale);
    final memberLocationResponse =
        await translator.translate('memberLocationResponse', locale);
    final requestMemberLocation =
        await translator.translate('requestMemberLocation', locale);
    final noActivities = await translator.translate('noActivities', locale);

    final loadingActivities =
        await translator.translate('loadingActivities', locale);

    final tapToRefresh = await translator.translate('tapToRefresh', locale);

    var activityStrings = ActivityStrings(
        tapToRefresh: tapToRefresh,
        projectAdded: projectAdded,
        projectLocationAdded: projectLocationAdded,
        projectAreaAdded: projectAreaAdded,
        at: at,
        loadingActivities: loadingActivities,
        noActivities: noActivities,
        memberLocationResponse: memberLocationResponse,
        conditionAdded: conditionAdded,
        arrivedAt: arrivedAt,
        memberAtProject: memberAtProject,
        memberAddedChanged: memberAddedChanged,
        requestMemberLocation: requestMemberLocation,
        settingsChanged: settingsChanged);

    return activityStrings;
    return null;
  }
}
