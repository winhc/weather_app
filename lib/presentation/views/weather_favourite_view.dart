import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/favourite_weather/favourite_weather_bloc.dart';
import 'package:weather/presentation/widgets/weather_favourite_item.dart';
import 'package:weather/presentation/widgets/weather_loading.dart';
import 'package:weather/utils/color_util.dart';

import '../../bloc/weather/weather_bloc.dart';
import '../../data/models/local_weather_model.dart';
import '../../utils/date_util.dart';
import '../widgets/empty_item.dart';

class WeatherFavouriteView extends StatelessWidget {
  const WeatherFavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favourite")),
      body: BlocBuilder<FavouriteWeatherBloc, FavouriteWeatherState>(
        builder: (context, state) {
          if (state is WeatherFavouriteLoadInprogress) {
            return const Center(
              child: WeatherLoading(),
            );
          } else if (state is WeatherFavouriteLoadSuccess) {
            final List<LocalWeather> localWeatherList = state.localWeather;
            if (localWeatherList.isNotEmpty) {
              return ListView.builder(
                itemCount: localWeatherList.length,
                itemBuilder: (context, index) {
                  final gradientColors = ColorUtil().getRandomGradient();
                  final LocalWeather localWeather = localWeatherList[index];
                  return WeatherFavouriteItem(
                    onTap: () async {
                      _onWeatherFavouriteItemTap(localWeather, context);
                    },
                    gradientColors: gradientColors,
                    cityName: localWeather.weatherForecast!.location!.name!,
                    date: getWeekMonthDay(
                        localWeather.weatherForecast!.current!.lastUpdated!),
                    condition:
                        localWeather.weatherForecast!.current!.condition!.text!,
                    temperature:
                        "${localWeather.weatherForecast!.current!.tempC!}",
                    higestTemperature:
                        "${localWeather.weatherForecast!.forecast!.forecastday![0].day!.maxtempC!}",
                    lowestTemperature:
                        "${localWeather.weatherForecast!.forecast!.forecastday![0].day!.mintempC!}",
                  );
                },
              );
            } else {
              return const Center(
                child: EmptyItem(
                    icon: Icons.hourglass_empty_rounded,
                    message: "No favourite!"),
              );
            }
          }
          return const Center(
            child: EmptyItem(
                icon: Icons.hourglass_empty_rounded, message: "No favourite!"),
          );
        },
      ),
    );
  }

  void _onWeatherFavouriteItemTap(
      LocalWeather localWeather, BuildContext context) {
    BlocProvider.of<WeatherBloc>(context).add(WeatherForecastByLatLongRequest(
        lat: localWeather.weatherForecast!.location!.lat!,
        long: localWeather.weatherForecast!.location!.lon!,
        forecastDayCount: 3,
        context: context));
    Navigator.pop(context);
  }
}
