import 'package:weather/data/models/weather_forecast_model.dart';

import '../../models/local_weather_model.dart';

abstract class WeatherFavouriteRepository {
  Future<List<LocalWeather>> getLocalWeatherData();

  Future<WeatherForecast> getLocalWeatherDataById(String id);

  Future<int> insertLocalWeatherData(LocalWeather localWeather);

  Future<void> updateLocalWeatherData(String id, LocalWeather localWeather);

  Future<int> deleteLocalWeatherData(String id);

  Future<int> findLocalWeatherData(String id);
}
