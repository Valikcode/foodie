import 'package:flutter/material.dart';

class RestaurantCardCategoryTitle extends StatelessWidget {
  const RestaurantCardCategoryTitle({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 20,
      ),
    );
  }
}
