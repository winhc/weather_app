import 'package:weather/data/models/location_model.dart';

abstract class LocationRepository {
  Future<List<Location>> getLocationList(String location);
}
