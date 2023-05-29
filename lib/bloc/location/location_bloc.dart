import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:weather/data/repositories/location/location_repository.dart';
import 'package:weather/data/repositories/location/location_repository_impl.dart';

import '../../data/models/location_model.dart';
import '../../utils/network_util.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository _locationRepository = LocationRepositoryImpl();
  LocationBloc() : super(LocationInitial()) {
    on<LocationEvent>((event, emit) async {
      if (event is LocationRequest) {
        bool isNetworkAvailable =
            await NetworkUtil().isNetworkAvailable(event.context);
        if (isNetworkAvailable) {
          emit.call(LocationLoadInprogress());

          try {
            final locationResponse =
                await _locationRepository.getLocationList(event.location);
            emit.call(LocationLoadSuccess(locationList: locationResponse));
          } catch (e) {
            debugPrint("error => $e");
            emit.call(LocationLoadFailure(error: e.toString()));
          }
        }
      } else if (event is LocationClear) {
        emit.call(LocationLoadSuccess(locationList: const []));
      }
    });
  }
}
