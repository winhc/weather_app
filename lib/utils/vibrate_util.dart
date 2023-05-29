import 'package:flutter/services.dart';

class Vibration {
  Future<void> vibrate() async {
    const vibrationDuration = Duration(milliseconds: 500);
    await SystemChannels.platform.invokeMethod<void>('HapticFeedback.vibrate');
    await Future.delayed(vibrationDuration);
  }
}
