import 'package:flutter/material.dart';
import 'package:foodie/models/detailed_restaurant_model.dart';
import 'package:foodie/screens/main/detailed_restaurant_screen.dart';
import 'package:foodie/widgets/restaurant_card_rating.dart';

class LocationsBottomSheet extends StatelessWidget {
  final DetailedRestaurantModel restaurant;

  const LocationsBottomSheet({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _openDetailedRestaurantScreen(context);
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(restaurant.imageUrl),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name.length > 14
                              ? '${restaurant.name.substring(0, 14)}...'
                              : restaurant.name,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          restaurant.openingHours.isNotEmpty
                              ? '${restaurant.openingHours.first.startTime} - ${restaurant.openingHours.first.endTime}'
                              : 'Not provided',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          restaurant.location.length > 24
                              ? '${restaurant.location.substring(0, 24)}...'
                              : '${restaurant.location} , New York',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          restaurant.categoryTitle.length > 30
                              ? '${restaurant.categoryTitle.substring(0, 30)}...'
                              : restaurant.categoryTitle,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  RestaurantCardRating(rating: restaurant.rating)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openDetailedRestaurantScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailedRestaurantScreen(id: restaurant.id),
      ),
    );
  }
}
