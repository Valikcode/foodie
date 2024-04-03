part of 'bookmark_bloc.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();
}

class ToggleBookmark extends BookmarkEvent {
  final bool isBookmarked;
  final RestaurantModel restaurant;

  const ToggleBookmark(this.isBookmarked, this.restaurant);

  @override
  List<Object?> get props => [isBookmarked];
}

class InitBookmarkStatus extends BookmarkEvent {
  @override
  List<Object?> get props => [];
}

class InitBookmarks extends BookmarkEvent {
  @override
  List<Object?> get props => [];
}
