part of 'favourite_weather_bloc.dart';

@immutable
abstract class FavouriteWeatherEvent {}

class WeatherFavouriteAddRequest extends FavouriteWeatherEvent {
  final LocalWeather localWeather;

  WeatherFavouriteAddRequest({required this.localWeather});
}

class WeatherFavouriteUpdateRequest extends FavouriteWeatherEvent {
  final String id;
  final LocalWeather localWeather;

  WeatherFavouriteUpdateRequest({required this.id, required this.localWeather});
}

class WeatherFavouriteLoadRequest extends FavouriteWeatherEvent {
  WeatherFavouriteLoadRequest();
}

class WeatherFavouriteDeleteRequest extends FavouriteWeatherEvent {
  final String id;
  WeatherFavouriteDeleteRequest({required this.id});
}

class WeatherFavouriteFindRequest extends FavouriteWeatherEvent {
  final String id;
  WeatherFavouriteFindRequest({required this.id});
}
