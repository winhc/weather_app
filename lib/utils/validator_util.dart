import 'package:flutter/material.dart';
import 'package:weather/presentation/widgets/weather_toast.dart';

class ValidatorUtil {
  static dynamic validateBasic(
      String? value, String textFieldName, BuildContext context) {
    if (value == null || value.isEmpty) {
      return WeatherToast().showToast(context,
          icon: Icons.message_rounded,
          message: '$textFieldName can\'t be empty!');
    }
    return null;
  }
}
