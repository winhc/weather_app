import 'package:weather/data/models/weather_forecast_model.dart';
import 'package:weather/data/models/weather_model.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather(String city);

  Future<WeatherForecast> getWeatherForecast(String city, int forecastDayCount);

  Future<WeatherForecast> getWeatherForecastByLatLong(
      double lat, double long, int forecastDayCount);
}
