import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:foodie/utils/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainState()) {
    on<MainEvent>((event, emit) {});

    on<InitMain>((event, emit) {
      emit(state.copyWith(state: MainStateEnum.loading));
      emit(state.copyWith(pageIndex: 0));
      emit(state.copyWith(state: MainStateEnum.loaded));
    });

    on<GetLocation>((event, emit) async {
      emit(state.copyWith(state: MainStateEnum.loading));
      await storePhoneLocation();
      debugPrint('Latitude : ${state.phoneLocation.latitude.toString()}');
      debugPrint('Longitude : ${state.phoneLocation.longitude.toString()}');
    });

    on<ChangePage>((event, emit) {
      emit(state.copyWith(pageIndex: event.newPageIndex));
    });
  }

  Future<void> storePhoneLocation() async {
    final Location location = Location();
    try {
      final LocationData locationData = await location.getLocation();
      String locationString = await Utils.getLocationName(
        LatLng(locationData.latitude!, locationData.longitude!),
      );

      emit(
        state.copyWith(
          state: MainStateEnum.loaded,
          phoneLocation:
              LatLng(locationData.latitude!, locationData.longitude!),
          phoneLocationString: locationString,
        ),
      );
    } catch (e) {
      debugPrint('Error fetching location: $e');
    }
  }
}
