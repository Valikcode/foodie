part of 'location_permission_bloc.dart';

@immutable
abstract class LocationPermissionEvent extends Equatable {
  const LocationPermissionEvent();
}

class CheckPermissionEvent extends LocationPermissionEvent {
  @override
  List<Object> get props => [];
}

class RequestPermissionEvent extends LocationPermissionEvent {
  @override
  List<Object> get props => [];
}
