import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherDataProvider {
  final String BASE_URL = "http://api.weatherapi.com/v1";
  final String API_KEY = "df5ba0a0234b41068c9171151232505";

  Future<http.Response> getRawWeatherData(String city) async {
    http.Response rawWeatherData = await http.get(
      Uri.parse("$BASE_URL/current.json?key=$API_KEY&q=$city"),
    );
    debugPrint(rawWeatherData.body);
    return rawWeatherData;
  }

  Future<http.Response> getWeatherForecastData(
      String city, int forecastDayCount) async {
    http.Response rawWeatherData = await http.get(
      Uri.parse(
          "$BASE_URL/forecast.json?key=$API_KEY&q=$city&days=$forecastDayCount"),
    );
    debugPrint(rawWeatherData.body);
    return rawWeatherData;
  }

  Future<http.Response> getWeatherForecastDataByLatLong(
      double lat, double long, int forecastDayCount) async {
    http.Response rawWeatherData = await http.get(
      Uri.parse(
          "$BASE_URL/forecast.json?key=$API_KEY&q=$lat,$long&days=$forecastDayCount"),
    );
    debugPrint(rawWeatherData.body);
    return rawWeatherData;
  }
}
