import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie/blocs/bookmark/bookmark_bloc.dart';
import 'package:foodie/models/detailed_restaurant_model.dart';
import 'package:share_plus/share_plus.dart';

class DetailedRestaurantScreenActions extends StatelessWidget {
  final DetailedRestaurantModel restaurant;

  const DetailedRestaurantScreenActions({
    required this.restaurant,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0, right: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () async {
              debugPrint('Share restaurant id: ${restaurant.id}');
              final restaurantLink = 'foodie://restaurant/${restaurant.id}';
              await Share.share(restaurantLink);
            },
            child: const Column(
              children: [
                Icon(
                  Icons.ios_share,
                  size: 30,
                ),
                Text(
                  "Share",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          BlocBuilder<BookmarkBloc, BookmarkState>(
            builder: (context, bookmarkState) {
              var isBookmarked = bookmarkState.bookmarkedRestaurants.any(
                  (bookmarkedRestaurant) =>
                      bookmarkedRestaurant.id == restaurant.id);
              return GestureDetector(
                onTap: () {
                  final updatedRestaurant = DetailedRestaurantModel(
                    id: restaurant.id,
                    name: restaurant.name,
                    imageUrl: restaurant.imageUrl,
                    categoryTitle: restaurant.categoryTitle,
                    categoryAlias: restaurant.categoryAlias,
                    location: restaurant.location,
                    isOpen: restaurant.isOpen,
                    rating: restaurant.rating,
                    isBookmarked: !isBookmarked,
                    latitude: restaurant.latitude,
                    longitude: restaurant.longitude,
                    website: restaurant.website,
                    phoneNumber: restaurant.phoneNumber,
                    photos: restaurant.photos,
                    priceRange: restaurant.priceRange,
                    openingHours: restaurant.openingHours,
                    specialHours: restaurant.specialHours,
                  );

                  BlocProvider.of<BookmarkBloc>(context).add(
                    ToggleBookmark(
                        updatedRestaurant.isBookmarked, updatedRestaurant),
                  );
                },
                child: Column(
                  children: [
                    Icon(
                      isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_add_outlined,
                      color: isBookmarked ? Colors.blue[400] : Colors.black,
                      size: 30,
                    ),
                    const Text(
                      "Bookmark",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              );
            },
          ),
          const Column(
            children: [
              Icon(
                Icons.language,
                size: 30,
              ),
              Text(
                "Website",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
