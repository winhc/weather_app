import 'dart:convert';

import 'package:weather/data/models/current_weather_model.dart';
import 'package:weather/data/models/forecast_model.dart';
import 'package:weather/data/models/location_model.dart';

class WeatherForecast {
  Location? location;
  CurrentWeather? current;
  Forecast? forecast;
  WeatherForecast({
    this.location,
    this.current,
    this.forecast,
  });

  Map<String, dynamic> toMap() {
    return {
      'location': location?.toMap(),
      'current': current?.toMap(),
      'forecast': forecast?.toMap(),
    };
  }

  factory WeatherForecast.fromMap(Map<String, dynamic> map) {
    return WeatherForecast(
      location:
          map['location'] != null ? Location.fromMap(map['location']) : null,
      current: map['current'] != null
          ? CurrentWeather.fromMap(map['current'])
          : null,
      forecast:
          map['forecast'] != null ? Forecast.fromMap(map['forecast']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherForecast.fromJson(String source) =>
      WeatherForecast.fromMap(json.decode(source));

  @override
  String toString() =>
      'WeatherForecast(location: $location, current: $current, forecast: $forecast)';
}
