import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie/blocs/restaurant_description/restaurant_description_bloc.dart';
import 'package:foodie/widgets/detailded_restaurant_screen_image_and_title.dart';
import 'package:foodie/widgets/detailed_restaurant_screen_actions.dart';
import 'package:foodie/widgets/detailed_restaurant_screen_banner.dart';
import 'package:foodie/widgets/detailed_restaurant_screen_details.dart';
import 'package:foodie/widgets/detailed_restaurant_screen_map.dart';
import 'package:foodie/widgets/detailed_restaurant_screen_photos.dart';
import 'package:foodie/widgets/detailed_restaurant_screen_reviews.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailedRestaurantScreen extends StatelessWidget {
  final String id;
  //TODO open hive in the init of the detailed screen

  const DetailedRestaurantScreen({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    debugPrint(id);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: 30,
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        toolbarHeight: 48,
      ),
      body: BlocProvider(
        create: (context) =>
            RestaurantDescriptionBloc()..add(FetchRestaurantDetails(id)),
        child:
            BlocBuilder<RestaurantDescriptionBloc, RestaurantDescriptionState>(
          builder: (context, state) {
            if (state.state == RestaurantDescriptionStateEnum.loaded) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DetailedRestaurantScreenImageAndTitle(
                        imageUrl: state.restaurant.imageUrl,
                        name: state.restaurant.name),
                    const DetailedRestaurantScreenBanner(),
                    const SizedBox(
                      height: 16,
                    ),
                    DetailedRestaurantScreenActions(
                        restaurant: state.restaurant),
                    const SizedBox(
                      height: 16,
                    ),
                    DetailedRestaurantScreenMap(
                        openingHours: state.restaurant.openingHours,
                        staticMapUrl: state.staticMapUrl,
                        location: state.restaurant.location,
                        locationLatLng: LatLng(state.restaurant.latitude,
                            state.restaurant.longitude),
                        categoryTitle: state.restaurant.categoryTitle,
                        isOpen: state.restaurant.isOpen),
                    DetailedRestaurantScreenDetails(
                      phoneNumber: state.restaurant.phoneNumber,
                      categoriesName: state.restaurant.categoryTitle,
                      averageCost: state.restaurant.priceRange,
                    ),
                    DetailedRestaurantScreenPhotos(
                        photoUrls: state.restaurant.photos),
                    const DetailedRestaurantScreenReviews(),
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
