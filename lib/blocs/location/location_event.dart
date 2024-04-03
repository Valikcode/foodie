part of 'location_bloc.dart';

@immutable
abstract class LocationEvent extends Equatable {
  const LocationEvent();
}

class InitLocation extends LocationEvent {
  final LatLng newCameraPosition;

  const InitLocation({required this.newCameraPosition});

  @override
  List<Object?> get props => [newCameraPosition];
}

class FetchLocations extends LocationEvent {
  final LatLng newCameraPosition;

  const FetchLocations({required this.newCameraPosition});

  @override
  List<Object?> get props => [newCameraPosition];
}
