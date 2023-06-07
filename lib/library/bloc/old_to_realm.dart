import 'package:geo_monitor/library/data/photo.dart' as old;
import 'package:geo_monitor/library/data/video.dart' as old;
import 'package:geo_monitor/library/data/audio.dart' as old;
import 'package:geo_monitor/library/data/geofence_event.dart' as old;
import 'package:geo_monitor/library/data/project.dart' as old;
import 'package:geo_monitor/library/data/user.dart' as old;
import 'package:geo_monitor/library/data/activity_model.dart' as old;
import 'package:geo_monitor/library/data/location_request.dart' as old;
import 'package:geo_monitor/library/data/project_position.dart' as old;
import 'package:geo_monitor/library/data/project_polygon.dart' as old;
import 'package:geo_monitor/library/data/city.dart' as old;
import 'package:geo_monitor/library/data/settings_model.dart' as old;

import 'package:geo_monitor/realm_data/data/schemas.dart' as mrm;
import 'package:realm/realm.dart';

class OldToRealm {
  static mrm.City getCity(old.City p) {
    var m = mrm.City(ObjectId(),
        cityId: p.cityId,
        countryId: p.countryId,
        stateId: p.created,
        name: p.name,
        stateName: p.stateName,
        countryName: p.countryName,);

    return m;
  }
  static mrm.User getUser(old.User p) {
    var m = mrm.User(ObjectId(),
        userId: p.userId,
        organizationId: p.organizationId,
        created: p.created,
        name: p.name,
        organizationName: p.organizationName,
        translatedMessage: p.translatedMessage,
        translatedTitle: p.translatedTitle);

    return m;
  }
  static mrm.Project getProject(old.Project p) {
    var m = mrm.Project(ObjectId(),
        projectId: p.projectId,
        organizationId: p.organizationId,
        created: p.created,
        description: p.description,
        name: p.name,
        organizationName: p.organizationName,
        translatedMessage: p.translatedMessage,
        translatedTitle: p.translatedTitle);

    return m;
  }

  static mrm.ProjectPosition getProjectPosition(old.ProjectPosition p) {
    //todo - nearest cities, Joe?
    var m = mrm.ProjectPosition(ObjectId(),
        projectId: p.projectId,
        organizationId: p.organizationId,
        created: p.created,
        userId: p.userId,
        userName: p.userName,
        caption: p.caption,
        projectName: p.projectName,
        possibleAddress: p.possibleAddress,
        projectPositionId: p.projectPositionId,
        position: mrm.Position(type: 'Point', coordinates: p.position!.coordinates,
            longitude: p.position!.coordinates[0],
            latitude: p.position!.coordinates[1]),
        name: p.name,
        translatedMessage: p.translatedMessage,
        translatedTitle: p.translatedTitle);

    return m;
  }
  static mrm.ProjectPolygon getProjectPolygon(old.ProjectPolygon p) {
    var list = <mrm.Position>[];
    for (var element in p.positions) {
      var m = mrm.Position(type: 'Point', coordinates: element.coordinates,
      latitude: element.coordinates[1], longitude: element.coordinates[0]);
      list.add(m);
    }
    //todo - nearest cities, Joe?
    var m = mrm.ProjectPolygon(ObjectId(),
        projectId: p.projectId,
        organizationId: p.organizationId,
        created: p.created,
        userId: p.userId,
        userName: p.userName,
        projectName: p.projectName,
        positions: list,
        projectPolygonId: p.projectPolygonId,
        organizationName: null,
        translatedMessage: p.translatedMessage,
        translatedTitle: p.translatedTitle);

    return m;
  }

  static mrm.SettingsModel getSettings(old.SettingsModel p) {
    var m = mrm.SettingsModel(ObjectId(),
        settingsId: p.settingsId,
        projectId: p.projectId,
        organizationId: p.organizationId,
        created: p.created,
        refreshRateInMinutes: p.refreshRateInMinutes,
        locale: p.locale,
        themeIndex: p.themeIndex,
        maxVideoLengthInSeconds: p.maxVideoLengthInSeconds,
        maxAudioLengthInMinutes: p.maxAudioLengthInMinutes,
        photoSize: p.photoSize,
        distanceFromProject: p.distanceFromProject,
        activityStreamHours: p.activityStreamHours,
        numberOfDays: p.numberOfDays,
        organizationName: null,
        translatedMessage: p.translatedMessage,
        translatedTitle: p.translatedTitle);

    return m;
  }

