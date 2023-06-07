import 'package:hive/hive.dart';

import 'position.dart';

part 'geofence_event.g.dart';

@HiveType(typeId: 3)
class GeofenceEvent extends HiveObject {
  @HiveField(0)
  String? status;

  @HiveField(1)
  String? geofenceEventId;

  @HiveField(2)
  String? date;

  @HiveField(3)
  String? projectPositionId;

  @HiveField(4)
  String? projectName;

  @HiveField(7)
  String? organizationId;

  @HiveField(8)
  Position? position;
  @HiveField(9)
  String? projectId;

  @HiveField(10)
  String? translatedMessage;

  @HiveField(11)
  String? translatedTitle;
  @HiveField(12)
  String? id;
  @HiveField(13)
  String? userId;
  @HiveField(14)
  String? userName;
  @HiveField(15)
  String? userUrl;

  GeofenceEvent(
      {required this.status,
      required this.userId,
      required this.userName,
      required this.userUrl,
      required this.geofenceEventId,
      required this.projectPositionId,
      required this.organizationId,
      required this.projectId,
      required this.position,
      this.id,
      required this.projectName,
      required this.translatedMessage,
      required this.translatedTitle,
      required this.date});

  GeofenceEvent.fromJson(Map data) {
    status = data['status'];
    geofenceEventId = data['geofenceEventId'];
    projectPositionId = data['projectPositionId'];
    projectName = data['projectName'];
    projectId = data['projectId'];
    translatedMessage = data['translatedMessage'];
    translatedTitle = data['translatedTitle'];
    id = data['id'];
    date = data['date'];
    userId = data['userId'];
    userName = data['userName'];
    userUrl = data['userUrl'];

    organizationId = data['organizationId'];

    if (data['position'] != null) {
      position = Position.fromJson(data['position']);
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'status': status,
      'id': id,
      'organizationId': organizationId,
      'geofenceEventId': geofenceEventId,
      'projectPositionId': projectPositionId,
      'projectName': projectName,
      'projectId': projectId,
      'translatedMessage': translatedMessage,
      'translatedTitle': translatedTitle,
      'date': date,
      'userId': userId,
      'userName': userName,
      'userUrl': userUrl,
      'position': position == null ? null : position!.toJson(),
    };
    return map;
  }
}
