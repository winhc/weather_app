part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoadInprogress extends WeatherState {}

class WeatherLoadSuccess extends WeatherState {
  final Weather weather;
  WeatherLoadSuccess({required this.weather});
}

class WeatherLoadFailure extends WeatherState {
  final String error;
  WeatherLoadFailure({required this.error});
}

class WeatherForecastLoadInprogress extends WeatherState {}

class WeatherForecastLoadSuccess extends WeatherState {
  final WeatherForecast weatherForecast;
  WeatherForecastLoadSuccess({required this.weatherForecast});
}

class WeatherForecastLoadFailure extends WeatherState {
  final String error;
  WeatherForecastLoadFailure({required this.error});
}

class WeatherForecastLatLongLoadInprogress extends WeatherState {}

class WeatherForecastLatLongLoadSuccess extends WeatherState {
  final WeatherForecast weatherForecast;
  WeatherForecastLatLongLoadSuccess({required this.weatherForecast});
}

class WeatherForecastLatLongLoadFailure extends WeatherState {
  final String error;
  WeatherForecastLatLongLoadFailure({required this.error});
}
