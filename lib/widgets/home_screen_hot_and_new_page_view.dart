import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie/blocs/home/home_bloc.dart';
import 'package:foodie/widgets/home_screen_hot_and_new_card.dart';

class HotAndNewPageView extends StatelessWidget {
  const HotAndNewPageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ]),
          child: ClipRRect(
            borderRadius: _getPageViewBorderRadius(
                state.hotAndNewIndex, state.hotAndNewRestaurants.length),
            child: Stack(
              children: [
                SizedBox(
                  height: 200,
                  child: PageView.builder(
                    itemCount: state.hotAndNewRestaurants.length,
                    onPageChanged: (index) {
                      context.read<HomeBloc>().add(SwipeHotAndNew(index));
                    },
                    itemBuilder: (context, index) {
                      final restaurant = state.hotAndNewRestaurants[index];
                      return HotAndNewPageContainer(
                        restaurant: restaurant,
                      );
                    },
                  ),
                ),
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: Row(
                    children: [
                      for (int i = 0;
                          i < state.hotAndNewRestaurants.length;
                          i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: i == state.hotAndNewIndex
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  BorderRadiusGeometry _getPageViewBorderRadius(
      int currentIndex, int totalPages) {
    if (currentIndex == 0) {
      // Leftmost page
      return const BorderRadius.only(
        topLeft: Radius.circular(8),
        bottomLeft: Radius.circular(8),
      );
    } else if (currentIndex == totalPages - 1) {
      // Rightmost page
      return const BorderRadius.only(
        topRight: Radius.circular(8),
        bottomRight: Radius.circular(8),
      );
    } else {
      // Other pages
      return BorderRadius.zero;
    }
  }
}
