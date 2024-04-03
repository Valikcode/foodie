import 'package:flutter/material.dart';

class Name extends StatelessWidget {
  final String name;

  const Name({
    required this.name,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
