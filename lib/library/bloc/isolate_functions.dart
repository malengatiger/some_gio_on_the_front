import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:geo_monitor/library/bloc/old_to_realm.dart';
import 'package:geo_monitor/library/bloc/photo_for_upload.dart';
import 'package:geo_monitor/library/bloc/video_for_upload.dart';
import 'package:http/http.dart' as http;
import 'package:realm/realm.dart';

import '../../realm_data/data/realm_sync_api.dart';
import '../data/audio.dart';
import '../data/photo.dart';
import '../data/user.dart' as old;
import '../data/video.dart';
import '../functions.dart';
import 'audio_for_upload.dart';
import 'geo_exception.dart';
import 'package:geo_monitor/realm_data/data/schemas.dart' as mrm;

///
///TOP LEVEL functions to upload media while running inside isolates
///
http.Client client = http.Client();

Future<mrm.Photo?> uploadPhotoFile(
    {required String objectName,
    required String url,
    required String token,
    required int height,
    required int width,
    required String mJson,
    required String photoArrived,
    required String messageFromGeo,
    required double distance}) async {
  pp('$xx 🍐🍐🍐🍐🍐🍐 _uploadPhotoFile: objectName: $objectName url: $url');

  var map = json.decode(mJson);
  var photoForUpload = PhotoForUpload.fromJson(map);
  var mPath = photoForUpload.filePath;
  var tPath = photoForUpload.thumbnailPath;
  //create multipart request for POST or PATCH method
  String? responseUrl =
      await _sendUploadRequest(token, url, objectName, mPath!);
  String? thumbUrl = await _sendUploadRequest(
      token, url, 'thumb_${DateTime.now().toUtc().toIso8601String()}', tPath!);
  pp('$xx 🍐🍐🍐🍐🍐🍐 photo and thumbnail uploaded; attempting to add photo to DB ...');
  if (responseUrl == null) {
    pp('$xx problems with uploading file, response url is null');
    return null;
  }

  var photo = mrm.Photo(ObjectId(),
      url: responseUrl,
      userUrl: photoForUpload.userThumbnailUrl,
      caption: 'tbd',
      created: photoForUpload.date,
      userId: photoForUpload.userId,
      userName: photoForUpload.userName,
      translatedMessage: photoArrived,
      translatedTitle: messageFromGeo,
      projectPosition: mrm.Position(type: 'Point', coordinates: photoForUpload.position!.coordinates,
          latitude: photoForUpload.position!.coordinates[1], longitude: photoForUpload.position!.coordinates[0]),
      distanceFromProjectPosition: distance,
      projectId: photoForUpload.projectId,
      thumbnailUrl: thumbUrl,
      projectName: photoForUpload.projectName,
      organizationId: photoForUpload.organizationId,
      projectPositionId: photoForUpload.projectPositionId,
      projectPolygonId: photoForUpload.projectPolygonId,
      photoId: photoForUpload.photoId,
      landscape: width > height ? 0 : 1);

  realmSyncApi.addPhotos([photo]);
  return photo;
}

