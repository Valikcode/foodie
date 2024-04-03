import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie/blocs/main/main_bloc.dart';
import 'package:foodie/utils/utils.dart';

class Location extends StatelessWidget {
  const Location({
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
              return const Text(
                "Loading...",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              );
            } else if (snapshot.hasError) {
              return const Text(
                "Error loading location",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              );
            } else {
              return Text(
                snapshot.data!,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              );
            }
          },
        );
      },
    );
  }
}
