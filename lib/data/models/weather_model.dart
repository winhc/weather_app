import 'dart:convert';

import 'current_weather_model.dart';
import 'location_model.dart';

class Weather {
  Location? location;
  CurrentWeather? current;
  Weather({
    this.location,
    this.current,
  });

  Map<String, dynamic> toMap() {
    return {
      'location': location?.toMap(),
      'current': current?.toMap(),
    };
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      location:
          map['location'] != null ? Location.fromMap(map['location']) : null,
      current: map['current'] != null
          ? CurrentWeather.fromMap(map['current'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Weather.fromJson(String source) =>
      Weather.fromMap(json.decode(source));

  @override
  String toString() => 'Weather(location: $location, current: $current)';
}
