import 'package:flutter/material.dart';
import 'package:foodie/values/colors.dart';
import 'package:foodie/values/images.dart';

class LocationsScreenMarker extends StatelessWidget {
  final String imageUrl;

  const LocationsScreenMarker({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            image: imageUrl != ''
                ? DecorationImage(
                    image: NetworkImage(imageUrl), fit: BoxFit.cover)
                : const DecorationImage(
                    image: AssetImage(AppImages.noRestaurantPhoto),
                    fit: BoxFit.cover),
            border: Border.all(color: Color(AppColors.primaryColor), width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        Transform.translate(
          offset: Offset(0, -25),
          child: Icon(
            Icons.arrow_drop_down,
            color: Color(AppColors.primaryColor),
            size: 60,
          ),
        ),
      ],
    );
  }
}
