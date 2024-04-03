part of 'location_permission_bloc.dart';

enum LocationPermissionStateEnum { granted, notGranted }

@immutable
class LocationPermissionState extends Equatable {
  final LocationPermissionStateEnum state;

  const LocationPermissionState(
      {this.state = LocationPermissionStateEnum.notGranted});

  LocationPermissionState copyWith({
    LocationPermissionStateEnum? state,
  }) =>
      LocationPermissionState(
        state: state ?? this.state,
      );

  @override
  List<Object> get props => [state];
}
