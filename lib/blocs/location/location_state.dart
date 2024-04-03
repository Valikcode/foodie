part of 'location_bloc.dart';

enum LocationStateEnum { init, loading, loaded, error }

@immutable
class LocationState extends Equatable {
  final LocationStateEnum state;
  final List<DetailedRestaurantModel> restaurants;
  final List<MarkerData> customMarkers;

  const LocationState({
    this.state = LocationStateEnum.init,
    this.restaurants = const [],
    this.customMarkers = const [],
  });

  LocationState copyWith({
    LocationStateEnum? state,
    List<DetailedRestaurantModel>? restaurants,
    List<MarkerData>? customMarkers,
  }) =>
      LocationState(
        state: state ?? this.state,
        restaurants: restaurants ?? this.restaurants,
        customMarkers: customMarkers ?? this.customMarkers,
      );

  @override
  List<Object> get props => [state, restaurants, customMarkers];
}
