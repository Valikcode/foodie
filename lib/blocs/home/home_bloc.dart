import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:foodie/models/restaurant_model.dart';
import 'package:foodie/repositories/restaurant_repository.dart';
import 'package:foodie/utils/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late String location;

  HomeBloc() : super(const HomeState()) {
    on<HomeEvent>((event, emit) {});

    on<InitHomePage>((event, emit) async {
      emit(state.copyWith(state: HomeStateEnum.loading));
      await storePhoneLocation();
      location = await Utils.getLocationName(state.phoneLocation);
      await _loadHotAndNewRestaurants();
      await _loadMostPopularRestaurants();
      await _loadDealsRestaurants();
      await _loadTakeoutRestaurants();
      await _loadDeliveryRestaurants();
      await _loadCategories();

      emit(state.copyWith(state: HomeStateEnum.loaded));
    });

    on<SwipeHotAndNew>((event, emit) {
      emit(state.copyWith(hotAndNewIndex: event.newIndex));
    });
  }

  Future<void> storePhoneLocation() async {
    final Location location = Location();
    try {
      final LocationData locationData = await location.getLocation();

      emit(
        state.copyWith(
          phoneLocation:
              LatLng(locationData.latitude!, locationData.longitude!),
        ),
      );
    } catch (e) {
      debugPrint('Error fetching location: $e');
    }
  }

  Future<void> _loadHotAndNewRestaurants() async {
    final hotAndNewRestaurants =
        await RestaurantRepository.fetchHotAndNewRestaurants(location);

    emit(
      state.copyWith(
        hotAndNewIndex: 0,
        hotAndNewRestaurants: hotAndNewRestaurants,
      ),
    );
  }

  Future<void> _loadMostPopularRestaurants() async {
    final mostPopularRestaurants =
        await RestaurantRepository.fetchMostPopularRestaurants(location);

    emit(
      state.copyWith(
        mostPopularRestaurants: mostPopularRestaurants.take(5).toList(),
      ),
    );
  }

  Future<void> _loadDealsRestaurants() async {
    final dealsRestaurants =
        await RestaurantRepository.fetchDealsRestaurants(location);

    emit(
      state.copyWith(
        dealsRestaurants: dealsRestaurants.take(5).toList(),
      ),
    );
  }

  Future<void> _loadTakeoutRestaurants() async {
    final takeoutRestaurants =
        await RestaurantRepository.fetchTakeoutRestaurants(location);

    emit(
      state.copyWith(
        takeoutRestaurants: takeoutRestaurants,
      ),
    );
  }

  Future<void> _loadDeliveryRestaurants() async {
    final deliveryRestaurants =
        await RestaurantRepository.fetchDeliveryRestaurants(location);

    emit(
      state.copyWith(
        deliveryRestaurants: deliveryRestaurants,
      ),
    );
  }

  Future<void> _loadCategories() async {
    final categoriesMap = await RestaurantRepository.fetchCategoryes();

    emit(
      state.copyWith(
        categoriesMap: categoriesMap,
      ),
    );
    debugPrint("Filtered categories: ${categoriesMap.keys.toList()}");
  }
}
