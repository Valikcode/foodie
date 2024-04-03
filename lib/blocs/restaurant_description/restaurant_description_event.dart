part of 'restaurant_description_bloc.dart';

@immutable
abstract class RestaurantDescriptionEvent extends Equatable {
  const RestaurantDescriptionEvent();
}

class FetchRestaurantDetails extends RestaurantDescriptionEvent {
  final String restaurantId;

  const FetchRestaurantDetails(this.restaurantId);

  @override
  List<Object?> get props => [restaurantId];
}

class FetchNextPageRestaurantReviews extends RestaurantDescriptionEvent {
  final String restaurantId;

  const FetchNextPageRestaurantReviews(this.restaurantId);

  @override
  List<Object?> get props => [restaurantId];
}
