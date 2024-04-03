import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie/blocs/location_permission/location_permission_bloc.dart';
import 'package:foodie/values/colors.dart';
import 'package:foodie/values/strings.dart';

class LocationPermissionButton extends StatelessWidget {
  const LocationPermissionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ], borderRadius: BorderRadius.circular(8)),
          child: ElevatedButton(
            onPressed: () {
              BlocProvider.of<LocationPermissionBloc>(context)
                  .add(RequestPermissionEvent());
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Color(AppColors.primaryColor)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            child: Text(
              AppStrings.userLocation,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