Future<mrm.Audio?> uploadAudioFile(
    {required String objectName,
    required String url,
    required String token,
    required int height,
    required int width,
    required String mJson,
    required String audioArrived,
    required String messageFromGeo,
    required double distance}) async {
  pp('$xx 🍐🍐🍐🍐🍐🍐 _uploadAudioFile: objectName: $objectName url: $url');

  var map = json.decode(mJson);
  var audioForUpload = AudioForUpload.fromJson(map);
  var mPath = audioForUpload.filePath;
  //create multipart request for POST or PATCH method
  var mFile = File(mPath!);
  if (!mFile.existsSync()) {
    pp('$xx File does not exist. 🔴🔴🔴 Deplaning ...');
    return null;
  }
  String? responseUrl = await _sendUploadRequest(token, url, objectName, mPath);

  pp('$xx 🍐🍐🍐🍐🍐🍐 audio file uploaded; attempting to add audio to DB ...');
  if (responseUrl == null) {
    pp('$xx problems with uploading file, response url is null');
    return null;
  }

  var audio = mrm.Audio(ObjectId(),
      url: responseUrl,
      userUrl: audioForUpload.userThumbnailUrl,
      caption: 'tbd',
      created: audioForUpload.date,
      userId: audioForUpload.userId,
      userName: audioForUpload.userName,
      translatedTitle: messageFromGeo,
      translatedMessage: audioArrived,
      projectPosition: mrm.Position(type: 'Point', coordinates: audioForUpload.position!.coordinates,
          latitude: audioForUpload.position!.coordinates[1], longitude: audioForUpload.position!.coordinates[0]),
      distanceFromProjectPosition: distance,
      projectId: audioForUpload.projectId,
      projectName: audioForUpload.projectName,
      organizationId: audioForUpload.organizationId,
      durationInSeconds: audioForUpload.durationInSeconds,
      audioId: audioForUpload.audioId);

  realmSyncApi.addAudios([audio]);
  return audio;
}

Future<mrm.Video?> uploadVideoFile(
    {required String objectName,
    required String url,
    required String token,
    required double size,
    required String mJson,
    required String videoArrived,
    required String messageFromGeo,
    required double distance}) async {
  pp('\n\n$xx 🍐🍐🍐🍐🍐🍐 _uploadVideoFile: objectName: $objectName '
      ' size : $size MB');
  var map = json.decode(mJson);
  var videoForUpload = VideoForUpload.fromJson(map);

  var mPath = videoForUpload.filePath;
  var tPath = videoForUpload.thumbnailPath;
  String? responseUrl =
      await _sendUploadRequest(token, url, objectName, mPath!);
  String? thumbUrl =
      await _sendUploadRequest(token, url, 'thumb_$objectName', tPath!);

  pp('\n$xx video mp4 and thumbnail jpg uploaded OK! 👋🏽👋🏽👋🏽👋🏽👋🏽\n');

  if (responseUrl == null) {
    pp('$xx problems with uploading file');
    return null;
  }
  pp('$xx 🍐🍐🍐🍐🍐🍐 attempting to add video to DB ... size: $size MB');

  var video = mrm.Video(ObjectId(),
      url: responseUrl,
      userUrl: videoForUpload.userThumbnailUrl,
      caption: 'tbd',
      created: videoForUpload.date,
      userId: videoForUpload.userId,
      userName: videoForUpload.userName,
      projectPosition: mrm.Position(type: 'Point', coordinates: videoForUpload.position!.coordinates,
      latitude: videoForUpload.position!.coordinates[1], longitude: videoForUpload.position!.coordinates[0]),
      distanceFromProjectPosition: distance,
      translatedMessage: videoArrived,
      translatedTitle: messageFromGeo,
      projectId: videoForUpload.projectId,
      thumbnailUrl: thumbUrl,
      projectName: videoForUpload.projectName,
      organizationId: videoForUpload.organizationId,
      landscape: 1,
      durationInSeconds: videoForUpload.durationInSeconds,
      projectPositionId: videoForUpload.projectPositionId,
      projectPolygonId: videoForUpload.projectPolygonId,
      videoId: videoForUpload.videoId);

  realmSyncApi.addVideos([video]);
  return video;
}

Future<List<mrm.User>> uploadUserFile({
  required File file,
  required String url,
  required String token,
  required String translatedTitle,
  required String translatedMessage,
  required String organizationId,
}) async {
  pp('\n\n$xx 🍐🍐🍐🍐🍐🍐 uploadUserFile ...');
  var users = await _sendUserUploadRequest(
      token: token,
      url: url,
      organizationId: organizationId,
      file: file,
      translatedTitle: translatedTitle,
      translatedMessage: translatedMessage);

  pp('\n$xx user batch file uploaded OK! 👋🏽👋🏽👋🏽👋🏽👋🏽 users: ${users.length}');
  return users;
}

