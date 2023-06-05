import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../library/bloc/cloud_storage_bloc.dart';
import '../library/functions.dart';

class MediaGetter extends StatefulWidget {
  const MediaGetter({Key? key}) : super(key: key);

  @override
  MediaGetterState createState() => MediaGetterState();
}

class MediaGetterState extends State<MediaGetter> {
  final mm = '🔶🔶🔶🔶🔶🔶 MediaGetter:🍎';
  final mx = '🍎🍎🍎🍎🍎🍎 MediaGetter 🔶';
  final mz = '💚💚💚💚💚 MediaGetter 💚';
  var mediaListPhoto = <MediaFromCloud>[];
  var mediaListVideo = <MediaFromCloud>[];
  var mediaListAudio = <MediaFromCloud>[];
  bool busy = false;

  @override
  void initState() {
    super.initState();
    // _getCloudRef();
    printFiles();
  }

  void printFiles() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File pFile =
    File('${directory.path}$photoFileName');

    final File vFile =
    File('${directory.path}$videoFileName');

    final File aFile =
    File('${directory.path}$audioFileName');

    var prPhoto = pFile.readAsStringSync();
    var prAudio = aFile.readAsStringSync();
    var prVideo = vFile.readAsStringSync();

    List pJson = jsonDecode(prPhoto);
    for (var element in pJson) {
      var m = MediaFromCloud.fromJson(element);
      mediaListPhoto.add(m);
    }
    mediaListPhoto.sort((a,b) => b.timeCreated.compareTo(a.timeCreated));
    //
    List vJson = jsonDecode(prVideo);
    for (var element in vJson) {
      var m = MediaFromCloud.fromJson(element);
      mediaListVideo.add(m);
    }
    mediaListVideo.sort((a,b) => b.timeCreated.compareTo(a.timeCreated));

    //
    List aJson = jsonDecode(prAudio);
    for (var element in aJson) {
      var m = MediaFromCloud.fromJson(element);
      mediaListAudio.add(m);
    }
    mediaListAudio.sort((a,b) => b.timeCreated.compareTo(a.timeCreated));

    //
    pp('\n\n$mm photos: ${mediaListPhoto.length}');
    pp('$mm videos: ${mediaListVideo.length}');
    pp('$mm audio: ${mediaListAudio.length}');

