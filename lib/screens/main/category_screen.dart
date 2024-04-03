import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie/blocs/bookmark/bookmark_bloc.dart';
import 'package:foodie/blocs/category/category_bloc.dart';
import 'package:foodie/blocs/main/main_bloc.dart';
import 'package:foodie/widgets/category_screen_picture.dart';
import 'package:foodie/widgets/category_screen_title.dart';
import 'package:foodie/widgets/restaurant_card.dart';

class CategoryScreen extends StatefulWidget {
  final String? categoryName;
  final String? categoryAlias;
  final String? attributeName;
  final String? attributeAlias;
  final String location;

  const CategoryScreen(
      {Key? key,
      this.categoryName,
      this.categoryAlias,
      this.attributeAlias,
      this.attributeName,
      required this.location})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late ScrollController _scrollController;
  late CategoryBloc _categoryBloc;

  String getCategoryPictureUrl(CategoryState state) {
    if (state.restaurantList.isNotEmpty) {
      return state.restaurantList[0].imageUrl;
    } else {
      return '';
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    _categoryBloc = CategoryBloc(widget.location!);

    if (widget.categoryName != null) {
      _categoryBloc.add(InitCategoryPage(widget.categoryAlias!));
    } else if (widget.attributeName != null) {
      _categoryBloc.add(InitAttributePage(widget.attributeAlias!));
    }
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      final state = _categoryBloc.state;
      if (!state.noMoreRestaurants) {
        if (widget.categoryName != null) {
          _categoryBloc.add(FetchNewPage(widget.categoryAlias!));
        }
        if (widget.attributeName != null) {
          _categoryBloc.add(FetchNewAttributePage(widget.attributeAlias!));
        }
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _categoryBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryBloc>.value(
      value: _categoryBloc,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Text(
                'Share',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            )
          ],
        ),
        body: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            return SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      CategoryPicture(
                        imageUrl: getCategoryPictureUrl(state),
                      ),
                      CategoryTitle(
                          categoryName:
                              widget.categoryName ?? widget.attributeName),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                      if (state.state == CategoryStateEnum.init) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state.state == CategoryStateEnum.loaded ||
                          state.state == CategoryStateEnum.loading) {
                        if (state.restaurantList.isEmpty) {
                          return const Center(
                            child: Text(
                              "No restaurants found",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          );
                        } else {
                          BlocProvider.of<BookmarkBloc>(context)
                              .add(InitBookmarkStatus());
                          return Column(
                            children: [
                              ...state.restaurantList.map((restaurant) {
                                return BlocBuilder<BookmarkBloc, BookmarkState>(
                                  builder: (context, state) {
                                    return RestaurantCard(
                                      id: restaurant.id,
                                      isOpen: restaurant.isOpen,
                                      name: restaurant.name,
                                      location: restaurant.location,
                                      rating: restaurant.rating,
                                      categoryTitle: restaurant.categoryTitle,
                                      categoryAlias: restaurant.categoryAlias,
                                      imageUrl: restaurant.imageUrl,
                                      isBookmarked:
                                          BlocProvider.of<BookmarkBloc>(context)
                                              .state
                                              .bookmarkedRestaurants
                                              .any((bookmarkedRestaurant) =>
                                                  bookmarkedRestaurant.id ==
                                                  restaurant.id),
                                      typeFavorite: false,
                                    );
                                  },
                                );
                              }).toList(),

                              if (state.noMoreRestaurants == true &&
                                  state.state == CategoryStateEnum.loaded)
                                const Padding(
                                  padding:
                                      EdgeInsets.only(top: 8.0, bottom: 8.0),
                                  child: Text(
                                    "No more restaurants found",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),

                              // Show loading indicator while fetching more pages
                              if (state.state == CategoryStateEnum.loading)
                                const CircularProgressIndicator(),
                            ],
                          );
                        }
                      } else {
                        return const Text("Error");
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
