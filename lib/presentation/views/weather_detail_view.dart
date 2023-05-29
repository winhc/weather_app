import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/favourite_weather/favourite_weather_bloc.dart';
import 'package:weather/data/models/forecast_model.dart';
import 'package:weather/data/providers/local_storage_provider.dart';
import 'package:weather/presentation/views/admin_panel_view.dart';
import 'package:weather/presentation/views/weather_favourite_view.dart';
import 'package:weather/presentation/views/weather_search_view.dart';
import 'package:weather/presentation/widgets/empty_item.dart';
import 'package:weather/presentation/widgets/weather_title.dart';
import 'package:weather/utils/vibrate_util.dart';

import '../../bloc/weather/weather_bloc.dart';
import '../../data/models/forecast_day_model.dart';
import '../../data/models/local_weather_model.dart';
import '../../data/models/weather_forecast_model.dart';
import '../../utils/date_util.dart';
import '../../utils/key_util.dart';
import '../widgets/weather_condition.dart';
import '../widgets/weather_loading.dart';
import '../widgets/weather_toast.dart';

class WeatherDetailView extends StatelessWidget {
  const WeatherDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    final favouriteWeatherBloc = BlocProvider.of<FavouriteWeatherBloc>(context);

    final localStorageProvider = LocalStorageProvider();
    final latLong = localStorageProvider.getLatLongFromBox();
    if (latLong != null) {
      weatherBloc.add(WeatherForecastByLatLongRequest(
          lat: latLong.lat!,
          long: latLong.long!,
          forecastDayCount: 3,
          context: context));
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        leading: IconButton(
            onPressed: () {
              showSearch(context: context, delegate: WeatherSearchView());
            },
            icon: const Icon(Icons.search_rounded)),
        title: const Text("Weather"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_horiz_rounded),
            position: PopupMenuPosition.under,
            elevation: 14,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onSelected: (item) {
              switch (item) {
                case 1:
                  _onAdminPanelMenuItemClick(context);
                  break;
                case 2:
                  _getFavouriteWeatherData(context);
                  break;
                case 3:
                  if (weatherBloc.weatherForecast.location != null) {
                    _handleFavouriteWeather(
                        context,
                        weatherBloc.weatherForecast,
                        favouriteWeatherBloc.weatherCount);
                  } else {
                    WeatherToast().showToast(context,
                        icon: Icons.hourglass_empty_rounded,
                        message: "No place to set favourite.");
                  }
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              const PopupMenuItem(
                  value: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Admin Panel'),
                      Icon(Icons.chat_rounded),
                    ],
                  )),
              const PopupMenuItem(
                  value: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Your Favourite'),
                      Icon(Icons.list_rounded),
                    ],
                  )),
              PopupMenuItem(
                  value: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (favouriteWeatherBloc.weatherCount >= 1) ...[
                        const Text('Unfavourite'),
                        const Icon(CupertinoIcons.heart_slash),
                      ] else ...[
                        const Text('Favourite'),
                        const Icon(CupertinoIcons.heart),
                      ]
                    ],
                  )),
            ],
          )
        ],
      ),
      body: BlocConsumer<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state is WeatherForecastLoadFailure) {
            WeatherToast().showToast(context,
                icon: Icons.hourglass_empty_rounded,
                message: "Fail to get weather!");
          } else if (state is WeatherForecastLatLongLoadSuccess) {
            if (state.weatherForecast.location != null) {
              BlocProvider.of<FavouriteWeatherBloc>(context).add(
                  WeatherFavouriteFindRequest(
                      id: KeyUtil().getPrimaryKeyFromLatLong(
                          state.weatherForecast.location!.lat!,
                          state.weatherForecast.location!.lon!)));
            }
          }
        },
        builder: (context, state) {
          if (state is WeatherForecastLatLongLoadInprogress) {
            return const Center(
              child: WeatherLoading(),
            );
          } else if (state is WeatherForecastLatLongLoadSuccess) {
            if (state.weatherForecast.location != null) {
              final WeatherForecast weatherForecast = state.weatherForecast;
              final Forecast? forecast = weatherForecast.forecast;
              final List<ForecastDay> forecastDayList =
                  forecast != null ? forecast.forecastday ?? [] : [];
              return LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: constraints.maxWidth,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: WeatherTitle(
                                    city: "${weatherForecast.location!.name}",
                                    country:
                                        "${weatherForecast.location!.country}",
                                    date: getWeekMonthDay(
                                        "${state.weatherForecast.current!.lastUpdated}")),
                              ),
                            ),
                            WeatherCondition(
                              icon:
                                  '${weatherForecast.current!.condition!.icon}',
                              temperature: '${weatherForecast.current!.tempC}',
                              label:
                                  '${weatherForecast.current!.condition!.text}',
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Column(
                                children: [
                                  for (ForecastDay forecastDay
                                      in forecastDayList)
                                    ListTile(
                                      title: Text(
                                        getWeek(
                                          forecastDay.date!,
                                        ),
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      trailing: Text(
                                        '${forecastDay.day!.maxtempC}°c/${forecastDay.day!.mintempC}°c',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
            } else {
              return const Center(
                child: EmptyItem(
                    icon: Icons.hourglass_empty_rounded, message: "No place!"),
              );
            }
          } else {
            return const Center(
                child: EmptyItem(
                    icon: Icons.hourglass_empty_rounded,
                    message: "No weather!"));
          }
        },
      ),
    );
  }

  Future<void> _handleFavouriteWeather(BuildContext context,
      WeatherForecast weatherForecast, int weatherCount) async {
    if (weatherCount >= 1) {
      BlocProvider.of<FavouriteWeatherBloc>(context).add(
          WeatherFavouriteDeleteRequest(
              id: KeyUtil().getPrimaryKeyFromLatLong(
                  weatherForecast.location!.lat!,
                  weatherForecast.location!.lon!)));
      WeatherToast().showToast(context,
          icon: CupertinoIcons.heart_slash, message: "Unfavourite");
    } else {
      final localWeather = LocalWeather(
          id: KeyUtil().getPrimaryKeyFromLatLong(
              weatherForecast.location!.lat!, weatherForecast.location!.lon!),
          weatherForecast: weatherForecast);
      BlocProvider.of<FavouriteWeatherBloc>(context)
          .add(WeatherFavouriteAddRequest(localWeather: localWeather));
      debugPrint("localWeather => $localWeather");
      WeatherToast()
          .showToast(context, icon: CupertinoIcons.heart, message: "Favourite");
    }
    debugPrint("Add Success");
    Vibration().vibrate();
    BlocProvider.of<FavouriteWeatherBloc>(context).add(
        WeatherFavouriteFindRequest(
            id: KeyUtil().getPrimaryKeyFromLatLong(
                weatherForecast.location!.lat!,
                weatherForecast.location!.lon!)));
  }

  void _getFavouriteWeatherData(BuildContext context) async {
    BlocProvider.of<FavouriteWeatherBloc>(context)
        .add(WeatherFavouriteLoadRequest());
    final result =
        await Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const WeatherFavouriteView();
    }));
    if (result != null) {
      debugPrint("result => $result");
    }
  }

  void _onAdminPanelMenuItemClick(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AdminPanelView();
    }));
  }
}
