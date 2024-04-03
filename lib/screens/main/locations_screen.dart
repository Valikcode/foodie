import 'dart:async';
import 'dart:io';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie/blocs/location/location_bloc.dart';
import 'package:foodie/blocs/location_permission/location_permission_bloc.dart';
import 'package:foodie/blocs/main/main_bloc.dart';
import 'package:foodie/values/colors.dart';
import 'package:foodie/values/styles.dart';
import 'package:foodie/widgets/locations_screen_bottom_sheet.dart';
import 'package:foodie/widgets/locations_screen_location_name.dart';
import 'package:foodie/widgets/locations_screen_marker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationsScreen extends StatelessWidget {
  LocationsScreen({super.key});

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static late String _mapStyle;

  @override
  Widget build(BuildContext context) {
    if (BlocProvider.of<LocationPermissionBloc>(context).state.state ==
        LocationPermissionStateEnum.granted) {
      BlocProvider.of<LocationBloc>(context).add(
        InitLocation(
            newCameraPosition:
                BlocProvider.of<MainBloc>(context).state.phoneLocation),
      );
    }
    CameraPosition cameraPosition = CameraPosition(
        target: BlocProvider.of<MainBloc>(context).state.phoneLocation,
        zoom: 13);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: 30,
          color: Color(AppColors.primaryColor),
          onPressed: () {
            exit(0);
          },
        ),
        title: const Text(
          'Nearby',
          style: TextStyle(
              fontSize: 24,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
        toolbarHeight: 48,
      ),
      body: Column(
        children: [
          const LocationName(),
          Expanded(
            child: BlocBuilder<LocationBloc, LocationState>(
              builder: (context, state) {
                if (state.state == LocationStateEnum.loaded) {
                  return CustomGoogleMapMarkerBuilder(
                    screenshotDelay: const Duration(seconds: 5),
                    customMarkers:
                        state.restaurants.map<MarkerData>((restaurant) {
                      final marker = Marker(
                        markerId: MarkerId(restaurant.id.toString()),
                        position:
                            LatLng(restaurant.latitude, restaurant.longitude),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return LocationsBottomSheet(
                                restaurant: restaurant,
                              );
                            },
                          );
                        },
                      );

                      return MarkerData(
                        marker: marker,
                        child: LocationsScreenMarker(
                          imageUrl: restaurant.imageUrl,
                        ),
                      );
                    }).toList(),
                    builder: (BuildContext context, Set<Marker>? markers) {
                      if (markers == null) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: cameraPosition,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        onMapCreated: (GoogleMapController controller) async {
                          if (!_controller.isCompleted) {
                            _controller.complete(controller);
                          }

                          _mapStyle = await DefaultAssetBundle.of(context)
                              .loadString(MapStyles.silverMapStyle);
                          controller.setMapStyle(_mapStyle);
                        },
                        markers: markers,
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
