import 'package:weather/data/models/weather_forecast_model.dart';
import 'package:weather/data/models/weather_model.dart';

import '../../providers/weather_data_provider.dart';
import 'package:http/http.dart' as http;

import 'weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherDataProvider _weatherDataProvider = WeatherDataProvider();
  @override
  Future<Weather> getWeather(String city) async {
    final http.Response rawWeather =
        await _weatherDataProvider.getRawWeatherData(city);
    final Weather weather = Weather.fromJson(rawWeather.body);
    return weather;
  }

  @override
  Future<WeatherForecast> getWeatherForecast(
      String city, int forecastDayCount) async {
    final http.Response rawWeather = await _weatherDataProvider
        .getWeatherForecastData(city, forecastDayCount);
    final WeatherForecast weatherForecast =
        WeatherForecast.fromJson(rawWeather.body);
    return weatherForecast;
  }

  @override
  Future<WeatherForecast> getWeatherForecastByLatLong(
      double lat, double long, int forecastDayCount) async {
    final http.Response rawWeather = await _weatherDataProvider
        .getWeatherForecastDataByLatLong(lat, long, forecastDayCount);
    final WeatherForecast weatherForecast =
        WeatherForecast.fromJson(rawWeather.body);
    return weatherForecast;
  }
}
