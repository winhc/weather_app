import 'dart:convert';

class LatLong {
  double? lat;
  double? long;
  LatLong({
    this.lat,
    this.long,
  });

  LatLong copyWith({
    double? lat,
    double? long,
  }) {
    return LatLong(
      lat: lat ?? this.lat,
      long: long ?? this.long,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'long': long,
    };
  }

  factory LatLong.fromMap(Map<String, dynamic> map) {
    return LatLong(
      lat: map['lat']?.toDouble(),
      long: map['long']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory LatLong.fromJson(String source) =>
      LatLong.fromMap(json.decode(source));

  @override
  String toString() => 'LatLong(lat: $lat, long: $long)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LatLong && other.lat == lat && other.long == long;
  }

  @override
  int get hashCode => lat.hashCode ^ long.hashCode;
}
