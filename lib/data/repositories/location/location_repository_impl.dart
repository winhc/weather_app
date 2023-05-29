import 'dart:convert';

import 'package:weather/data/models/location_model.dart';
import 'package:weather/data/providers/location_data_provider.dart';
import 'package:http/http.dart' as http;

import 'location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDataProvider _locationDataProvider = LocationDataProvider();
  @override
  Future<List<Location>> getLocationList(String location) async {
    List<Location> locationList = [];
    final http.Response rawLocation =
        await _locationDataProvider.getLocationList(location);
    if (rawLocation.statusCode == 200) {
      final dataList = json.decode(rawLocation.body);
      locationList =
          List<Location>.from(dataList.map((model) => Location.fromMap(model)));
    }
    return locationList;
  }
}
