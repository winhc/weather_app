import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:weather/data/models/lat_long_model.dart';

class LocalStorageProvider {
  LocalStorageProvider._instance();
  static final LocalStorageProvider _localStorageProvider =
      LocalStorageProvider._instance();
  factory LocalStorageProvider() => _localStorageProvider;

  final box = GetStorage();

  final String key = 'LAT_LONG_KEY';

  setLatLongToBox(LatLong latLong) {
    var data = latLong.toJson();
    var dataStr = json.encode(data);
    box.write(key, dataStr);
  }

  LatLong? getLatLongFromBox() {
    var data = box.read(key) ?? "";
    LatLong latLong = LatLong();
    if (data != "") {
      var jsonStr = json.decode(data);
      latLong = LatLong.fromJson(jsonStr);
      return latLong;
    } else {
      return null;
    }
  }
}