Future<Photo> _addPhotoToDatabase(Photo photo, String url, String token) async {
  var result = await _callPost('${url}addPhoto', photo.toJson(), token);
  pp('\n\n\n$xx 🔴🔴🔴  addPhoto succeeded. Everything OK?? 🔴🔴🔴');
  var photoBack = Photo.fromJson(result);
  pp('$xx addPhoto has added photo to DB \n');
  return photoBack;
}

Future<Video> _addVideoToDatabase(Video video, String url, String token) async {
  var result = await _callPost('${url}addVideo', video.toJson(), token);
  pp('\n\n\n$xx 🔴🔴🔴  addVideo succeeded. Everything OK?? 🔴🔴🔴');
  var videoBack = Video.fromJson(result);
  pp('$xx addVideo has added video to DB \n');
  return videoBack;
}

Future<Audio> _addAudioToDatabase(Audio audio, String url, String token) async {
  var result = await _callPost('${url}addAudio', audio.toJson(), token);
  pp('\n\n\n$xx 🔴🔴🔴  addAudio succeeded. Everything OK?? 🔴🔴🔴');
  var audioBack = Audio.fromJson(result);
  pp('$xx addAudio has added audio to DB \n');
  return audioBack;
}

Future _callPost(String mUrl, Map? bag, String token) async {
  // pp('$xx _callPost: 🔆 🔆 🔆  calling : 💙  $mUrl  💙 ');
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  String? mBag;
  if (bag != null) {
    mBag = json.encode(bag);
  }
  var start = DateTime.now();
  headers['Authorization'] = 'Bearer $token';
  try {
    var resp = await client
        .post(
          Uri.parse(mUrl),
          body: mBag,
          headers: headers,
        )
        .timeout(const Duration(seconds: 120));
    if (resp.statusCode == 200) {
      pp('$xx http POST call RESPONSE: 💙💙 statusCode: 👌👌👌 ${resp.statusCode} 👌👌👌 💙 for $mUrl');
    } else {
      pp('👿👿👿 ._callWebAPIPost: 🔆 statusCode: 👿👿👿 ${resp.statusCode} 🔆🔆🔆 for $mUrl');
      pp(resp.body);
      throw Exception('🚨🚨 Status Code 🚨 ${resp.statusCode} 🚨 ${resp.body}');
    }
    var end = DateTime.now();
    pp('$xx http POST call: 🔆 elapsed time: ${end.difference(start).inSeconds} seconds 🔆');
    try {
      var mJson = json.decode(resp.body);
      return mJson;
    } catch (e) {
      pp("👿👿👿👿👿👿👿 json.decode failed, returning response body");
      return resp.body;
    }
  } on SocketException {
    pp('$xx No Internet connection, really means that server cannot be reached 😑');
    throw GeoException(
        message: 'No Internet connection',
        url: mUrl,
        translationKey: 'networkProblem',
        errorType: GeoException.socketException);
  } on HttpException {
    pp("$xx HttpException occurred 😱");
    throw GeoException(
        message: 'Server not around',
        url: mUrl,
        translationKey: 'serverProblem',
        errorType: GeoException.httpException);
  } on FormatException {
    pp("$xx Bad response format 👎");
    throw GeoException(
        message: 'Bad response format',
        url: mUrl,
        translationKey: 'serverProblem',
        errorType: GeoException.formatException);
  } on TimeoutException {
    pp("$xx GET Request has timed out in $timeOutInSeconds seconds 👎");
    throw GeoException(
        message: 'Request timed out',
        url: mUrl,
        translationKey: 'networkProblem',
        errorType: GeoException.timeoutException);
  }
}

