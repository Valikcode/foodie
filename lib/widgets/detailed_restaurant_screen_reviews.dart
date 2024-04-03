import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie/blocs/restaurant_description/restaurant_description_bloc.dart';
import 'package:foodie/widgets/detailed_restaurant_screen_review_card.dart';

class DetailedRestaurantScreenReviews extends StatelessWidget {
  const DetailedRestaurantScreenReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantDescriptionBloc, RestaurantDescriptionState>(
      builder: (context, state) {
        if (state.state == RestaurantDescriptionStateEnum.loaded) {
          final reviews = state.reviews;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding:
                    EdgeInsets.only(left: 16.0, right: 16, top: 16, bottom: 8),
                child: Text(
                  "Reviews",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                height: 250,
                child: PageView.builder(
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    return DetailedRestaurantReviewCard(review: reviews[index]);
                  },
                ),
              ),
            ],
          );
        } else if (state.state == RestaurantDescriptionStateEnum.loading) {
          return const CircularProgressIndicator();
        } else {
          return const Text("An error occurred.");
        }
      },
    );
  }
}
