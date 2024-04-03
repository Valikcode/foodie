import 'package:flutter/material.dart';

class RestaurantCardFavoriteTitle extends StatelessWidget {
  const RestaurantCardFavoriteTitle({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name.length > 14 ? '${name.substring(0, 14)}...' : name,
      style: const TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 20,
      ),
    );
  }
}
