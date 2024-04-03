import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie/blocs/main/main_bloc.dart';
import 'package:foodie/models/restaurant_model.dart';
import 'package:foodie/screens/main/category_screen.dart';
import 'package:foodie/widgets/home_screen_section_card.dart';

class SectionScrollView extends StatelessWidget {
  final String location;
  final String sectionTitle;
  final String attributeAlias;
  final List<RestaurantModel> restaurantsList;

  const SectionScrollView(
      {required this.location,
      required this.sectionTitle,
      required this.attributeAlias,
      required this.restaurantsList,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionTitle,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CategoryScreen(
                                attributeName: sectionTitle,
                                attributeAlias: attributeAlias,
                                location: location,
                              )));
                },
                child: const Text(
                  'See all',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < restaurantsList.length; i++)
                RestaurantCard(restaurant: restaurantsList[i]),
            ],
          ),
        ),
      ],
    );
  }
}
