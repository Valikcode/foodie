import 'package:flutter/material.dart';

class RestaurantCardCategories extends StatelessWidget {
  const RestaurantCardCategories({
    super.key,
    required this.categoryTitle,
  });

  final String categoryTitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      categoryTitle.length > 30
          ? '${categoryTitle.substring(0, 30)}...'
          : categoryTitle,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 12,
      ),
    );
  }
}
