import 'package:flutter/material.dart';

class CategoryTitle extends StatelessWidget {
  final String? categoryName;
  final String? attributeName;

  const CategoryTitle({
    super.key,
    this.categoryName,
    this.attributeName,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              categoryName ?? attributeName!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "Restaurants",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
