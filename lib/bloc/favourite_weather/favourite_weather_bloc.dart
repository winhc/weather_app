import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:weather/data/repositories/weather_favourite/weather_favourite_repository.dart';
import 'package:weather/data/repositories/weather_favourite/weather_favourite_repository_impl.dart';

import '../../../data/models/local_weather_model.dart';

part 'favourite_weather_event.dart';
part 'favourite_weather_state.dart';

class FavouriteWeatherBloc
    extends Bloc<FavouriteWeatherEvent, FavouriteWeatherState> {
  final WeatherFavouriteRepository _weatherFavouriteRepository =
      WeatherFavouriteRepositoryImpl();

  int weatherCount = 0;

  FavouriteWeatherBloc() : super(FavouriteWeatherInitial()) {
    on<FavouriteWeatherEvent>((event, emit) async {
      if (event is WeatherFavouriteAddRequest) {
        await _weatherFavouriteAddRequest(event, emit);
      } else if (event is WeatherFavouriteLoadRequest) {
        await _weatherFavouriteLoadRequest(event, emit);
      } else if (event is WeatherFavouriteFindRequest) {
        await _weatherFavouriteFindRequest(event, emit);
      } else if (event is WeatherFavouriteDeleteRequest) {
        await _weatherFavouriteDeleteRequest(event, emit);
      }
    });
  }

  Future<void> _weatherFavouriteAddRequest(WeatherFavouriteAddRequest event,
      Emitter<FavouriteWeatherState> emit) async {
    emit.call(WeatherFavouriteAddInprogress());

    try {
      final weatherResponse = await _weatherFavouriteRepository
          .insertLocalWeatherData(event.localWeather);
      emit.call(WeatherFavouriteAddSuccess(result: weatherResponse));
    } catch (e) {
      debugPrint("error => $e");
      emit.call(WeatherFavouriteAddFailure(error: e.toString()));
    }
  }

  Future<void> _weatherFavouriteLoadRequest(WeatherFavouriteLoadRequest event,
      Emitter<FavouriteWeatherState> emit) async {
    emit.call(WeatherFavouriteLoadInprogress());
    try {
      final weatherResponse =
          await _weatherFavouriteRepository.getLocalWeatherData();
      emit.call(WeatherFavouriteLoadSuccess(localWeather: weatherResponse));
    } catch (e) {
      debugPrint("error => $e");
      emit.call(WeatherFavouriteLoadFailure(error: e.toString()));
    }
  }

  Future<void> _weatherFavouriteFindRequest(WeatherFavouriteFindRequest event,
      Emitter<FavouriteWeatherState> emit) async {
    emit.call(WeatherFavouriteAddInprogress());

    try {
      weatherCount =
          await _weatherFavouriteRepository.findLocalWeatherData(event.id);
      emit.call(WeatherFavouriteFindSuccess(result: weatherCount));
    } catch (e) {
      debugPrint("error => $e");
      emit.call(WeatherFavouriteFindFailure(error: e.toString()));
    }
  }

  Future<void> _weatherFavouriteDeleteRequest(
      WeatherFavouriteDeleteRequest event,
      Emitter<FavouriteWeatherState> emit) async {
    emit.call(WeatherFavouriteDeleteInprogress());

    try {
      final weatherResponse =
          await _weatherFavouriteRepository.deleteLocalWeatherData(event.id);
      emit.call(WeatherFavouriteDeleteSuccess(result: weatherResponse));
    } catch (e) {
      debugPrint("error => $e");
      emit.call(WeatherFavouriteDeleteFailure(error: e.toString()));
    }
  }
}
