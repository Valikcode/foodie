import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie/blocs/bookmark/bookmark_bloc.dart';
import 'package:foodie/values/colors.dart';
import 'package:foodie/widgets/restaurant_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          'Favourite',
          style: TextStyle(
              fontSize: 24,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
        toolbarHeight: 48,
      ),
      body: BlocBuilder<BookmarkBloc, BookmarkState>(
        builder: (context, state) {
          //BlocProvider.of<BookmarkBloc>(context).add(InitBookmarkStatus());

          if (state.bookmarkedRestaurants.isEmpty) {
            return const Padding(
              padding: EdgeInsets.only(left: 36.0, right: 24.0),
              child: Center(
                child: Text(
                  "You have no favorites, go and find some!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: state.bookmarkedRestaurants.map((restaurant) {
                  return RestaurantCard(
                    id: restaurant.id,
                    isOpen: restaurant.isOpen,
                    name: restaurant.name,
                    location: restaurant.location,
                    rating: restaurant.rating,
                    categoryTitle: restaurant.categoryTitle,
                    categoryAlias: restaurant.categoryAlias,
                    isBookmarked: restaurant.isBookmarked,
                    imageUrl: restaurant.imageUrl,
                    typeFavorite: true,
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
