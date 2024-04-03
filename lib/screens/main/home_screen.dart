import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie/blocs/home/home_bloc.dart';
import 'package:foodie/blocs/main/main_bloc.dart';
import 'package:foodie/utils/utils.dart';
import 'package:foodie/values/colors.dart';
import 'package:foodie/widgets/home_screen_hot_and_new_page_view.dart';
import 'package:foodie/widgets/home_screen_search_bar.dart';
import 'package:foodie/widgets/home_screen_section_scroll_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.state == HomeStateEnum.init ||
            state.state == HomeStateEnum.loading) {
          if (state.state == HomeStateEnum.init) {
            BlocProvider.of<HomeBloc>(context).add(InitHomePage());
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state.state == HomeStateEnum.loaded) {
          return Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      BlocBuilder<MainBloc, MainState>(
                        builder: (context, mainState) {
                          return SliverAppBar(
                            title: FutureBuilder<String>(
                              future: Utils.getLocationName(
                                  mainState.phoneLocation),
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Text(
                                    'Loading...',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return const Text(
                                    'Unknown Location',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  );
                                } else {
                                  return Text(
                                    snapshot.data!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  );
                                }
                              },
                            ),
                            centerTitle: true,
                            toolbarHeight: 48,
                            leading: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                size: 30,
                              ),
                              color: Color(AppColors.primaryColor),
                              onPressed: () {
                                exit(0);
                              },
                            ),
                            floating: true,
                            snap: true,
                          );
                        },
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            DropdownSearchBox(
                                location: BlocProvider.of<MainBloc>(context)
                                    .state
                                    .phoneLocationString),
                            const HotAndNewPageView(),
                            const SizedBox(
                              height: 16,
                            ),
                            SectionScrollView(
                              sectionTitle: 'Most Popular',
                              attributeAlias: 'rating',
                              restaurantsList: state.mostPopularRestaurants,
                              location: BlocProvider.of<MainBloc>(context)
                                  .state
                                  .phoneLocationString,
                            ),
                            SectionScrollView(
                              sectionTitle: 'Meal Deals',
                              attributeAlias: 'best_match',
                              restaurantsList: state.dealsRestaurants,
                              location: BlocProvider.of<MainBloc>(context)
                                  .state
                                  .phoneLocationString,
                            ),
                            SectionScrollView(
                              sectionTitle: 'Takeout',
                              attributeAlias: 'takeout',
                              restaurantsList: state.takeoutRestaurants,
                              location: BlocProvider.of<MainBloc>(context)
                                  .state
                                  .phoneLocationString,
                            ),
                            SectionScrollView(
                              sectionTitle: 'Delivery',
                              attributeAlias: 'delivery',
                              restaurantsList: state.deliveryRestaurants,
                              location: BlocProvider.of<MainBloc>(context)
                                  .state
                                  .phoneLocationString,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
