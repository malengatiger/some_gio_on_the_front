import 'dart:typed_data';

import 'package:geo_monitor/library/bloc/photo_for_upload.dart';
import 'package:geo_monitor/library/data/project.dart';
import 'package:hive/hive.dart';

import '../data/position.dart';
import '../data/project.dart' as old;

part 'audio_for_upload.g.dart';

@HiveType(typeId: 35)
class AudioForUpload extends HiveObject {
  @HiveField(0)
  String? filePath;
  @HiveField(1)
  String? projectId;
  @HiveField(2)
  String? projectName;

  @HiveField(3)
  Position? position;
  @HiveField(4)
  String? date;
  @HiveField(5)
  String? audioId;
  @HiveField(6)
  String? userId;
  @HiveField(7)
  String? userName;
  @HiveField(8)
  String? organizationId;
  @HiveField(9)
  String? userThumbnailUrl;
  @HiveField(10)
  int? durationInSeconds;
  @HiveField(11)
  Uint8List? fileBytes;



  AudioForUpload(
      {required this.filePath,
      required this.projectId,
        required this.projectName,

        required this.position,
      required this.audioId,
      required this.userId,
      required this.userName,
      required this.userThumbnailUrl,
      required this.organizationId,
      required this.durationInSeconds,
      required this.fileBytes,
      required this.date});

  AudioForUpload.fromJson(Map data) {
    audioId = data['audioId'];
    filePath = data['filePath'];
    date = data['date'];
    projectId = data['projectId'];
    projectName = data['projectName'];
    durationInSeconds = data['durationInSeconds'];

    userId = data['userId'];
    userName = data['userName'];
    organizationId = data['organizationId'];
    userThumbnailUrl = data['userThumbnailUrl'];

    if (data['fileBytes'] != null) {
      fileBytes = getImageBinary(data['fileBytes']);
    }

    if (data['position'] != null) {
      position = Position.fromJson(data['position']);
    }
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'audioId': audioId,
      'filePath': filePath,
      'projectId': projectId,
      'projectName': projectName,
      'date': date,
      'organizationId': organizationId,
      'userName': userName,
      'userId': userId,
      'fileBytes': fileBytes,
      'durationInSeconds': durationInSeconds,
      'userThumbnailUrl': userThumbnailUrl,
      'position': position == null ? null : position!.toJson(),
    };
    return map;
  }
}
