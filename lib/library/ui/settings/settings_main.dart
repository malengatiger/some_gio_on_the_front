import 'package:flutter/material.dart';
import 'package:geo_monitor/library/ui/settings/settings_mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../realm_data/data/realm_sync_api.dart';
import '../../api/data_api_og.dart';
import '../../api/prefs_og.dart';
import '../../bloc/cloud_storage_bloc.dart';
import '../../bloc/fcm_bloc.dart';
import '../../bloc/geo_uploader.dart';
import '../../bloc/isolate_handler.dart';
import '../../bloc/organization_bloc.dart';
import '../../bloc/project_bloc.dart';
import '../../cache_manager.dart';
import '../../data/project.dart';
import 'settings_tablet.dart';
import 'package:geo_monitor/realm_data/data/schemas.dart' as mrm;

class SettingsMain extends StatelessWidget {
  const SettingsMain(
      {Key? key,
      required this.dataHandler,
      required this.dataApiDog,
      required this.prefsOGx,
      required this.organizationBloc,
      required this.cacheManager,
      required this.projectBloc,
      this.project,
      required this.fcmBloc,
      required this.geoUploader,
      required this.cloudStorageBloc, required this.realmSyncApi})
      : super(key: key);
  final IsolateDataHandler dataHandler;
  final DataApiDog dataApiDog;
  final PrefsOGx prefsOGx;
  final OrganizationBloc organizationBloc;
  final CacheManager cacheManager;
  final ProjectBloc projectBloc;
  final mrm.Project? project;
  final FCMBloc fcmBloc;
  final GeoUploader geoUploader;
  final CloudStorageBloc cloudStorageBloc;
  final RealmSyncApi realmSyncApi;


  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: SettingsMobile(
        isolateHandler: dataHandler,
        dataApiDog: dataApiDog,realmSyncApi: realmSyncApi,

        organizationBloc: organizationBloc,
        prefsOGx: prefsOGx,
      ),
      tablet: OrientationLayoutBuilder(
        portrait: (context) {
          return SettingsTablet(
            fcmBloc: fcmBloc,
            project: project,
            projectBloc: projectBloc,
            dataHandler: dataHandler,
            dataApiDog: dataApiDog,
            organizationBloc: organizationBloc,
            cloudStorageBloc: cloudStorageBloc,
            geoUploader: geoUploader,
            prefsOGx: prefsOGx,
            cacheManager: cacheManager, realmSyncApi: realmSyncApi,
          );
        },
        landscape: (context) {
          return SettingsTablet(
            realmSyncApi: realmSyncApi,
            fcmBloc: fcmBloc,
            project: project,
            projectBloc: projectBloc,
            dataHandler: dataHandler,
            dataApiDog: dataApiDog,
            organizationBloc: organizationBloc,
            cloudStorageBloc: cloudStorageBloc,
            geoUploader: geoUploader,
            prefsOGx: prefsOGx,
            cacheManager: cacheManager,
          );
        },
      ),
    );
    ;
  }
}
