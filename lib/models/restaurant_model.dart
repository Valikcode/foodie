class RestaurantModel {
  final String id;
  final String name;
  final String imageUrl;
  final String categoryTitle;
  final String categoryAlias;
  final String location;
  final bool isOpen;
  final double rating;
  final bool isBookmarked;

  const RestaurantModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.categoryTitle,
    required this.categoryAlias,
    required this.location,
    required this.isOpen,
    required this.rating,
    required this.isBookmarked,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> jsonData) {
    return RestaurantModel(
      id: jsonData['id'] as String,
      name: jsonData['name'] as String,
      imageUrl:
          jsonData['image_url'] != null ? jsonData['image_url'] as String : '',
      categoryTitle: _extractCategoryNames(jsonData['categories']),
      categoryAlias: _extractCategoryAliases(jsonData['categories']),
      location: _extractLocation(jsonData['location']),
      isOpen: jsonData['is_closed'] != null
          ? !(jsonData['is_closed'] as bool)
          : true,
      rating: jsonData['rating'] != null
          ? (jsonData['rating'] as num).toDouble()
          : 0.0,
      isBookmarked: false,
    );
  }

  static String _extractLocation(Map<String, dynamic>? locationData) {
    if (locationData == null || locationData['address1'] == null) {
      return 'Location: not provided';
    }
    String address = locationData['address1'] as String;
    return address.isNotEmpty ? address : 'Location: not provided';
  }

  static String _extractCategoryNames(List<dynamic>? categories) {
    if (categories == null || categories.isEmpty) {
      return 'No Category';
    }

    final categoryNames = categories
        .map((category) => category['title'] as String)
        .toList()
        .join(', ');

    return categoryNames;
  }

  static String _extractCategoryAliases(List<dynamic>? categories) {
    if (categories == null || categories.isEmpty) {
      return 'No Category Alias';
    }

    final categoryAliases = categories
        .map((category) => category['alias'] as String)
        .toList()
        .join(', ');

    return categoryAliases;
  }
}
