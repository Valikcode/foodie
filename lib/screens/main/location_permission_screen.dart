import 'package:flutter/material.dart';
import 'package:foodie/widgets/location_screen_permission_button.dart';

class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Hi, nice to meet you!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: Text(
              'Set your location to start exploring restaurants around you',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 64,
          ),
          LocationPermissionButton(),
        ],
      ),
    );
  }
}
