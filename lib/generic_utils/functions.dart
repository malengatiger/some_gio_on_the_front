import 'package:flutter/foundation.dart';

px(dynamic msg) {
  if (kReleaseMode) {
    return;
  }
  if (kDebugMode) {
    if (msg is String) {
      debugPrint('${DateTime.now().toIso8601String()} ==> $msg');
    } else {
      print('${DateTime.now().toIso8601String()} ==> $msg');
    }
  }
}
