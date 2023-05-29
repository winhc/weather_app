import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/location/location_bloc.dart';
import 'package:weather/bloc/weather/weather_bloc.dart';
import 'package:weather/data/models/location_model.dart';
import 'package:weather/presentation/widgets/weather_loading.dart';

import '../widgets/empty_item.dart';

class WeatherSearchView extends SearchDelegate {
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    BlocProvider.of<LocationBloc>(context)
        .add(LocationRequest(location: query, context: context));
    return BlocBuilder<LocationBloc, LocationState>(builder: (context, state) {
      if (state is LocationLoadInprogress) {
        return const Center(child: WeatherLoading());
      } else if (state is LocationLoadSuccess &&
          state.locationList.isNotEmpty) {
        final List<Location> locationList = state.locationList;
        return ListView.builder(
            itemCount: locationList.length,
            itemBuilder: (context, index) {
              final Location location = locationList[index];
              return ListTile(
                onTap: () {
                  BlocProvider.of<WeatherBloc>(context).add(
                      WeatherForecastByLatLongRequest(
                          lat: location.lat!,
                          long: location.lon!,
                          forecastDayCount: 3,
                          context: context));
                  close(context, null);
                },
                title: Text(
                    "${location.name}, ${location.region} ${location.country}"),
              );
            });
      } else {
        return const Center(
            child: EmptyItem(
                icon: Icons.hourglass_empty_rounded,
                message: "Location not found!"));
      }
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      BlocProvider.of<LocationBloc>(context).add(LocationClear());
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Align(
          alignment: Alignment.topCenter,
          child: Text(
            query.isNotEmpty ? 'Tap Search to start searching.' : '',
            style: const TextStyle(color: Colors.black54, fontSize: 16),
          )),
    );

    // else if (query.length >= 3) {
    //   BlocProvider.of<LocationBloc>(context)
    //       .add(LocationRequest(location: query));
    // }
    // return BlocBuilder<LocationBloc, LocationState>(builder: (context, state) {
    //   if (state is LocationLoadSuccess && state.locationList.isNotEmpty) {
    //     final List<Location> locationList = state.locationList;
    //     return ListView.separated(
    //         separatorBuilder: (context, index) => const Divider(),
    //         itemCount: locationList.length,
    //         itemBuilder: (context, index) {
    //           final Location location = locationList[index];
    //           return ListTile(
    //             onTap: () {
    //               BlocProvider.of<WeatherBloc>(context)
    //                   .add(WeatherRequest(city: location.name!));
    //               close(context, null);
    //             },
    //             title: Text(
    //                 "${location.name}, ${location.region} ${location.country}"),
    //           );
    //         });
    //   } else {
    //     return const SizedBox.shrink();
    //   }
    // });
  }

  @override
  String get searchFieldLabel => 'Search weather';
}
