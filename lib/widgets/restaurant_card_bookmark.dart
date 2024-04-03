import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie/blocs/bookmark/bookmark_bloc.dart';
import 'package:foodie/models/restaurant_model.dart';

class RestaurantCardBookmarkIcon extends StatelessWidget {
  const RestaurantCardBookmarkIcon({
    super.key,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.categoryTitle,
    required this.categoryAlias,
    required this.location,
    required this.isOpen,
    required this.rating,
    required this.isBookmarked,
  });

  final String id;
  final String name;
  final String? imageUrl;
  final String categoryTitle;
  final String categoryAlias;
  final String location;
  final bool isOpen;
  final double rating;
  final bool isBookmarked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final restaurant = RestaurantModel(
          id: id,
          name: name,
          imageUrl: imageUrl ?? '',
          categoryTitle: categoryTitle,
          categoryAlias: categoryAlias,
          location: location,
          isOpen: isOpen,
          rating: rating,
          isBookmarked: !isBookmarked,
        );

        BlocProvider.of<BookmarkBloc>(context).add(
          ToggleBookmark(!isBookmarked, restaurant),
        );
      },
      child: Icon(
        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
        color: isBookmarked ? Colors.blue[400] : Colors.grey,
      ),
    );
  }
}
