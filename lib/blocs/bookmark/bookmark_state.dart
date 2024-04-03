part of 'bookmark_bloc.dart';

class BookmarkState extends Equatable {
  final List<RestaurantModel> bookmarkedRestaurants;
  const BookmarkState({
    this.bookmarkedRestaurants = const [],
  });

  BookmarkState copyWith({
    List<RestaurantModel>? bookmarkedRestaurants,
  }) =>
      BookmarkState(
        bookmarkedRestaurants:
            bookmarkedRestaurants ?? this.bookmarkedRestaurants,
      );

  @override
  List<Object> get props => [bookmarkedRestaurants];
}