const xx = '😎😎😎😎😎😎😎😎 Isolate Uploader Functions : 😎😎😎 ';
const timeOutInSeconds = 120;
Future<String?> _sendUploadRequest(
    String token, String url, String objectName, String path) async {
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  };

  var mUrl = '${url}uploadFile';
  var request = http.MultipartRequest("POST", Uri.parse(mUrl));
  request.fields["objectName"] = objectName;
  var multiPartFile = await http.MultipartFile.fromPath("document", path);
  request.files.add(multiPartFile);
  request.headers.addAll(headers);

  String? responseString;
  try {
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.toBytes();
      responseString = String.fromCharCodes(responseData);
    } else {
      pp('\n\n$xx We have a problem, Boss! 🔴🔴🔴 statusCode: ${response.statusCode} '
          '- ${response.reasonPhrase}');
    }
  } on SocketException {
    pp('$xx No Internet connection, really means that server cannot be reached 😑');
    throw GeoException(
        message: 'No Internet connection',
        url: mUrl,
        translationKey: 'networkProblem',
        errorType: GeoException.socketException);
  } on HttpException {
    pp("$xx HttpException occurred 😱");
    throw GeoException(
        message: 'Server not around',
        url: mUrl,
        translationKey: 'serverProblem',
        errorType: GeoException.httpException);
  } on FormatException {
    pp("$xx Bad response format 👎");
    throw GeoException(
        message: 'Bad response format',
        url: mUrl,
        translationKey: 'serverProblem',
        errorType: GeoException.formatException);
  } on TimeoutException {
    pp("$xx GET Request has timed out in $timeOutInSeconds seconds 👎");
    throw GeoException(
        message: 'Request timed out',
        url: mUrl,
        translationKey: 'networkProblem',
        errorType: GeoException.timeoutException);
  }

  return responseString;
}

Future<List<mrm.User>> _sendUserUploadRequest(
    {required String token,
    required String url,
    required String translatedTitle,
    required String translatedMessage,
    required String organizationId,
    required File file}) async {
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  };

  var mUrl = '${url}uploadMemberFile';
  var request = http.MultipartRequest("POST", Uri.parse(mUrl));
  request.fields["organizationId"] = organizationId;
  request.fields["translatedTitle"] = translatedTitle;
  request.fields["translatedMessage"] = translatedMessage;
  var multiPartFile = await http.MultipartFile.fromPath("document", file.path);
  request.files.add(multiPartFile);
  request.headers.addAll(headers);
  var users = <mrm.User>[];
  String? responseData;
  try {
    var response = await request.send();
    if (response.statusCode == 200) {
      var bytes = await response.stream.toBytes();
      responseData = String.fromCharCodes(bytes);

      List result = jsonDecode(responseData);
      for (var element in result) {
        var p = old.User.fromJson(element);
        var real = OldToRealm.getUser(p);
        users.add(real);
      }
      for (var value in users) {
        pp('$xx user created from file: 🔵🔵 ${value.name} 🔵🔵\n');
      }
    } else {
      pp('\n\n$xx We have a problem, Boss! 🔴🔴🔴 statusCode: ${response.statusCode} '
          '- $responseData');
      throw GeoException(
          message: 'Bad Request',
          url: mUrl,
          translationKey: 'serverProblem',
          errorType: GeoException.httpException);
    }
  } on SocketException {
    pp('$xx No Internet connection, really means that server cannot be reached 😑');
    throw GeoException(
        message: 'No Internet connection',
        url: mUrl,
        translationKey: 'networkProblem',
        errorType: GeoException.socketException);
  } on HttpException {
    pp("$xx HttpException occurred 😱");
    throw GeoException(
        message: 'Server not around',
        url: mUrl,
        translationKey: 'serverProblem',
        errorType: GeoException.httpException);
  } on FormatException {
    pp("$xx Bad response format 👎");
    throw GeoException(
        message: 'Bad response format',
        url: mUrl,
        translationKey: 'serverProblem',
        errorType: GeoException.formatException);
  } on TimeoutException {
    pp("$xx GET Request has timed out in $timeOutInSeconds seconds 👎");
    throw GeoException(
        message: 'Request timed out',
        url: mUrl,
        translationKey: 'networkProblem',
        errorType: GeoException.timeoutException);
  }

  return users;
}