    pp('\n\n $mm PHOTOS  .................................');
    for (var value in mediaListPhoto) {
      pp("$mm photo: 🌀 ${value.toJson()}");
    }
    pp('\n\n $mm VIDEOS .................................');
    for (var value in mediaListVideo) {
      pp("$mm video: 🌀 ${value.toJson()}");
    }
    pp('\n\n $mm AUDIOS  .................................');
    for (var value in mediaListAudio) {
      pp("$mm audio: 🌀 ${value.toJson()}");
    }
    count();
  }
  void _getCloudRef() async {
    setState(() {
      busy = true;
    });
    await _getPhotos();
    count();
    await _getAudios();
    count();
    await _getVideos();
    count();
    //
    _writeFiles();
    setState(() {
      busy = false;
    });
  }

  Future<void> _getPhotos() async {
    var firebaseStorageRef3 =
        FirebaseStorage.instance.ref().child(photoStorageName);
    
    var list3 = await firebaseStorageRef3.listAll();
    for (var item in list3.items) {
      var meta = await item.getMetadata();
      var url = await item.getDownloadURL();
      var isThumbnail = false;
      if (item.name.contains('thumb')) {
        isThumbnail = true;
      }
      mediaListPhoto.add(MediaFromCloud(
        type: "photo",
        emoji: '🍐🍐',
        name: item.name,
        timeCreated: meta.timeCreated!.toIso8601String(),
        url: url,
        isThumbnail: isThumbnail,
      ));
    }
  }

  Future<void> _getAudios() async {
    var firebaseStorageRef2 =
        FirebaseStorage.instance.ref().child(audioStorageName);
    
    var list2 = await firebaseStorageRef2.listAll();
    for (var item in list2.items) {
      var meta = await item.getMetadata();
      var url = await item.getDownloadURL();
      var isThumbnail = false;
      if (item.name.contains('thumb')) {
        isThumbnail = true;
      }
      mediaListAudio.add(MediaFromCloud(
        type: "audio",
        emoji: '🔷🔷',
        name: item.name,
        timeCreated: meta.timeCreated!.toIso8601String(),
        url: url,
        isThumbnail: isThumbnail,
      ));
    }
  }

  Future<void> _getVideos() async {
    var firebaseStorageRef =
        FirebaseStorage.instance.ref().child(videoStorageName);
    var list = await firebaseStorageRef.listAll();
    for (var item in list.items) {
      var meta = await item.getMetadata();
      var url = await item.getDownloadURL();
      var isThumbnail = false;
      if (item.name.contains('thumb')) {
        isThumbnail = true;
      }
      mediaListVideo.add(MediaFromCloud(
        type: "video",
        emoji: '🍎🍎',
        name: item.name,
        timeCreated: meta.timeCreated!.toIso8601String(),
        url: url,
        isThumbnail: isThumbnail,
      ));
    }
  }

  int photos = 0;
  int audios = 0;
  int videos = 0;

  void count() {
    photos = mediaListPhoto.length;
    audios = mediaListAudio.length;
    videos = mediaListVideo.length;
    pp('$mm media has been counted: photos: $photos videos: $videos audios: $audios');
    setState(() {

    });
  }
  static const videoFileName = '/media_videos.json';
  static const audioFileName = '/media_audios.json';
  static const photoFileName = '/media_photos.json';

  void _writeFiles() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File pFile =
    File('${directory.path}$photoFileName');

    final File vFile =
    File('${directory.path}$videoFileName');

    final File aFile =
    File('${directory.path}$audioFileName');
    
    var videoJson = <Map<String, dynamic>>[];
    for (var value in mediaListVideo) {
      videoJson.add(value.toJson());
    }
    String json = jsonEncode(videoJson);
    vFile.writeAsStringSync(json);

    var photoJson = <Map<String, dynamic>>[];
    for (var value in mediaListPhoto) {
      photoJson.add(value.toJson());
    }
    String json2 = jsonEncode(photoJson);
    pFile.writeAsStringSync(json2);

    var audioJson = <Map<String, dynamic>>[];
    for (var value in mediaListAudio) {
      audioJson.add(value.toJson());
    }
    String json3 = jsonEncode(audioJson);
    aFile.writeAsStringSync(json3);

    pp('$mm audio file written: ${aFile.path}');
    pp('$mm video file written: ${vFile.path}');
    pp('$mm photo file written: ${pFile.path}');


  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          'Media Getter',
          style: myTextStyleMediumLarge(context),
        ),
      ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(height: 400,
              child: Card(
                elevation: 8,
                shape: getRoundedBorder(radius: 16),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      busy? const SizedBox(height: 24, width: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 6, backgroundColor: Colors.pink,
                        ),
                      ):const SizedBox(),
                      const SizedBox(height: 72,),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Total Photos'),
                          const SizedBox(width: 12,),
                          Text('$photos', style: myTextStyleMediumLargeWithColor(context, Colors.amber),),
                        ],
                      ),
                      const SizedBox(height: 48,),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Total Audios'),
                          const SizedBox(width: 12,),
                          Text('$audios', style: myTextStyleMediumLargeWithColor(context, Colors.red),),
                        ],
                      ),
                      const SizedBox(height: 48,),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Total Videos'),
                          const SizedBox(width: 12,),
                          Text('$videos', style: myTextStyleMediumLargeWithColor(context, Colors.blue),),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
    ));
  }
}

class MediaFromCloud {
  late String type;
  late String name;
  late String timeCreated;
  late String url, emoji;
  late bool isThumbnail;

  MediaFromCloud({
    required this.type,
    required this.name,
    required this.timeCreated,
    required this.url,
    required this.isThumbnail,
    required this.emoji,
  });

  MediaFromCloud.fromJson(Map<String,dynamic> data) {
    type = data['type'];
    name = data['name'];
    timeCreated = data['timeCreated'];
    url = data['url'];
    emoji = data['emoji'];
    isThumbnail = data['isThumbnail'];
    type = data['type'];
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'name': name,
      'type': type,
      'timeCreated': timeCreated,
      'url': url,
      'isThumbnail': isThumbnail,
      'emoji': emoji,
    };
    return map;
  }
}
