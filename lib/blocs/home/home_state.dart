part of 'home_bloc.dart';

enum HomeStateEnum { init, loading, loaded, error }

enum SearchStateEnum { init, loading, loaded, error }

@immutable
class HomeState extends Equatable {
  final HomeStateEnum state;

  final LatLng phoneLocation;

  final int hotAndNewIndex;

  final List<RestaurantModel> hotAndNewRestaurants;
  final List<RestaurantModel> mostPopularRestaurants;
  final List<RestaurantModel> dealsRestaurants;
  final List<RestaurantModel> takeoutRestaurants;
  final List<RestaurantModel> deliveryRestaurants;

  final SearchStateEnum searchState;
  final Map<String, String>? categoriesMap;
  final bool categoriesInit;
  final List<String> searchedCategories;
  final List<String> searchedRestaurants;

  const HomeState({
    this.state = HomeStateEnum.init,
    this.phoneLocation = const LatLng(0, 0),
    this.hotAndNewIndex = 0,
    this.hotAndNewRestaurants = const [],
    this.mostPopularRestaurants = const [],
    this.dealsRestaurants = const [],
    this.takeoutRestaurants = const [],
    this.deliveryRestaurants = const [],
    this.searchState = SearchStateEnum.init,
    this.categoriesMap = const {},
    this.categoriesInit = false,
    this.searchedCategories = const [],
    this.searchedRestaurants = const [],
  });

  HomeState copyWith({
    HomeStateEnum? state,
    LatLng? phoneLocation,
    int? hotAndNewIndex,
    List<RestaurantModel>? hotAndNewRestaurants,
    List<RestaurantModel>? mostPopularRestaurants,
    List<RestaurantModel>? dealsRestaurants,
    List<RestaurantModel>? takeoutRestaurants,
    List<RestaurantModel>? deliveryRestaurants,
    SearchStateEnum? searchState,
    Map<String, String>? categoriesMap,
    bool? categoriesInit,
    List<String>? searchedCategories,
    List<String>? searchedRestaurants,
  }) =>
      HomeState(
        state: state ?? this.state,
        phoneLocation: phoneLocation ?? this.phoneLocation,
        hotAndNewIndex: hotAndNewIndex ?? this.hotAndNewIndex,
        hotAndNewRestaurants: hotAndNewRestaurants ?? this.hotAndNewRestaurants,
        mostPopularRestaurants:
            mostPopularRestaurants ?? this.mostPopularRestaurants,
        dealsRestaurants: dealsRestaurants ?? this.dealsRestaurants,
        takeoutRestaurants: takeoutRestaurants ?? this.takeoutRestaurants,
        deliveryRestaurants: deliveryRestaurants ?? this.deliveryRestaurants,
        searchState: searchState ?? this.searchState,
        categoriesMap: categoriesMap ?? this.categoriesMap,
        categoriesInit: categoriesInit ?? this.categoriesInit,
        searchedCategories: searchedCategories ?? this.searchedCategories,
        searchedRestaurants: searchedRestaurants ?? this.searchedRestaurants,
      );

  @override
  List<Object> get props => [
        state,
        phoneLocation,
        hotAndNewIndex,
        hotAndNewRestaurants,
        mostPopularRestaurants,
        dealsRestaurants,
        takeoutRestaurants,
        deliveryRestaurants,
        searchState,
        categoriesMap!.keys,
        categoriesInit,
        searchedCategories,
        searchedRestaurants,
      ];
}
