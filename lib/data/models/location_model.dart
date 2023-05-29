import 'dart:convert';

class Location {
  String? name;
  String? region;
  String? country;
  double? lat;
  double? lon;
  Location({
    this.name,
    this.region,
    this.country,
    this.lat,
    this.lon,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'region': region,
      'country': country,
      'lat': lat,
      'lon': lon
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
        name: map['name'],
        region: map['region'],
        country: map['country'],
        lat: map['lat']?.toDouble(),
        lon: map['lon']?.toDouble());
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) =>
      Location.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Location(name: $name, region: $region, country: $country, lat: $lat, lon: $lon)';
  }
}
