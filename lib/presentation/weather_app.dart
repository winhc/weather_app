import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather/bloc/favourite_weather/favourite_weather_bloc.dart';
import 'package:weather/bloc/location/location_bloc.dart';
import 'package:weather/bloc/weather/weather_bloc.dart';
import 'package:weather/presentation/views/weather_detail_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitUp,
    ]);
    return MultiBlocProvider(
        providers: [
          BlocProvider<WeatherBloc>(create: (context) => WeatherBloc()),
          BlocProvider<LocationBloc>(create: (context) => LocationBloc()),
          BlocProvider<FavouriteWeatherBloc>(
              create: (context) => FavouriteWeatherBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Weather',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const WeatherDetailView(),
        ));
  }
}