Future<String?> getSignedUploadUrl(
    {required String mUrl,
    required String token,
    required String objectName,
    required String contentType}) async {
  pp('$xx getSignedUploadUrl:  🔆 🔆 🔆 calling : 💙  $mUrl  💙');
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  var u = 'getSignedUrl?objectName=$objectName&contentType=$contentType';
  var finalUrl = '$mUrl$u';
  pp(finalUrl);
  var start = DateTime.now();
  headers['Authorization'] = 'Bearer $token';
  try {
    var resp = await client
        .get(
          Uri.parse(finalUrl),
          headers: headers,
        )
        .timeout(const Duration(seconds: 120));
    pp('$xx http GET call RESPONSE: .... : 💙 statusCode: 👌👌👌'
        ' ${resp.statusCode} 👌👌👌 💙 for $finalUrl');
    var end = DateTime.now();
    pp('$xx getSignedUploadUrl call: 🔆 elapsed time for http: '
        '${end.difference(start).inSeconds} seconds 🔆');
    if (resp.statusCode != 200) {
      var msg = '😡 😡 The response is not 200; it is ${resp.statusCode}, '
          'NOT GOOD, throwing up !! 🥪 🥙 🌮  😡 ${resp.body}';
      pp(msg);
      throw HttpException(msg);
    }
    // var mJson = json.decode(resp.body);
    return resp.body;
  } on SocketException {
    pp('$xx No Internet connection, really means that server cannot be reached 😑');
    throw GeoException(
        message: 'No Internet connection',
        url: mUrl,
        translationKey: 'networkProblem',
        errorType: GeoException.socketException);
  } on HttpException {
    pp("$xx HttpException occurred 😱");
    throw GeoException(
        message: 'Server not around',
        url: mUrl,
        translationKey: 'serverProblem',
        errorType: GeoException.httpException);
  } on FormatException {
    pp("$xx Bad response format 👎");
    throw GeoException(
        message: 'Bad response format',
        url: mUrl,
        translationKey: 'serverProblem',
        errorType: GeoException.formatException);
  } on TimeoutException {
    pp("$xx GET Request has timed out in $timeOutInSeconds seconds 👎");
    throw GeoException(
        message: 'Request timed out',
        url: mUrl,
        translationKey: 'networkProblem',
        errorType: GeoException.timeoutException);
  }
}

Future uploadUsingSignedUrl(
    {required String mUrl, required File file, required String token}) async {
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  headers['Authorization'] = 'Bearer $token';
  pp('$xx uploadUsingSignedUrl starting ... 🔆🔆🔆🔆🔆🔆🔆🔆🔆🔆🔆 ');

  var start = DateTime.now();
  Uint8List m = await file.readAsBytes();
  var resp = await client
      .post(
        Uri.parse(mUrl),
        headers: headers,
      )
      .timeout(const Duration(seconds: 120));
  var end = DateTime.now();
  pp('$xx uploadUsingSignedUrl call: 🔆 elapsed time: ${end.difference(start).inSeconds} '
      'seconds 🔆 \n\n');
  pp(resp);
  if (resp.statusCode == 200) {
    pp('$xx uploadUsingSignedUrl: RESPONSE: 💙💙 statusCode: 👌👌👌 '
        '${resp.statusCode} 👌👌👌 💙 for $mUrl');
  } else {
    pp('$xx 👿👿👿 DataAPI._callWebAPIPost: 🔆 statusCode: 👿👿👿 '
        '${resp.statusCode} 🔆🔆🔆 for $mUrl');
    pp(resp.body);
    throw Exception('🚨 🚨 Status Code 🚨 ${resp.statusCode} 🚨 ${resp.body}');
  }
  return null;
}
