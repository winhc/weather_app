part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class WeatherRequest extends WeatherEvent {
  final String city;

  WeatherRequest({required this.city});
}

class WeatherForecastRequest extends WeatherEvent {
  final String city;
  final int forecastDayCount;

  WeatherForecastRequest({required this.city, required this.forecastDayCount});
}

class WeatherForecastByLatLongRequest extends WeatherEvent {
  final double lat, long;
  final int forecastDayCount;
  final BuildContext context;

  WeatherForecastByLatLongRequest(
      {required this.lat,
      required this.long,
      required this.forecastDayCount,
      required this.context});
}
