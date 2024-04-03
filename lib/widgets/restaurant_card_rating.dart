import 'package:flutter/material.dart';

class RestaurantCardRating extends StatelessWidget {
  const RestaurantCardRating({
    super.key,
    required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    String text;
    Color backgroundColor;

    if (rating >= 4.5) {
      text = rating.toString();
      backgroundColor = const Color(0xFFFFD700);
    } else if (rating >= 4.0) {
      text = rating.toString();
      backgroundColor = Colors.green[500]!;
    } else if (rating >= 3.5) {
      text = rating.toString();
      backgroundColor = Colors.green[200]!;
    } else if (rating >= 3.0) {
      text = rating.toString();
      backgroundColor = Colors.red[300]!;
    } else if (rating >= 2.5) {
      text = rating.toString();
      backgroundColor = Colors.red[800]!;
    } else {
      text = rating.toString();
      backgroundColor = Colors.brown[400]!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
