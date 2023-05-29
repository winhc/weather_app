import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LocationDataProvider {
  final String BASE_URL = "http://api.weatherapi.com/v1";
  final String API_KEY = "YOUR_API_KEY";

  Future<http.Response> getLocationList(String location) async {
    http.Response rawLocationData = await http.get(
      Uri.parse("$BASE_URL/search.json?key=$API_KEY&q=$location"),
    );
    debugPrint(rawLocationData.body);
    return rawLocationData;
  }
}
