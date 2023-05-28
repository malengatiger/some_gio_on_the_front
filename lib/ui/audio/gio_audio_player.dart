import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geo_monitor/library/api/data_api_og.dart';
import 'package:geo_monitor/library/bloc/fcm_bloc.dart';
import 'package:geo_monitor/library/cache_manager.dart';
import 'package:geo_monitor/library/data/audio.dart';
import 'package:geo_monitor/ui/audio/player_controls.dart';
import 'package:just_audio/just_audio.dart';
import 'package:siri_wave/siri_wave.dart';

import '../../l10n/translation_handler.dart';
import '../../library/api/prefs_og.dart';
import '../../library/data/settings_model.dart';
import '../../library/data/user.dart';
import '../../library/emojis.dart';
import '../../library/functions.dart';
import '../../library/ui/loading_card.dart';
import '../../library/ui/ratings/rating_adder.dart';
import '../activity/user_profile_card.dart';

class GioAudioPlayer extends StatefulWidget {
  const GioAudioPlayer(
      {Key? key,
      required this.audio,
      this.width,
      this.height,
      required this.onCloseRequested,
      required this.dataApiDog,
      required this.prefsOGx,
      required this.cacheManager})
      : super(key: key);

  final Audio audio;
  final double? width, height;
  final Function() onCloseRequested;
  final DataApiDog dataApiDog;
  final PrefsOGx prefsOGx;
  final CacheManager cacheManager;

  @override
  GioAudioPlayerState createState() => GioAudioPlayerState();
}

class GioAudioPlayerState extends State<GioAudioPlayer> {
  static const mm = '🌎🌎🌎🌎🌎🌎 AudioPlayerOGS: 🍎 🍎 🍎';
  late AudioPlayer player;
  Duration? duration;
  User? user;
  String? createdAt,
      elapsedTimeText,
      errorRecording,
      playAudioClip,
      loadingActivities;
  late SettingsModel settingsModel;
  bool isPlaying = false;
  bool isPaused = false;
  bool isStopped = true;
  bool isBuffering = false;
  bool isLoading = false;
  bool _showWave = false;
  bool _showControls = false;

  bool busy = false;
  //
  /// Set config for all platforms
  //AudioContextConfig audioContextConfig = AudioContextConfig();

  /// Set config for each platform individually
  //AudioContext audioContext = const AudioContext();
  late StreamSubscription<SettingsModel> settingsSubscriptionFCM;

  @override
  void initState() {
    super.initState();
    _setTexts();
    _listen();
  }

  void _listen() async {
    settingsSubscriptionFCM = fcmBloc.settingsStream.listen((event) {
      settingsModel = event;
      if (mounted) {
        _setTexts();
      }
    });
  }

  Future _setTexts() async {
    pp('$mm _setTexts ....');
    setState(() {
      busy = true;
    });
    user = await widget.cacheManager.getUserById(widget.audio.userId!);
    settingsModel = await widget.prefsOGx.getSettings();
    loadingActivities =
        await translator.translate('loadingActivities', settingsModel!.locale!);
    createdAt = await translator.translate('createdAt', settingsModel!.locale!);
    elapsedTimeText =
        await translator.translate('elapsedTime', settingsModel!.locale!);
    playAudioClip =
        await translator.translate('playAudioClip', settingsModel!.locale!);
    errorRecording =
        await translator.translate('errorRecording', settingsModel!.locale!);

    setState(() {
      _showControls = true;
    });

    await _init();
  }

