import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:weather/data/models/lat_long_model.dart';
import 'package:weather/data/models/local_weather_model.dart';
import 'package:weather/data/models/weather_forecast_model.dart';
import 'package:weather/data/repositories/weather_favourite/weather_favourite_repository.dart';
import 'package:weather/data/repositories/weather_favourite/weather_favourite_repository_impl.dart';
import 'package:weather/utils/key_util.dart';

import '../../../data/models/weather_model.dart';
import '../../data/providers/local_storage_provider.dart';
import '../../data/repositories/weather/weather_repository.dart';
import '../../data/repositories/weather/weather_repository_impl.dart';
import '../../utils/network_util.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository = WeatherRepositoryImpl();
  final WeatherFavouriteRepository _weatherFavouriteRepository =
      WeatherFavouriteRepositoryImpl();
  WeatherForecast weatherForecast = WeatherForecast();

  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) async {
      if (event is WeatherRequest) {
        await _weatherRequest(event, emit);
      } else if (event is WeatherForecastRequest) {
        await _weatherForecastRequestRequest(event, emit);
      } else if (event is WeatherForecastByLatLongRequest) {
        await _weatherForecastRequestByLatLongRequest(event, emit);
      }
    });
  }

  Future<void> _weatherRequest(
      WeatherRequest event, Emitter<WeatherState> emit) async {
    emit.call(WeatherLoadInprogress());

    try {
      final weatherResponse = await _weatherRepository.getWeather(event.city);
      emit.call(WeatherLoadSuccess(weather: weatherResponse));
    } catch (e) {
      debugPrint("error => $e");
      emit.call(WeatherLoadFailure(error: e.toString()));
    }
  }

  Future<void> _weatherForecastRequestRequest(
      WeatherForecastRequest event, Emitter<WeatherState> emit) async {
    emit.call(WeatherForecastLoadInprogress());

    try {
      final weatherResponse = await _weatherRepository.getWeatherForecast(
          event.city, event.forecastDayCount);
      emit.call(WeatherForecastLoadSuccess(weatherForecast: weatherResponse));
    } catch (e) {
      debugPrint("error => $e");
      emit.call(WeatherForecastLoadFailure(error: e.toString()));
    }
  }

  Future<void> _weatherForecastRequestByLatLongRequest(
      WeatherForecastByLatLongRequest event, Emitter<WeatherState> emit) async {
    try {
      bool isNetworkAvailable =
          await NetworkUtil().isNetworkAvailable(event.context);
      final weatherKey =
          KeyUtil().getPrimaryKeyFromLatLong(event.lat, event.long);
      final result =
          await _weatherFavouriteRepository.findLocalWeatherData(weatherKey);

      if (isNetworkAvailable) {
        emit.call(WeatherForecastLatLongLoadInprogress());
        weatherForecast = await _weatherRepository.getWeatherForecastByLatLong(
            event.lat, event.long, event.forecastDayCount);
        if (result > 0) {
          await _weatherFavouriteRepository.updateLocalWeatherData(weatherKey,
              LocalWeather(id: weatherKey, weatherForecast: weatherForecast));
        }
      } else if (!isNetworkAvailable) {
        if (result > 0) {
          weatherForecast = await _weatherFavouriteRepository
              .getLocalWeatherDataById(weatherKey);
        }
      }

      final localStorageProvider = LocalStorageProvider();
      localStorageProvider.setLatLongToBox(LatLong(
          lat: weatherForecast.location!.lat!,
          long: weatherForecast.location!.lon));

      emit.call(
          WeatherForecastLatLongLoadSuccess(weatherForecast: weatherForecast));
    } catch (e) {
      debugPrint("error => $e");
      emit.call(WeatherForecastLatLongLoadFailure(error: e.toString()));
    }
  }
}
