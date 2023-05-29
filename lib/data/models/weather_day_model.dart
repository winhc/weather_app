import 'dart:convert';

import 'package:weather/data/models/weather_condition_model.dart';

class WeatherDay {
  double? maxtempC;
  double? mintempC;
  WeatherCondition? condition;
  WeatherDay({
    this.maxtempC,
    this.mintempC,
    this.condition,
  });

  Map<String, dynamic> toMap() {
    return {
      'maxtemp_c': maxtempC,
      'mintemp_c': mintempC,
      'condition': condition?.toMap(),
    };
  }

  factory WeatherDay.fromMap(Map<String, dynamic> map) {
    return WeatherDay(
      maxtempC: map['maxtemp_c']?.toDouble(),
      mintempC: map['mintemp_c']?.toDouble(),
      condition: map['condition'] != null
          ? WeatherCondition.fromMap(map['condition'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherDay.fromJson(String source) =>
      WeatherDay.fromMap(json.decode(source));

  @override
  String toString() =>
      'WeatherDay(maxtempC: $maxtempC, mintempC: $mintempC, condition: $condition)';
}
