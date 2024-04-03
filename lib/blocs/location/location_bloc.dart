import 'package:bloc/bloc.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:foodie/models/detailed_restaurant_model.dart';
import 'package:foodie/repositories/restaurant_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LatLng? currentCameraLatLng;

  LocationBloc() : super(const LocationState()) {
    on<LocationEvent>((event, emit) {});

    on<InitLocation>((event, emit) async {
      emit(
        state.copyWith(state: LocationStateEnum.loading),
      );

      currentCameraLatLng = event.newCameraPosition;

      final List<DetailedRestaurantModel> restaurants =
          await RestaurantRepository.fetchRestaurantsWithinRadius(
              currentCameraLatLng!);

      if (restaurants.isNotEmpty) {
        emit(
          state.copyWith(
            state: LocationStateEnum.loaded,
            restaurants: restaurants,
          ),
        );
      }
    });

    on<FetchLocations>((event, emit) async {
      emit(
        state.copyWith(state: LocationStateEnum.loading),
      );

      currentCameraLatLng = event.newCameraPosition;
      debugPrint(currentCameraLatLng.toString());
      final List<DetailedRestaurantModel> newRestaurants =
          await RestaurantRepository.fetchRestaurantsWithinRadius(
              currentCameraLatLng!);
      final updatedRestaurants = state.restaurants + newRestaurants;
      emit(
        state.copyWith(
          state: LocationStateEnum.loaded,
          restaurants: updatedRestaurants,
        ),
      );
    });
  }
}