  static mrm.Photo getPhoto(old.Photo p) {
    var m = mrm.Photo(ObjectId(),
        photoId: p.photoId,
        projectId: p.projectId,
        organizationId: p.organizationId,
        created: p.created,
        caption: p.caption,
        url: p.url,
        userId: p.userId,
        userUrl: p.userUrl,
        projectName: p.projectName,
        thumbnailUrl: p.thumbnailUrl,
        landscape: p.landscape,
        userName: p.userName,
        projectPolygonId: p.projectPolygonId,
        projectPositionId: p.projectPositionId,
        distanceFromProjectPosition: p.distanceFromProjectPosition,
        translatedTitle: p.translatedTitle,
        translatedMessage: p.translatedMessage,
        projectPosition: mrm.Position(
          type: p.projectPosition!.type!,
          coordinates: p.projectPosition!.coordinates,
          latitude: p.projectPosition!.coordinates[1],
          longitude: p.projectPosition!.coordinates[0],
        ));

    return m;
  }

  static mrm.Video getVideo(old.Video p) {
    var m = mrm.Video(
      ObjectId(),
      videoId: p.videoId,
      projectId: p.projectId,
      organizationId: p.organizationId,
      created: p.created,
      caption: p.caption,
      url: p.url,
      userId: p.userId,
      userUrl: p.userUrl,
      projectName: p.projectName,
      thumbnailUrl: p.thumbnailUrl,
      durationInSeconds: p.durationInSeconds,
      userName: p.userName,
      projectPolygonId: p.projectPolygonId,
      projectPositionId: p.projectPositionId,
      distanceFromProjectPosition: p.distanceFromProjectPosition,
      translatedTitle: p.translatedTitle,
      translatedMessage: p.translatedMessage,
      projectPosition: mrm.Position(
        type: p.projectPosition!.type!,
        coordinates: p.projectPosition!.coordinates,
        latitude: p.projectPosition!.coordinates[1],
        longitude: p.projectPosition!.coordinates[0],
      ),
    );

    return m;
  }

  static mrm.Audio getAudio(old.Audio p) {
    var m = mrm.Audio(ObjectId(),
        audioId: p.audioId,
        projectId: p.projectId,
        organizationId: p.organizationId,
        created: p.created,
        caption: p.caption,
        url: p.url,
        userId: p.userId,
        userUrl: p.userUrl,
        projectName: p.projectName,
        userName: p.userName,
        projectPolygonId: p.projectPolygonId,
        projectPositionId: p.projectPositionId,
        distanceFromProjectPosition: p.distanceFromProjectPosition,
        translatedTitle: p.translatedTitle,
        translatedMessage: p.translatedMessage,
        projectPosition: mrm.Position(
          type: p.projectPosition!.type!,
          coordinates: p.projectPosition!.coordinates,
          latitude: p.projectPosition!.coordinates[1],
          longitude: p.projectPosition!.coordinates[0],
        ));

    return m;
  }

  static mrm.GeofenceEvent getGeofenceEvent(old.GeofenceEvent p) {
    var m = mrm.GeofenceEvent(ObjectId(),
        geofenceEventId: p.geofenceEventId,
        projectId: p.projectId,
        organizationId: p.organizationId,
        date: p.date,
        status: p.status,
        userId: p.userId,
        userUrl: p.userUrl!,
        projectName: p.projectName,
        userName: p.userName,
        projectPositionId: p.projectPositionId,
        translatedTitle: p.translatedTitle,
        translatedMessage: p.translatedMessage,
        position: mrm.Position(
          type: p.position!.type!,
          coordinates: p.position!.coordinates,
          latitude: p.position!.coordinates[1],
          longitude: p.position!.coordinates[0],
        ));

    return m;
  }
}