  late Duration audioDuration;
  Future _init() async {
    pp('\n$mm ....... initialize AudioPlayer ....');

    try {
      // await AudioPlayer.global..changeLogLevel(AudioLogger.logLevel);
      //AudioLogger.logLevel = AudioLogLevel.info;
      //await AudioPlayer.global.setAudioContext(AudioContextConfig().build());
      // AudioPlayer.global.setGlobalAudioContext(AudioContextConfig().build());
      player = AudioPlayer();
      player.playbackEventStream.listen((event) async {
        switch(event.processingState) {
          case ProcessingState.loading:
            pp('$mm ');
            break;
          case ProcessingState.idle:
            pp('$mm ProcessingState.loading');
            break;
          case ProcessingState.buffering:
            pp('$mm ');
            break;
          case ProcessingState.ready:
            pp('$mm ProcessingState.buffering');
            break;
          case ProcessingState.completed:
            pp('$mm ProcessingState.completed');
            await player.stop();
            setState(() {
              isPlaying = false;
              isPaused = false;
              isStopped = true;
              _showWave = false;
              isLoading = false;
            });
            break;

        }
      }, onError: (Object e, StackTrace st) {
        if (e is PlayerException) {
          pp('Error code: ${e.code}');
          pp('Error message: ${e.message}');
        } else {
          pp('An error occurred: $e');
        }
      });
      player.durationStream.listen((event) {
        if (mounted) {
          setState(() {
            duration = event;
          });
        }
      });


      pp('$mm AudioPlayer initialized, will start playing audio.');

      setState(() {
        busy = false;
      });

      _play();
    } catch (e) {
      pp('$mm error with player: $e');
    }
  }

  void _play() async {
    pp('$mm ... start playing this sucker! ${widget.audio.url}');
    pp('$mm ... audio durationInSeconds: ${widget.audio.durationInSeconds} seconds');

    try {

      //await player.play(UrlSource(widget.audio.url!));
      await player.setAudioSource(AudioSource.uri(Uri.parse(widget.audio.url!)));
      await player.play();
      setState(() {
        isPlaying = true;
        isPaused = false;
        isStopped = false;
        _showWave = true;
        isLoading = false;
      });
    } catch (e) {
      pp('$mm player ERROR while playing ...:  🍎 $e 🍎');
    }
  }

  void _pause() async {
    pp('$mm ... pause this baby!');
    try {
      await player.pause();
      setState(() {
        isPlaying = false;
        isPaused = true;
        isStopped = false;
        _showWave = false;
        isLoading = false;
      });
    } catch (e) {
      pp('$mm player pause ERROR: $e');
    }
  }

  void _stop() async {
    pp('$mm ... stop playing; like NOW!!!');
    try {
      await player.stop();
      setState(() {
        isPlaying = false;
        isPaused = false;
        isStopped = true;
        _showWave = false;
        isLoading = false;
      });
      final deviceType = getThisDeviceType();
      if (mounted) {
        if (deviceType == 'phone') {
          Navigator.of(context).pop();
        } else {
          widget.onCloseRequested();
        }
      }
    } catch (e) {
      pp('$mm player stop ERROR: $e');
    }
  }


  void _onFavorite() async {
    pp('$mm on favorite tapped - do da bizness! navigate to RatingAdder');

    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Container(
                    color: Colors.black12,
                    child: RatingAdder(
                      elevation: 8.0,
                      audio: widget.audio,
                      onDone: () {
                        Navigator.of(context).pop();
                      },
                      dataApiDog: widget.dataApiDog,
                    )),
              ),
            ));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var ori = MediaQuery.of(context).orientation;
    if (ori.name == 'landscape') {}
    var deviceType = getThisDeviceType();
    if (widget.width != null) {
      width = widget.width!;
    } else if (deviceType == 'phone') {
      //no op
    } else {
      width = (width / 3);
    }

    if (busy) {
      return const Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 6,
            backgroundColor: Colors.pink,
          ),
        ),
      );
    }
    if (duration == null) {
      return const Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 6,
            backgroundColor: Colors.indigo,
          ),
        ),
      );

    }
    return deviceType == 'phone'
        ? SafeArea(
            child: Scaffold(
            appBar: AppBar(
              title: Text(
                playAudioClip == null ? 'Play Audio' : playAudioClip!,
                style: myTextStyleMediumLarge(context),
              ),
              bottom: const PreferredSize(preferredSize: Size.fromHeight(24), child: Column(
                children: [

                ],
              )),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child:  AudioPlayerWidget(
                      onRatingRequested: _onFavorite,
                      onStopRequested: () {
                        widget.onCloseRequested();
                      },
                      user: user!,
                      padding: 36,
                      projectName: widget.audio.projectName!,
                      settingsModel: settingsModel!,
                      duration: duration!,
                      durationText: elapsedTimeText!,
                      audio: widget.audio,
                      isPlaying: isPlaying,
                      isPaused: isPaused,
                      isStopped: isStopped,
                      showControls: _showControls,
                      onPlay: _play,
                      onPause: _pause,
                      onStop: _stop),
            ),
          ))
        : AudioPlayerWidget(
            onRatingRequested: _onFavorite,
            onStopRequested: _stop,
            user: user!,
            padding: 48,
            projectName: widget.audio.projectName!,
            settingsModel: settingsModel!,
            duration: duration!,
            durationText: elapsedTimeText!,
            audio: widget.audio,
            isPlaying: isPlaying,
            isPaused: isPaused,
            isStopped: isStopped,
            showControls: _showControls,
            onPlay: _play,
            onPause: _pause,
            onStop: _stop);
  }
}

