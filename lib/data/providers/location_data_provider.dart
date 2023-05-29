import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LocationDataProvider {
  final String BASE_URL = "http://api.weatherapi.com/v1";
  final String API_KEY = "df5ba0a0234b41068c9171151232505";

  Future<http.Response> getLocationList(String location) async {
    http.Response rawLocationData = await http.get(
      Uri.parse("$BASE_URL/search.json?key=$API_KEY&q=$location"),
    );
    debugPrint(rawLocationData.body);
    return rawLocationData;
  }
}
