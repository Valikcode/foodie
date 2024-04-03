import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

part 'location_permission_event.dart';
part 'location_permission_state.dart';

class LocationPermissionBloc
    extends Bloc<LocationPermissionEvent, LocationPermissionState> {
  LocationPermissionBloc() : super(const LocationPermissionState()) {
    on<LocationPermissionEvent>((event, emit) {});

    on<CheckPermissionEvent>((event, emit) {
      checkPermissionStatus();
    });

    on<RequestPermissionEvent>((event, emit) {
      requestPermission();
    });
  }

  Future<void> checkPermissionStatus() async {
    final status = await Permission.locationWhenInUse.status;

    if (status.isGranted) {
      // Location permission is granted
      emit(const LocationPermissionState(
        state: LocationPermissionStateEnum.granted,
      ));
    } else {
      // Location permission is not granted
      emit(const LocationPermissionState(
        state: LocationPermissionStateEnum.notGranted,
      ));
    }
  }

  Future<void> requestPermission() async {
    final request = await Permission.locationWhenInUse.request();

    if (request.isGranted) {
      // Location permission is granted
      emit(const LocationPermissionState(
        state: LocationPermissionStateEnum.granted,
      ));
    } else {
      // Location permission is not granted
      emit(const LocationPermissionState(
        state: LocationPermissionStateEnum.notGranted,
      ));
    }
  }
}
