import 'package:flutter/material.dart';

class RestaurantCardLocation extends StatelessWidget {
  const RestaurantCardLocation({
    super.key,
    required this.location,
  });

  final String location;

  @override
  Widget build(BuildContext context) {
    return Text(
      location,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 12,
      ),
    );
  }
}
