import 'package:flutter/material.dart';

class RestaurantCardCategoryOpenStatus extends StatelessWidget {
  const RestaurantCardCategoryOpenStatus({
    super.key,
    required this.isOpen,
  });

  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    return Text(
      isOpen ? 'Open' : 'Closed',
      style: TextStyle(
        color: isOpen ? Colors.green : Colors.red,
        fontSize: 12,
      ),
    );
  }
}
