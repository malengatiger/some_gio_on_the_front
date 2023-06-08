import 'dart:convert';

import 'package:geo_monitor/library/data/photo.dart' as old;
import 'package:geo_monitor/library/data/video.dart' as old;
import 'package:geo_monitor/library/data/audio.dart' as old;
import 'package:geo_monitor/library/data/geofence_event.dart' as old;
import 'package:geo_monitor/library/data/project.dart' as old;
import 'package:geo_monitor/library/data/user.dart' as old;
import 'package:geo_monitor/library/data/location_response.dart' as old;
import 'package:geo_monitor/library/data/location_request.dart' as old;
import 'package:geo_monitor/library/data/project_position.dart' as old;
import 'package:geo_monitor/library/data/project_polygon.dart' as old;
import 'package:geo_monitor/library/data/city.dart' as old;
import 'package:geo_monitor/library/data/settings_model.dart' as old;

import 'package:geo_monitor/realm_data/data/schemas.dart' as mrm;
import 'package:realm/realm.dart';

class OldToRealm {
  static mrm.City getCity(old.City p) {
    var m = mrm.City(
      ObjectId(),
      cityId: p.cityId,
      countryId: p.countryId,
      stateId: p.stateId,
      name: p.name,
      stateName: p.stateName,
      countryName: p.countryName,
    );

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
        position: mrm.Position(
            type: 'Point',
            coordinates: p.position!.coordinates,
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
      var m = mrm.Position(
          type: 'Point',
          coordinates: element.coordinates,
          latitude: element.coordinates[1],
          longitude: element.coordinates[0]);
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

  static String getPhotoString(mrm.Photo p) {
    final m = {
      'organizationId': p.organizationId,
      'projectId': p.projectId,
      'projectName': p.projectName,
      'userId': p.userId,
      'userName': p.userName,
      'userUrl': p.userUrl,
      'photoId': p.photoId,
      'url': p.url,
      'thumbnailUrl': p.thumbnailUrl,
      'landscape': p.landscape,
      'created': p.created,
      'position': getPositionString(p.projectPosition!),
      'distanceFromProjectPosition': p.distanceFromProjectPosition,
      'caption': p.caption,
      'translatedTitle': p.translatedTitle,
      'translatedMessage': p.translatedMessage,
    };
    var x = jsonEncode(m);
    return x;
  }

  static String getPositionString(mrm.Position p) {
    final m = {
      'coordinates': [p.coordinates.first, p.coordinates.last],
      'latitude': p.latitude,
      'longitude': p.longitude,
      'type': p.type,
    };
    var x = jsonEncode(m);
    return x;
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

  static String getVideoString(mrm.Video p) {
    final m = {
      'organizationId': p.organizationId,
      'projectId': p.projectId,
      'projectName': p.projectName,
      'userId': p.userId,
      'userName': p.userName,
      'userUrl': p.userUrl,
      'videoId': p.videoId,
      'url': p.url,
      'thumbnailUrl': p.thumbnailUrl,
      'landscape': p.landscape,
      'created': p.created,
      'position': getPositionString(p.projectPosition!),
      'distanceFromProjectPosition': p.distanceFromProjectPosition,
      'caption': p.caption,
      'durationInSeconds': p.durationInSeconds,
      'translatedTitle': p.translatedTitle,
      'translatedMessage': p.translatedMessage,
    };
    var x = jsonEncode(m);
    return x;
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

  static String getAudioString(mrm.Audio p) {
    final m = {
      'organizationId': p.organizationId,
      'projectId': p.projectId,
      'projectName': p.projectName,
      'userId': p.userId,
      'userName': p.userName,
      'userUrl': p.userUrl,
      'audioId': p.audioId,
      'url': p.url,
      'durationInSeconds': p.durationInSeconds,
      'created': p.created,
      'position': getPositionString(p.projectPosition!),
      'distanceFromProjectPosition': p.distanceFromProjectPosition,
      'caption': p.caption,
      'translatedTitle': p.translatedTitle,
      'translatedMessage': p.translatedMessage,
    };
    var x = jsonEncode(m);
    return x;
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
  static mrm.LocationResponse getLocationResponse(old.LocationResponse p) {
    var m = mrm.LocationResponse(ObjectId(),
        locationResponseId: p.locationResponseId,
        requesterName: p.requesterName,
        organizationId: p.organizationId,
        date: p.date,
        requesterId: p.requesterId,
        userId: p.userId,
        organizationName: p.organizationName!,
        userName: p.userName,
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
  static mrm.LocationRequest getLocationRequest(old.LocationRequest p) {
    var m = mrm.LocationRequest(ObjectId(),
        requesterName: p.requesterName,
        organizationId: p.organizationId,
        created: p.created,
        requesterId: p.requesterId,
        userId: p.userId,
        organizationName: p.organizationName!,
        userName: p.userName,
        translatedTitle: p.translatedTitle,
        translatedMessage: p.translatedMessage,
        );

    return m;
  }

  static String getGeofenceString(mrm.GeofenceEvent p) {
    final m = {
      'organizationId': p.organizationId,
      'projectId': p.projectId,
      'projectName': p.projectName,
      'userId': p.userId,
      'userName': p.userName,
      'userUrl': p.userUrl,
      'geofenceEventId': p.geofenceEventId,
      'date': p.date,
      'locale': p.locale,
      'status': p.status,
      'position': getPositionString(p.position!),
      'translatedTitle': p.translatedTitle,
      'translatedMessage': p.translatedMessage,
    };
    var x = jsonEncode(m);
    return x;
  }

  static String getSettingsString(mrm.SettingsModel p) {
    final m = {
      'organizationId': p.organizationId,
      'projectId': p.projectId,
      'locale': p.locale,
      'numberOfDays': p.numberOfDays,
      'organizationName': p.organizationName,
      'distanceFromProject': p.distanceFromProject,
      'maxAudioLengthInMinutes': p.maxAudioLengthInMinutes,
      'maxVideoLengthInSeconds': p.maxVideoLengthInSeconds,
      'activityStreamHours': p.activityStreamHours,
      'photoSize': p.photoSize,
      'created': p.created,
      'themeIndex': p.themeIndex,
      'refreshRateInMinutes': p.refreshRateInMinutes,
      'settingsId': p.settingsId,
      'translatedTitle': p.translatedTitle,
      'translatedMessage': p.translatedMessage,
    };
    var x = jsonEncode(m);
    return x;
  }

  static String getProjectPositionString(mrm.ProjectPosition p) {
    final m = {
      'organizationId': p.organizationId,
      'projectId': p.projectId,
      'possibleAddress': p.possibleAddress,
      'projectName': p.projectName,
      'position': getPositionString(p.position!),
      'userId': p.userId,
      'userName': p.userName,
      'projectPositionId': p.projectPositionId,
      'name': p.name,
      'translatedTitle': p.translatedTitle,
      'translatedMessage': p.translatedMessage,
    };
    var x = jsonEncode(m);
    return x;
  }

  static String getProjectPolygonString(mrm.ProjectPolygon p) {
    var list = <String>[];
    for (var value in p.positions) {
      list.add(getPositionString(value));
    }
    final m = {
      'organizationId': p.organizationId,
      'projectId': p.projectId,
      'projectName': p.projectName,
      'userId': p.userId,
      'userName': p.userName,
      'projectPolygonId': p.projectPolygonId,
      'positions': list,
      'translatedTitle': p.translatedTitle,
      'translatedMessage': p.translatedMessage,
    };
    var x = jsonEncode(m);
    return x;
  }
  static String getProjectString(mrm.Project p) {

    final m = {
      'organizationId': p.organizationId,
      'projectId': p.projectId,
      'name': p.name,
      'organizationName': p.organizationName,
      'description': p.description,
      'monitorMaxDistanceInMetres': p.monitorMaxDistanceInMetres,
      'translatedTitle': p.translatedTitle,
      'translatedMessage': p.translatedMessage,
    };
    var x = jsonEncode(m);
    return x;
  }
  static String getUserString(mrm.User p) {
    final m = {
      'organizationId': p.organizationId ,
      'name': p.name ,
      'locale': p.locale ,
      'thumbnailUrl': p.thumbnailUrl ,
      'organizationName': p.organizationName ,
      'userId': p.userId ,
      'imageUrl': p.imageUrl ,
      'userType': p.userType ,
      'email': p.email ,
      'cellphone': p.cellphone ,
      'created': p.created ,
      'translatedTitle': p.translatedTitle,
      'translatedMessage': p.translatedMessage,
    };
    var x = jsonEncode(m);
    return x;
  }
  static String getLocationRequestString(mrm.LocationRequest p) {
    final m = {
      'organizationId': p.organizationId ,
      'requesterId': p.requesterId ,
      'requesterName': p.requesterName ,
      'organizationName': p.organizationName ,
      'userId': p.userId ,
      'userName': p.userName,
      'created': p.created ,
      'translatedTitle': p.translatedTitle,
      'translatedMessage': p.translatedMessage,
    };
    var x = jsonEncode(m);
    return x;
  }
  static String getLocationResponseString(mrm.LocationResponse p) {
    final m = {
      'organizationId': p.organizationId ,
      'requesterId': p.requesterId ,
      'requesterName': p.requesterName ,
      'organizationName': p.organizationName ,
      'userId': p.userId ,
      'date': p.date ,
      'position': getPositionString(p.position!),
      'userName': p.userName,
      'locationResponseId': p.locationResponseId,
      'translatedTitle': p.translatedTitle,
      'translatedMessage': p.translatedMessage,
    };
    var x = jsonEncode(m);
    return x;
  }
  static String getCityString(mrm.City p) {
    final m = {
      'cityId': p.cityId ,
      'requesterId': p.name ,
      'countryId': p.countryId ,
      'countryName': p.countryName ,
      'stateName': p.stateName ,
      'position': p.position == null? null: getPositionString(p.position!) ,

    };
    var x = jsonEncode(m);
    return x;
  }
}
