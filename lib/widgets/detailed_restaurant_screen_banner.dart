import 'package:flutter/material.dart';
import 'package:foodie/values/colors.dart';

class DetailedRestaurantScreenBanner extends StatelessWidget {
  const DetailedRestaurantScreenBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Color(AppColors.primaryColor),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: const Center(
        child: Text(
          "Order Food Online",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
