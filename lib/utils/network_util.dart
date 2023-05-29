import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:weather/presentation/widgets/weather_toast.dart';

class NetworkUtil {
  Future<bool> isNetworkAvailable(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      WeatherToast().showToast(context,
          icon: CupertinoIcons.wifi_slash, message: "You're offline!");
      return false;
    }
  }
}
