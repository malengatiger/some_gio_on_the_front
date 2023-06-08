import 'dart:core';

import 'package:flutter/material.dart';
import 'package:geo_monitor/dashboard_khaya/project_list.dart';
import 'package:geo_monitor/dashboard_khaya/recent_event_list.dart';
import 'package:geo_monitor/dashboard_khaya/top_card_list.dart';
import 'package:geo_monitor/dashboard_khaya/xd_dashboard.dart';
import 'package:geo_monitor/dashboard_khaya/xd_header.dart';
import 'package:geo_monitor/library/api/prefs_og.dart';
import 'package:geo_monitor/library/bloc/organization_bloc.dart';
import 'package:geo_monitor/library/functions.dart';
import 'package:geo_monitor/realm_data/data/realm_sync_api.dart';

import '../library/api/data_api_og.dart';
import '../library/bloc/cloud_storage_bloc.dart';
import '../library/bloc/fcm_bloc.dart';
import '../library/bloc/geo_uploader.dart';
import '../library/bloc/project_bloc.dart';
import '../library/cache_manager.dart';
import 'member_list.dart';
import 'package:geo_monitor/realm_data/data/schemas.dart' as mrm;

class RealDashboard extends StatelessWidget {
  const RealDashboard({
    Key? key,
    required this.totalEvents,
    required this.totalProjects,
    required this.totalUsers,
    required this.sigmaX,
    required this.sigmaY,
    required this.user,
    required this.width,
    required this.onEventTapped,
    required this.onProjectSubtitleTapped,
    required this.onProjectsAcquired,
    required this.onProjectTapped,
    required this.onUserSubtitleTapped,
    required this.onUsersAcquired,
    required this.onUserTapped,
    required this.onEventsSubtitleTapped,
    required this.onEventsAcquired,
    required this.onRefreshRequested,
    required this.onSearchTapped,
    required this.onSettingsRequested,
    required this.onDeviceUserTapped,
    required this.dashboardText,
    required this.eventsText,
    required this.projectsText,
    required this.membersText,
    required this.forceRefresh,
    required this.projects,
    required this.users,
    this.topCardSpacing,
    required this.centerTopCards,
    required this.recentEventsText,
    required this.navigateToIntro,
    required this.locale,
    required this.navigateToActivities,
    required this.organizationBloc,
    required this.fcmBloc,
    required this.cacheManager,
    required this.dataApiDog,
    required this.prefsOGx,
    required this.geoUploader,
    required this.cloudStorageBloc,
    required this.projectBloc,
    required this.onGioSubscriptionRequired, required this.realmSyncApi, required this.organizationId, required this.startDate,
  }) : super(key: key);

  final Function onEventsSubtitleTapped;
  final Function(int) onEventsAcquired;
  final Function(mrm.ActivityModel) onEventTapped;
  final Function onProjectSubtitleTapped;
  final int totalEvents, totalProjects, totalUsers;
  final Function(int) onProjectsAcquired;
  final Function(mrm.Project) onProjectTapped;
  final Function onUserSubtitleTapped;
  final Function(int) onUsersAcquired;
  final Function(mrm.User) onUserTapped;
  final double sigmaX, sigmaY;
  final Function onRefreshRequested,
      onSearchTapped,
      onSettingsRequested,
      onDeviceUserTapped,
      onGioSubscriptionRequired;
  final mrm.User user;
  final double width;
  final String dashboardText,
      eventsText,
      projectsText,
      membersText,
      locale,
      recentEventsText;
  final bool forceRefresh;

  final List<mrm.Project> projects;
  final List<mrm.User> users;
  final double? topCardSpacing;
  final bool centerTopCards;
  final Function navigateToIntro, navigateToActivities;
  final OrganizationBloc organizationBloc;
  final FCMBloc fcmBloc;
  final CacheManager cacheManager;
  final DataApiDog dataApiDog;
  final PrefsOGx prefsOGx;
  final GeoUploader geoUploader;
  final CloudStorageBloc cloudStorageBloc;
  final ProjectBloc projectBloc;
  final RealmSyncApi realmSyncApi;
  final String organizationId, startDate;

