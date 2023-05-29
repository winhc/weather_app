import 'dart:convert';

import 'forecast_day_model.dart';

class Forecast {
  List<ForecastDay>? forecastday;
  Forecast({
    this.forecastday,
  });

  Map<String, dynamic> toMap() {
    return {
      'forecastday': forecastday?.map((x) => x.toMap()).toList(),
    };
  }

  factory Forecast.fromMap(Map<String, dynamic> map) {
    return Forecast(
      forecastday: map['forecastday'] != null
          ? List<ForecastDay>.from(
              map['forecastday']?.map((x) => ForecastDay.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Forecast.fromJson(String source) =>
      Forecast.fromMap(json.decode(source));

  @override
  String toString() => 'Forecast(forecastday: $forecastday)';
}
