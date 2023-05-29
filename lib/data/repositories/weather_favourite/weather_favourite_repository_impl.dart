import 'package:weather/data/models/local_weather_model.dart';
import 'package:weather/data/models/weather_forecast_model.dart';
import 'package:weather/data/repositories/weather_favourite/weather_favourite_repository.dart';

import '../../providers/local_database_provider.dart';

class WeatherFavouriteRepositoryImpl implements WeatherFavouriteRepository {
  final LocalDatabaseProvider _localDatabaseProvider = LocalDatabaseProvider();
  @override
  Future<int> deleteLocalWeatherData(String id) async {
    return await _localDatabaseProvider.deleteLocalWeatherData(id);
  }

  @override
  Future<List<LocalWeather>> getLocalWeatherData() async {
    return await _localDatabaseProvider.getLocalWeatherData();
  }

  @override
  Future<int> insertLocalWeatherData(LocalWeather localWeather) async {
    return await _localDatabaseProvider.insertLocalWeatherData(localWeather);
  }

  @override
  Future<void> updateLocalWeatherData(
      String id, LocalWeather localWeather) async {
    await _localDatabaseProvider.updateLocalWeatherData(id, localWeather);
  }

  @override
  Future<int> findLocalWeatherData(String id) async {
    return await _localDatabaseProvider.findLocalWeatherData(id);
  }

  @override
  Future<WeatherForecast> getLocalWeatherDataById(String id) async {
    final localWeather =
        await _localDatabaseProvider.findLocalWeatherDataById(id);
    return localWeather.weatherForecast!;
  }
}
