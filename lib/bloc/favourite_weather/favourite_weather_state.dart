part of 'favourite_weather_bloc.dart';

@immutable
abstract class FavouriteWeatherState {}

class FavouriteWeatherInitial extends FavouriteWeatherState {}

class WeatherFavouriteAddInprogress extends FavouriteWeatherState {}

class WeatherFavouriteAddSuccess extends FavouriteWeatherState {
  final int result;
  WeatherFavouriteAddSuccess({required this.result});
}

class WeatherFavouriteAddFailure extends FavouriteWeatherState {
  final String error;
  WeatherFavouriteAddFailure({required this.error});
}

class WeatherFavouriteLoadInprogress extends FavouriteWeatherState {}

class WeatherFavouriteLoadSuccess extends FavouriteWeatherState {
  final List<LocalWeather> localWeather;
  WeatherFavouriteLoadSuccess({required this.localWeather});
}

class WeatherFavouriteLoadFailure extends FavouriteWeatherState {
  final String error;
  WeatherFavouriteLoadFailure({required this.error});
}

class WeatherFavouriteFindInprogress extends FavouriteWeatherState {}

class WeatherFavouriteFindSuccess extends FavouriteWeatherState {
  final int result;
  WeatherFavouriteFindSuccess({required this.result});
}

class WeatherFavouriteFindFailure extends FavouriteWeatherState {
  final String error;
  WeatherFavouriteFindFailure({required this.error});
}

class WeatherFavouriteDeleteInprogress extends FavouriteWeatherState {}

class WeatherFavouriteDeleteSuccess extends FavouriteWeatherState {
  final int result;
  WeatherFavouriteDeleteSuccess({required this.result});
}

class WeatherFavouriteDeleteFailure extends FavouriteWeatherState {
  final String error;
  WeatherFavouriteDeleteFailure({required this.error});
}
