import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie/blocs/main/main_bloc.dart';
import 'package:foodie/utils/utils.dart';
import 'package:foodie/values/colors.dart';

class LocationName extends StatelessWidget {
  const LocationName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return FutureBuilder<String>(
          future: Utils.getLocationName(state.phoneLocation),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Color(AppColors.primaryColor),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Loading...',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Color(AppColors.primaryColor),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Unknown Location',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Color(AppColors.primaryColor),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      snapshot.data!,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            }
          },
        );
      },
    );
  }
}
