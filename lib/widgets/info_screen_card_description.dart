import 'package:flutter/material.dart';
import 'package:foodie/values/strings.dart';

class InfoCardDescription extends StatelessWidget {
  const InfoCardDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        AppStrings.cardDescription,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
