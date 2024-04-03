import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foodie/models/restaurant_model.dart';
import 'package:hive/hive.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  late Box<RestaurantModel> _bookmarkedRestaurantsBox;

  BookmarkBloc() : super(const BookmarkState()) {
    on<BookmarkEvent>((event, emit) {});

    on<ToggleBookmark>((event, emit) {
      final bookmarkedRestaurantsBox =
          Hive.box<RestaurantModel>('bookmarked_restaurants');

      if (event.isBookmarked) {
        bookmarkedRestaurantsBox.add(event.restaurant);
      } else {
        final indexToDelete = bookmarkedRestaurantsBox.values
            .toList()
            .indexWhere((restaurant) => restaurant.id == event.restaurant.id);
        if (indexToDelete != -1) {
          bookmarkedRestaurantsBox.deleteAt(indexToDelete);
        }
      }

      final bookmarkedRestaurants = bookmarkedRestaurantsBox.values.toList();
      emit(
        state.copyWith(bookmarkedRestaurants: bookmarkedRestaurants),
      );
    });

    on<InitBookmarkStatus>((event, emit) async {
      _bookmarkedRestaurantsBox =
          await Hive.openBox<RestaurantModel>('bookmarked_restaurants');

      final bookmarkedRestaurants = _bookmarkedRestaurantsBox.values.toList();
      emit(state.copyWith(bookmarkedRestaurants: bookmarkedRestaurants));
    });
  }

  @override
  Future<void> close() async {
    await _bookmarkedRestaurantsBox.close();
    super.close();
  }
}
