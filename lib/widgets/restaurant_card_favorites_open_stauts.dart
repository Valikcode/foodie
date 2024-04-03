import 'package:flutter/material.dart';

class RestaurantCardFavoritesOpenStatus extends StatelessWidget {
  const RestaurantCardFavoritesOpenStatus({
    super.key,
    required this.isOpen,
  });

  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(
        isOpen ? 'Open' : 'Closed',
        style: TextStyle(
          color: isOpen ? Colors.green : Colors.red,
          fontSize: 12,
        ),
      ),
    );
  }
}
