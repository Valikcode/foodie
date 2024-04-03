import 'package:flutter/material.dart';

class DetailedRestaurantScreenImageAndTitle extends StatelessWidget {
  final String imageUrl;
  final String name;
  const DetailedRestaurantScreenImageAndTitle({
    super.key,
    required this.imageUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
          Container(
            height: 250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black.withOpacity(0.3), Colors.transparent],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
