import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Utils {
  static Future<String> getLocationName(LatLng latLng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );

      if (placemarks.isEmpty) {
        return "Unknown Location";
      }

      Placemark placemark = placemarks[0];
      String locationName =
          placemark.locality ?? placemark.name ?? "Unknown Location";
      return locationName;
    } catch (e) {
      debugPrint("Error getting location name: $e");
      return "Error getting location";
    }
  }
}
