import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:foodie/models/restaurant_model.dart';
import 'package:foodie/repositories/restaurant_repository.dart';
import 'package:foodie/values/api_constants.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  String location;
  CategoryBloc(this.location) : super(const CategoryState()) {
    on<CategoryEvent>((event, emit) {});

    on<InitCategoryPage>((event, emit) async {
      emit(state.copyWith(state: CategoryStateEnum.init));

      await _loadCategoryPage(event.selectedCategoryAlias);

      emit(state.copyWith(state: CategoryStateEnum.loaded));
    });

    on<InitAttributePage>((event, emit) async {
      emit(state.copyWith(state: CategoryStateEnum.init));

      await _loadAttributePage(event.selectedAttributeAlias);

      emit(state.copyWith(state: CategoryStateEnum.loaded));
    });

    on<FetchNewPage>((event, emit) async {
      emit(state.copyWith(state: CategoryStateEnum.loading));

      await _loadCategoryPage(event.selectedCategoryAlias,
          nextPage: state.currentPage + 1);

      emit(state.copyWith(state: CategoryStateEnum.loaded));
    });

    on<FetchNewAttributePage>((event, emit) async {
      emit(state.copyWith(state: CategoryStateEnum.loading));

      await _loadAttributePage(event.selectedAttributeAlias,
          nextPage: state.currentPage + 1);

      emit(state.copyWith(state: CategoryStateEnum.loaded));
    });
  }

  Future<void> _loadCategoryPage(String selectedCategoryAlias,
      {int nextPage = 0}) async {
    final restaurants =
        await RestaurantRepository.fetchRestaurantsByPageAndCategory(
            location, nextPage, selectedCategoryAlias);

    final newRestaurantList = state.restaurantList + restaurants;
    if (restaurants.length < ApiConstants.fetchLimit) {
      emit(
        state.copyWith(noMoreRestaurants: true),
      );
    }

    emit(
      state.copyWith(
        restaurantList: newRestaurantList,
        currentPage: nextPage,
      ),
    );
  }

  Future<void> _loadAttributePage(String attribute, {int nextPage = 0}) async {
    late final List<RestaurantModel> restaurants;
    if (attribute == 'rating') {
      restaurants = await RestaurantRepository.fetchMostPopularRestaurants(
          location,
          page: nextPage);
    } else if (attribute == 'best_match') {
      restaurants = await RestaurantRepository.fetchDealsRestaurants(location,
          page: nextPage);
    } else if (attribute == 'takeout') {
      restaurants = await RestaurantRepository.fetchTakeoutRestaurants(location,
          page: nextPage);
    } else if (attribute == 'delivery') {
      restaurants = await RestaurantRepository.fetchDeliveryRestaurants(
          location,
          page: nextPage);
    }

    final newRestaurantList = state.restaurantList + restaurants;
    if (restaurants.length < ApiConstants.fetchLimit) {
      emit(
        state.copyWith(noMoreRestaurants: true),
      );
    }

    emit(
      state.copyWith(
        restaurantList: newRestaurantList,
        currentPage: nextPage,
      ),
    );
  }
}
