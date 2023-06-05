import 'dart:async';

import 'package:geo_monitor/library/api/prefs_og.dart';
import 'package:geo_monitor/library/bloc/isolate_handler.dart';

import '../functions.dart';

late IosPollingControl pollingControl;
class IosPollingControl {
  final mm = '🌸🌸🌸🌸🌸🌸🌸🌸 IosPollingControl 🌸🌸';
  late Timer timer;
  final IsolateDataHandler dataHandler;

  IosPollingControl(this.dataHandler);

  late StreamSubscription<bool> backgroundStreamSub;

  void startTimer() async {
    pp('\n\n$mm starting timer to control data refresh for iOS ... 🍎 and maybe Android?');

    final sett = await prefsOGx.getSettings();
    sett.refreshRateInMinutes ??= 2;
    final rateInSeconds = sett.refreshRateInMinutes! * 60;

    pp('$mm periodic timer rateInSeconds: $rateInSeconds ');

    timer = Timer.periodic(Duration(seconds: rateInSeconds), (timer) {
      pp('\n\n\n$mm ....... Timer tick: ${timer.tick} 🍎🍎🍎 '
          'at: ${DateTime.now().toIso8601String()} \n');

      dataHandler.getOrganizationData();

    });

    setBackgroundListener();
  }
  void setBackgroundListener() {
    pp('$mm setting background status listener');
    backgroundStreamSub = backgroundObserver
        .backgroundObserverStream.listen((status) {
      pp('$mm backgroundObserverStream delivered: $status, do something, Boss!');
    });
  }
}

final BackgroundObserver backgroundObserver = BackgroundObserver.instance;
class BackgroundObserver {
  // Private static instance of the singleton
  static BackgroundObserver? _instance;

  // Private constructor
  BackgroundObserver._();

  // Public getter to access the singleton instance
  static BackgroundObserver get instance {
    _instance ??= BackgroundObserver._();
    return _instance!;
  }

  // Stream controller and stream
  final StreamController<bool> backgroundObserverStreamController = StreamController.broadcast();
  Stream<bool> get backgroundObserverStream => backgroundObserverStreamController.stream;

  // Set the background state
  void setBackgroundState(bool backgroundState) {
    backgroundObserverStreamController.sink.add(backgroundState);
  }

  // Clean up resources
  void dispose() {
    backgroundObserverStreamController.close();
  }
}

