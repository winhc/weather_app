import 'package:weather/data/models/weather_forecast_model.dart';
import 'package:weather/data/models/weather_model.dart';

import '../../providers/weather_data_provider.dart';
import 'package:http/http.dart' as http;

import 'weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherDataProvider _weatherDataProvider = WeatherDataProvider();
  @override
  Future<Weather> getWeather(String city) async {
    Weather weather = Weather();
    final http.Response rawWeather =
        await _weatherDataProvider.getRawWeatherData(city);
    if (rawWeather.statusCode == 200) {
      weather = Weather.fromJson(rawWeather.body);
    }
    return weather;
  }

  @override
  Future<WeatherForecast> getWeatherForecast(
      String city, int forecastDayCount) async {
    WeatherForecast weatherForecast = WeatherForecast();
    final http.Response rawWeather = await _weatherDataProvider
        .getWeatherForecastData(city, forecastDayCount);
    if (rawWeather.statusCode == 200) {
      weatherForecast = WeatherForecast.fromJson(rawWeather.body);
    }
    return weatherForecast;
  }

  @override
  Future<WeatherForecast> getWeatherForecastByLatLong(
      double lat, double long, int forecastDayCount) async {
    WeatherForecast weatherForecast = WeatherForecast();
    final http.Response rawWeather = await _weatherDataProvider
        .getWeatherForecastDataByLatLong(lat, long, forecastDayCount);
    if (rawWeather.statusCode == 200) {
      weatherForecast = WeatherForecast.fromJson(rawWeather.body);
    }
    return weatherForecast;
  }
}
