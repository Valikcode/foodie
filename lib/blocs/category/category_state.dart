part of 'category_bloc.dart';

enum CategoryStateEnum { init, loading, loaded, error }

@immutable
class CategoryState extends Equatable {
  final CategoryStateEnum state;
  final int currentPage;
  final String selectedCategoryAlias;
  final List<RestaurantModel> restaurantList;
  final bool noMoreRestaurants;

  const CategoryState({
    this.state = CategoryStateEnum.init,
    this.currentPage = 0,
    this.selectedCategoryAlias = '',
    this.restaurantList = const [],
    this.noMoreRestaurants = false,
  });

  CategoryState copyWith({
    CategoryStateEnum? state,
    int? currentPage,
    String? selectedCategoryAlias,
    List<RestaurantModel>? restaurantList,
    bool? noMoreRestaurants,
  }) =>
      CategoryState(
        state: state ?? this.state,
        currentPage: currentPage ?? this.currentPage,
        selectedCategoryAlias:
            selectedCategoryAlias ?? this.selectedCategoryAlias,
        restaurantList: restaurantList ?? this.restaurantList,
        noMoreRestaurants: noMoreRestaurants ?? this.noMoreRestaurants,
      );

  @override
  List<Object> get props => [
        state,
        currentPage,
        selectedCategoryAlias,
        restaurantList,
        noMoreRestaurants
      ];
}
