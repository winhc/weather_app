part of 'location_bloc.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoadInprogress extends LocationState {}

class LocationLoadSuccess extends LocationState {
  final List<Location> locationList;
  LocationLoadSuccess({required this.locationList});
}

class LocationLoadFailure extends LocationState {
  final String error;
  LocationLoadFailure({required this.error});
}
