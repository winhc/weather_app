import 'dart:convert';

class WeatherCondition {
  String? text;
  String? icon;
  int? code;
  WeatherCondition({
    this.text,
    this.icon,
    this.code,
  });
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'icon': icon,
      'code': code,
    };
  }

  factory WeatherCondition.fromMap(Map<String, dynamic> map) {
    return WeatherCondition(
      text: map['text'],
      icon: map['icon'],
      code: map['code']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherCondition.fromJson(String source) =>
      WeatherCondition.fromMap(json.decode(source));

  @override
  String toString() =>
      'WeatherCondition(text: $text, icon: $icon, code: $code)';
}
