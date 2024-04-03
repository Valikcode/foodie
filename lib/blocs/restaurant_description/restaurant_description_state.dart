part of 'restaurant_description_bloc.dart';

enum RestaurantDescriptionStateEnum { init, loading, loaded, error }

@immutable
class RestaurantDescriptionState extends Equatable {
  final RestaurantDescriptionStateEnum state;
  final DetailedRestaurantModel restaurant;
  final String staticMapUrl;
  final List<ReviewModel> reviews;

  const RestaurantDescriptionState({
    this.state = RestaurantDescriptionStateEnum.init,
    this.staticMapUrl = '',
    this.restaurant = const DetailedRestaurantModel(
      id: '',
      name: '',
      imageUrl: '',
      categoryTitle: '',
      categoryAlias: '',
      location: '',
      isOpen: false,
      rating: 0.0,
      isBookmarked: false,
      latitude: 0,
      longitude: 0,
      website: '',
      phoneNumber: '',
      photos: [],
      priceRange: '',
      openingHours: [],
      specialHours: [],
    ),
    this.reviews = const [],
  });

  RestaurantDescriptionState copyWith({
    RestaurantDescriptionStateEnum? state,
    DetailedRestaurantModel? restaurant,
    String? staticMapUrl,
    List<ReviewModel>? reviews,
  }) =>
      RestaurantDescriptionState(
          state: state ?? this.state,
          restaurant: restaurant ?? this.restaurant,
          staticMapUrl: staticMapUrl ?? this.staticMapUrl,
          reviews: reviews ?? this.reviews);

  @override
  List<Object> get props => [state, restaurant, staticMapUrl, reviews];
}