  @override
  Widget build(BuildContext context) {
    final type = getThisDeviceType();
    final tabletActions = <Widget>[
      IconButton(
          onPressed: () {
            onRefreshRequested();
          },
          icon: Icon(
            Icons.refresh,
            color: Theme.of(context).primaryColor,
          )),
      IconButton(
          onPressed: () {
            onSettingsRequested();
          },
          icon: Icon(
            Icons.settings,
            color: Theme.of(context).primaryColor,
          )),
      const SizedBox(
        width: 8,
      ),
      GestureDetector(
        onTap: () {
          onDeviceUserTapped();
        },
        child: user.thumbnailUrl == null
            ? const CircleAvatar(
          radius: 12,
        )
            : CircleAvatar(
          radius: 14,
          backgroundImage: NetworkImage(user.thumbnailUrl!),
        ),
      ),
      const SizedBox(
        width: 16,
      ),
    ];
    final phoneActions = <Widget>[
      PopupMenuButton(
        elevation: 8,
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: 3,
              child: user.thumbnailUrl == null
                  ? const CircleAvatar(
                radius: 8,
              )
                  : CircleAvatar(
                  radius: 24.0,
                  backgroundImage: NetworkImage(user.thumbnailUrl!)),
            ),
            PopupMenuItem(
                value: 1,
                child: Icon(
                  Icons.refresh,
                  color: Theme.of(context).primaryColor,
                )),
            PopupMenuItem(
                value: 2,
                child: Icon(
                  Icons.settings,
                  color: Theme.of(context).primaryColor,
                )),
            PopupMenuItem(
                value: 4,
                child: Icon(
                  Icons.subscriptions_sharp,
                  color: Theme.of(context).primaryColor,
                )),
          ];
        },
        onSelected: (index) {
          switch (index) {
            case 1:
              onRefreshRequested();
              break;
            case 2:
              onSettingsRequested();
              break;
            case 3:
              onDeviceUserTapped();
              break;
            case 4:
              onGioSubscriptionRequired();
              break;
          }
        },
      )
    ];
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    var backgroundColor = Theme.of(context).canvasColor;
    if ((!isDarkMode)) {
      backgroundColor = Colors.black;
    }

    return SizedBox(
      width: width,
      child: Stack(
        children: [
          Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 100),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            dashboardText,
                            style: myTextStyleLargePrimaryColor(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TopCardList(
                        organizationBloc: organizationBloc,
                        fcmBloc: fcmBloc,
                        dataApiDog: dataApiDog,
                        prefsOGx: prefsOGx,
                        cacheManager: cacheManager,
                        projectBloc: projectBloc,
                        geoUploader: geoUploader,
                        realmSyncApi: realmSyncApi,
                        cloudStorageBloc: cloudStorageBloc,
                      ),
                      const SizedBox(height: 20),
                      SubTitleWidget(
                          title: eventsText,
                          onTapped: () {
                            onEventsSubtitleTapped();
                          },
                          number: totalEvents,
                          color: Colors.blue),
                      const SizedBox(height: 12),
                      RecentActivitiesHorizontal(
                        organizationId: organizationId,
                        startDate: startDate,
                        onEventTapped: (act) {
                          onEventTapped(act);
                        },
                        locale: locale, realmSyncApi: realmSyncApi,
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      SubTitleWidget(
                          title: projectsText,
                          onTapped: () {
                            pp('💚💚💚💚 project subtitle tapped');
                            onProjectSubtitleTapped();
                          },
                          number: totalProjects,
                          color: Colors.blue),
                      const SizedBox(
                        height: 12,
                      ),
                      ProjectsHorizontal(
                        realmSyncApi: realmSyncApi,
                        prefsOGx: prefsOGx,
                        organizationId: organizationId,
                        onProjectTapped: (project) {
                          onProjectTapped(project);
                        },
                      ),
                      const SizedBox(height: 36),
                      SubTitleWidget(
                          title: membersText,
                          onTapped: () {
                            onUserSubtitleTapped();
                          },
                          number: totalUsers,
                          color: Theme.of(context).indicatorColor),
                      const SizedBox(
                        height: 12,
                      ),
                      MemberList(
                        realmSyncApi: realmSyncApi,
                        onUserTapped: (user) {
                          onUserTapped(user);
                        },
                      ),
                      const SizedBox(height: 200),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            child: SizedBox(
              height: 80,
              child: AppBar(
                backgroundColor: backgroundColor,
                // flexibleSpace: ClipRect(
                //   child: BackdropFilter(
                //     filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
                //     child: Container(
                //       decoration:
                //           BoxDecoration(color: Colors.white.withOpacity(0.0)),
                //     ),
                //   ),
                // ),
                title: GioHeader(
                  navigateToIntro: () {
                    navigateToIntro();
                  },
                ),
                actions: type == 'phone' ? phoneActions : tabletActions,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
