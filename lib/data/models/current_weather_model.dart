import 'dart:convert';

import 'weather_condition_model.dart';

class CurrentWeather {
  int? lastUpdatedEpoch;
  String? lastUpdated;
  int? tempC;
  int? tempF;
  int? isDay;
  WeatherCondition? condition;
  double? windMph;
  int? windKph;
  int? windDegree;
  String? windDir;
  int? pressureMb;
  double? pressureIn;
  int? precipMm;
  int? precipIn;
  int? humidity;
  int? cloud;
  double? feelslikeC;
  double? feelslikeF;
  int? visKm;
  int? visMiles;
  int? uv;
  double? gustMph;
  double? gustKph;
  CurrentWeather({
    this.lastUpdatedEpoch,
    this.lastUpdated,
    this.tempC,
    this.tempF,
    this.isDay,
    this.condition,
    this.windMph,
    this.windKph,
    this.windDegree,
    this.windDir,
    this.pressureMb,
    this.pressureIn,
    this.precipMm,
    this.precipIn,
    this.humidity,
    this.cloud,
    this.feelslikeC,
    this.feelslikeF,
    this.visKm,
    this.visMiles,
    this.uv,
    this.gustMph,
    this.gustKph,
  });

  Map<String, dynamic> toMap() {
    return {
      'last_updated_epoch': lastUpdatedEpoch,
      'last_updated': lastUpdated,
      'temp_c': tempC,
      'temp_f': tempF,
      'is_day': isDay,
      'condition': condition?.toMap(),
      'wind_mph': windMph,
      'wind_kph': windKph,
      'wind_degree': windDegree,
      'wind_dir': windDir,
      'pressure-mb': pressureMb,
      'pressure_in': pressureIn,
      'precip_mm': precipMm,
      'precip_in': precipIn,
      'humidity': humidity,
      'cloud': cloud,
      'feelslike_c': feelslikeC,
      'feelslike_f': feelslikeF,
      'visKm': visKm,
      'vis_miles': visMiles,
      'uv': uv,
      'gust_mph': gustMph,
      'gust_kph': gustKph,
    };
  }

  factory CurrentWeather.fromMap(Map<String, dynamic> map) {
    return CurrentWeather(
      lastUpdatedEpoch: map['last_updated_epoch']?.toInt(),
      lastUpdated: map['last_updated'],
      tempC: map['temp_c']?.toInt(),
      tempF: map['temp_f']?.toInt(),
      isDay: map['is_day']?.toInt(),
      condition: map['condition'] != null
          ? WeatherCondition.fromMap(map['condition'])
          : null,
      windMph: map['wind_mph']?.toDouble(),
      windKph: map['wind_kph']?.toInt(),
      windDegree: map['wind_degree']?.toInt(),
      windDir: map['wind_dir'],
      pressureMb: map['pressure_mb']?.toInt(),
      pressureIn: map['pressure_in']?.toDouble(),
      precipMm: map['precip_mm']?.toInt(),
      precipIn: map['precip_in']?.toInt(),
      humidity: map['humidity']?.toInt(),
      cloud: map['cloud']?.toInt(),
      feelslikeC: map['feelslikeC']?.toDouble(),
      feelslikeF: map['feelslikeF']?.toDouble(),
      visKm: map['vis_km']?.toInt(),
      visMiles: map['vis_miles']?.toInt(),
      uv: map['uv']?.toInt(),
      gustMph: map['gust_mph']?.toDouble(),
      gustKph: map['gust_kph']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentWeather.fromJson(String source) =>
      CurrentWeather.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CurrentWeather(lastUpdatedEpoch: $lastUpdatedEpoch, lastUpdated: $lastUpdated, tempC: $tempC, tempF: $tempF, isDay: $isDay, condition: $condition, windMph: $windMph, windKph: $windKph, windDegree: $windDegree, windDir: $windDir, pressureMb: $pressureMb, pressureIn: $pressureIn, precipMm: $precipMm, precipIn: $precipIn, humidity: $humidity, cloud: $cloud, feelslikeC: $feelslikeC, feelslikeF: $feelslikeF, visKm: $visKm, visMiles: $visMiles, uv: $uv, gustMph: $gustMph, gustKph: $gustKph)';
  }
}
