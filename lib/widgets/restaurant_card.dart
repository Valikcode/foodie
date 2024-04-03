import 'package:flutter/material.dart';

import 'package:foodie/screens/main/detailed_restaurant_screen.dart';
import 'package:foodie/widgets/restaurant_card_bookmark.dart';
import 'package:foodie/widgets/restaurant_card_categories.dart';
import 'package:foodie/widgets/restaurant_card_category_open_status.dart';
import 'package:foodie/widgets/restaurant_card_category_title.dart';
import 'package:foodie/widgets/restaurant_card_favorites_open_stauts.dart';
import 'package:foodie/widgets/restaurant_card_favorites_title.dart';
import 'package:foodie/widgets/restaurant_card_location.dart';
import 'package:foodie/widgets/restaurant_card_rating.dart';

class RestaurantCard extends StatelessWidget {
  final bool isOpen;
  final String id;
  final String name;
  final String location;
  final double rating;
  String categoryTitle;
  String categoryAlias;
  bool isBookmarked;
  final String? imageUrl;
  final bool typeFavorite;

  RestaurantCard({
    super.key,
    required this.id,
    required this.isOpen,
    required this.name,
    required this.location,
    required this.rating,
    required this.categoryTitle,
    required this.categoryAlias,
    required this.isBookmarked,
    required this.imageUrl,
    required this.typeFavorite,
  });

  @override
  Widget build(BuildContext context) {
    if (categoryTitle.length > 40) {
      categoryTitle = "${categoryTitle.substring(0, 40)}...";
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailedRestaurantScreen(id: id)),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (typeFavorite == true)
              Container(
                margin: const EdgeInsets.only(right: 16),
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(imageUrl!), fit: BoxFit.cover),
                ),
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (typeFavorite == true)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RestaurantCardFavoriteTitle(name: name),
                          RestaurantCardRating(rating: rating),
                        ],
                      ),
                    ),
                  if (typeFavorite == true)
                    RestaurantCardFavoritesOpenStatus(isOpen: isOpen),
                  if (typeFavorite == false)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RestaurantCardCategoryOpenStatus(isOpen: isOpen),
                        RestaurantCardRating(rating: rating),
                      ],
                    ),
                  if (typeFavorite == false)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                      child: RestaurantCardCategoryTitle(name: name),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RestaurantCardLocation(location: location),
                          RestaurantCardCategories(
                              categoryTitle: categoryTitle),
                        ],
                      ),
                      RestaurantCardBookmarkIcon(
                          id: id,
                          name: name,
                          imageUrl: imageUrl,
                          categoryTitle: categoryTitle,
                          categoryAlias: categoryAlias,
                          location: location,
                          isOpen: isOpen,
                          rating: rating,
                          isBookmarked: isBookmarked),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
