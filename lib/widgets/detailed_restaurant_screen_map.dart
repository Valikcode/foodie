import 'package:flutter/material.dart';
import 'package:foodie/models/opening_hours_model.dart';
import 'package:foodie/utils/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailedRestaurantScreenMap extends StatelessWidget {
  final String location;
  final LatLng locationLatLng;
  final String staticMapUrl;
  final String categoryTitle;
  final bool isOpen;
  final List<OpeningHoursModel> openingHours;

  const DetailedRestaurantScreenMap({
    Key? key,
    required this.staticMapUrl,
    required this.location,
    required this.locationLatLng,
    required this.categoryTitle,
    required this.isOpen,
    required this.openingHours,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 100,
          width: double.infinity,
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color.fromARGB(0, 154, 80, 80), Colors.black],
                stops: [0.3, 0.6],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(2, 2),
                  blurRadius: 3,
                ),
              ]),
              child: Image.network(
                staticMapUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          left: 16,
          top: 0,
          bottom: 0,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<String>(
                  future: Utils.getLocationName(locationLatLng),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text(
                        "Loading...",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Text(
                        "Error loading location",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    } else {
                      return Text(
                        '$location , ${snapshot.data}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }
                  },
                ),
                Text(
                  categoryTitle.length > 25
                      ? '${categoryTitle.substring(0, 25)}...'
                      : categoryTitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  openingHours.isNotEmpty
                      ? '${openingHours.first.startTime} - ${openingHours.first.endTime}'
                      : 'Not provided',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
