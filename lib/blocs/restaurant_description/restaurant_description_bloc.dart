import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:foodie/models/detailed_restaurant_model.dart';
import 'package:foodie/models/restaurant_model.dart';
import 'package:foodie/models/review_model.dart';
import 'package:foodie/repositories/restaurant_repository.dart';
import 'package:hive/hive.dart';

part 'restaurant_description_event.dart';
part 'restaurant_description_state.dart';

class RestaurantDescriptionBloc
    extends Bloc<RestaurantDescriptionEvent, RestaurantDescriptionState> {
  static const String googleMapsApiKey =
      "AIzaSyAZwlUw6clHQdff3ZTmzt_ulvEIh77zQVk";

  static const String staticMapBaseUrl =
      "https://maps.googleapis.com/maps/api/staticmap";

  static const String markerColor = "blue";

  RestaurantDescriptionBloc() : super(const RestaurantDescriptionState()) {
    on<RestaurantDescriptionEvent>((event, emit) {});

    on<FetchRestaurantDetails>((event, emit) async {
      emit(state.copyWith(state: RestaurantDescriptionStateEnum.loading));

      if (!Hive.isBoxOpen('bookmarked_restaurants')) {
        await Hive.openBox<RestaurantModel>('bookmarked_restaurants');
      }

      DetailedRestaurantModel? restaurant =
          await RestaurantRepository.fetchRestaurantDetails(event.restaurantId);
      debugPrint("Restaurant Details: $restaurant");
      if (restaurant != null) {
        double adjustedLongitude = restaurant.longitude - 0.01;
        String staticMapUrl = "$staticMapBaseUrl"
            "?center=${restaurant.latitude},$adjustedLongitude"
            "&zoom=14"
            "&size=400x200"
            "&markers=color:$markerColor%7C${restaurant.latitude},${restaurant.longitude}"
            "&key=$googleMapsApiKey";

        List<ReviewModel> reviews =
            await RestaurantRepository.fetchRestaurantReviews(restaurant.id);

        emit(
          state.copyWith(
            state: RestaurantDescriptionStateEnum.loaded,
            restaurant: restaurant,
            staticMapUrl: staticMapUrl,
            reviews: reviews,
          ),
        );
      }
    });
  }
}
