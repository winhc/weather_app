import 'dart:convert';

import 'package:weather/data/models/weather_forecast_model.dart';

class LocalWeather {
  String? id;
  WeatherForecast? weatherForecast;
  LocalWeather({
    this.id,
    this.weatherForecast,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'weather_forecast': weatherForecast?.toJson(),
    };
  }

  factory LocalWeather.fromMap(Map<String, dynamic> map) {
    return LocalWeather(
      id: map['id'],
      weatherForecast: map['weather_forecast'] != null
          ? WeatherForecast.fromJson(map['weather_forecast'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalWeather.fromJson(String source) =>
      LocalWeather.fromMap(json.decode(source));

  @override
  String toString() =>
      'LocalWeather(id: $id, weatherForecast: $weatherForecast)';
}