class SiriCard extends StatelessWidget {
  SiriCard({Key? key}) : super(key: key);

  final siriWaveController = SiriWaveController();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).dialogBackgroundColor,
      shape: getRoundedBorder(radius: 16),
      elevation: 8,
      child: SizedBox(
        height: 64,
        child: SiriWave(
            options: SiriWaveOptions(
                height: 24, backgroundColor: Theme.of(context).primaryColor),
            controller: siriWaveController),
      ),
    );
  }
}

class AudioPlayerWidget extends StatelessWidget {
  const AudioPlayerWidget(
      {Key? key,
      required this.onRatingRequested,
      required this.onStopRequested,
      required this.user,
      required this.projectName,
      required this.settingsModel,
      required this.duration,
      required this.durationText,
      required this.audio,
      required this.isPlaying,
      required this.isPaused,
      required this.isStopped,
      required this.showControls,
      required this.onPlay,
      required this.onPause,
      required this.onStop,
      required this.padding})
      : super(key: key);

  final Function onRatingRequested, onStopRequested;
  final Function onPlay, onPause, onStop;
  final User user;
  final String projectName, durationText;
  final SettingsModel settingsModel;
  final Duration duration;
  final Audio audio;
  final bool isPlaying, isPaused, isStopped, showControls;
  final double padding;

  @override
  Widget build(BuildContext context) {
    var deviceType = getThisDeviceType();
    return Card(
      shape: getRoundedBorder(radius: 16),
      elevation: 16,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: SizedBox(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      onRatingRequested();
                    },
                    child: Text(
                      E.heartRed,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    width: deviceType == 'phone' ? 0 : 24,
                  ),
                  deviceType == 'phone'
                      ? const SizedBox()
                      : IconButton(
                          onPressed: () {
                            onStopRequested();
                          },
                          icon: const Icon(Icons.close)),
                ],
              ),
              SizedBox(
                height: padding,
              ),
              Text(
                projectName,
                style: myTextStyleMediumLargePrimaryColor(context),
              ),
              SizedBox(
                height: padding,
              ),
              UserProfileCard(
                  userName: user.name!,
                  padding: 16,
                  elevation: 6,
                  height: 100,
                  avatarRadius: 32,
                  namePictureHorizontal: true,
                  userThumbUrl: user.thumbnailUrl),
              const SizedBox(
                height: 28,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    getFmtDate(audio.created!, settingsModel!.locale!),
                    style: myTextStyleMediumPrimaryColor(context),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    durationText,
                    style: myTextStyleSmall(context),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    getHourMinuteSecond(duration!),
                    style: myNumberStyleLargerPrimaryColorLight(context),
                  ),
                ],
              ),
              SizedBox(
                height: padding,
              ),
              isPlaying ? SiriCard() : const SizedBox(),
              const SizedBox(
                height: 8,
              ),
              showControls
                  ? AudioPlayerControls(
                      onPlay: onPlay,
                      onPause: onPause,
                      onStop: onStop,
                      isPlaying: isPlaying,
                      isPaused: isPaused,
                      isStopped: isStopped)
                  : const SizedBox(),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
