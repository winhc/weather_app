part of 'location_bloc.dart';

@immutable
abstract class LocationEvent {}

class LocationRequest extends LocationEvent {
  final String location;
  final BuildContext context;
  LocationRequest({required this.location, required this.context});
}

class LocationClear extends LocationEvent {
  LocationClear();
}
