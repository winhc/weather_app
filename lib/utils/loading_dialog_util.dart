import 'package:flutter/material.dart';
import 'package:weather/presentation/widgets/weather_loading.dart';

class LoadingDialogUtil {
  static void showWeatherLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: const Center(
          child: SizedBox(
            width: 48,
            height: 48,
            child: WeatherLoading(),
          ),
        ),
      ),
    );
  }

  static void closeWeatherLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}
