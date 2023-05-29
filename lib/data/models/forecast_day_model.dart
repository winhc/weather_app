import 'dart:convert';

import 'package:weather/data/models/weather_day_model.dart';

class ForecastDay {
  String? date;
  WeatherDay? day;
  ForecastDay({
    this.date,
    this.day,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'day': day?.toMap(),
    };
  }

  factory ForecastDay.fromMap(Map<String, dynamic> map) {
    return ForecastDay(
      date: map['date'],
      day: map['day'] != null ? WeatherDay.fromMap(map['day']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ForecastDay.fromJson(String source) =>
      ForecastDay.fromMap(json.decode(source));

  @override
  String toString() => 'ForecastDay(date: $date, day: $day)';
}
