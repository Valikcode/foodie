import 'package:flutter/material.dart';
import 'package:foodie/models/restaurant_model.dart';
import 'package:foodie/screens/main/detailed_restaurant_screen.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantModel restaurant;

  const RestaurantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    String title = restaurant.name;
    String category = restaurant.categoryTitle;
    String location = restaurant.location;

    if (title.length > 12) {
      title = "${title.substring(0, 12)}...";
    }

    if (category.length > 24) {
      category = "${category.substring(0, 24)}...";
    }

    if (location.length > 18) {
      location = "${location.substring(0, 18)}...";
    }

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailedRestaurantScreen(id: restaurant.id),
          ),
        );
      },
      child: Container(
        width: 150,
        height: 170,
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Part - Placeholder Photo
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: Image.network(
                restaurant.imageUrl,
                width: double.infinity,
                height: 2 / 3 * 150,
                fit: BoxFit.cover,
              ),
            ),
            // Bottom Part - Title and 2 subtitles
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    location,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    category,
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
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
