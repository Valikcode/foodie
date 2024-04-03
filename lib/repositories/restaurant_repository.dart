import 'package:flutter/material.dart';
import 'package:foodie/models/detailed_restaurant_model.dart';
import 'package:foodie/models/restaurant_model.dart';
import 'package:foodie/models/review_model.dart';
import 'package:foodie/utils/utils.dart';
import 'package:foodie/values/api_constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RestaurantRepository {
  static final apiKey = ApiConstants.apiKey;
  static const String searchPath = '/v3/businesses/search';
  static const String categoriesPath = '/v3/categories';
  static const String detailsPath = '/v3/businesses';

  static Future<List<RestaurantModel>> fetchHotAndNewRestaurants(
      String location) async {
    final response = await http.get(
      ApiConstants.baseUrl.resolve(searchPath).replace(
        queryParameters: {
          'location': location,
          'term': 'restaurants',
          'attributes': 'hot_and_new',
          'limit': '4'
        },
      ),
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
    );

    debugPrint('HotAndNew request code: ${response.statusCode.toString()}');
    late final List<RestaurantModel> hotAndNewRestaurants;

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['businesses'] != null && jsonData['businesses'].isNotEmpty) {
        final hotAndNewList = jsonData['businesses'] as List<dynamic>;

        hotAndNewRestaurants = hotAndNewList
            .take(4)
            .map((business) => RestaurantModel.fromJson(business))
            .toList();
      } else {
        hotAndNewRestaurants = const [];
      }
    }
    return hotAndNewRestaurants;
  }

  static Future<List<RestaurantModel>> fetchMostPopularRestaurants(
      String location,
      {int? page}) async {
    page ??= 0;
    final response = await http.get(
      ApiConstants.baseUrl.resolve(searchPath).replace(
        queryParameters: {
          'location': location,
          'term': 'restaurants',
          'sort_by': 'rating',
          'limit': '${ApiConstants.fetchLimit}',
          'offset': '${page * ApiConstants.fetchLimit}',
          'review_count': 'true',
        },
      ),
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
    );

    debugPrint('MostPopular request code: ${response.statusCode.toString()}');
    late final List<RestaurantModel> mostPopularRestaurants;

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['businesses'] != null && jsonData['businesses'].isNotEmpty) {
        final mostPopularList = jsonData['businesses'] as List<dynamic>;

        mostPopularRestaurants = mostPopularList
            .map((business) => RestaurantModel.fromJson(business))
            .toList();
      }
    } else {
      mostPopularRestaurants = [];
    }
    return mostPopularRestaurants;
  }

  static Future<List<RestaurantModel>> fetchDealsRestaurants(String location,
      {int? page}) async {
    page ??= 0;
    final response = await http.get(
      ApiConstants.baseUrl.resolve(searchPath).replace(
        queryParameters: {
          'location': location,
          'term': 'restaurants',
          'sort_by': 'best_match',
          'limit': '${ApiConstants.fetchLimit}',
          'offset': '${page * ApiConstants.fetchLimit}',
          'price': '1'
        },
      ),
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
    );
    debugPrint('Deals request code: ${response.statusCode.toString()}');
    late final List<RestaurantModel> dealsRestaurants;

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['businesses'] != null && jsonData['businesses'].isNotEmpty) {
        final dealsList = jsonData['businesses'] as List<dynamic>;

        dealsRestaurants = dealsList
            .map((business) => RestaurantModel.fromJson(business))
            .toList();
      }
    } else {
      dealsRestaurants = [];
    }
    return dealsRestaurants;
  }

  static Future<List<RestaurantModel>> fetchTakeoutRestaurants(String location,
      {int? page}) async {
    page ??= 0;
    final response = await http.get(
      ApiConstants.baseUrl.resolve(searchPath).replace(
        queryParameters: {
          'location': location,
          'term': 'restaurants',
          'attributes': 'takeout',
          'offset': '${page * ApiConstants.fetchLimit}',
          'limit': '${ApiConstants.fetchLimit}',
        },
      ),
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
    );

    debugPrint('Takeout request code: ${response.statusCode.toString()}');
    late final List<RestaurantModel> takeoutRestaurants;

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['businesses'] != null && jsonData['businesses'].isNotEmpty) {
        final takeoutList = jsonData['businesses'] as List<dynamic>;

        takeoutRestaurants = takeoutList
            .map((business) => RestaurantModel.fromJson(business))
            .toList();
      }
    } else {
      takeoutRestaurants = [];
    }

    return takeoutRestaurants;
  }

  static Future<List<RestaurantModel>> fetchDeliveryRestaurants(String location,
      {int? page}) async {
    page ??= 0;
    final response = await http.get(
      ApiConstants.baseUrl.resolve(searchPath).replace(
        queryParameters: {
          'location': location,
          'term': 'restaurants',
          'attributes': 'delivery',
          'sort_by': 'distance',
          'offset': '${page * ApiConstants.fetchLimit}',
          'limit': '${ApiConstants.fetchLimit}',
        },
      ),
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
    );

    debugPrint('Delivery request code: ${response.statusCode.toString()}');
    late final List<RestaurantModel> deliveryRestaurants;

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['businesses'] != null && jsonData['businesses'].isNotEmpty) {
        final deliveryList = jsonData['businesses'] as List<dynamic>;

        deliveryRestaurants = deliveryList
            .map((business) => RestaurantModel.fromJson(business))
            .where((restaurant) => restaurant.imageUrl != "")
            .take(5)
            .toList();
      }
    } else {
      deliveryRestaurants = [];
    }
    return deliveryRestaurants;
  }

  static Future<Map<String, String>> fetchCategoryes() async {
    final response = await http.get(
      ApiConstants.baseUrl.resolve(categoriesPath),
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
    );

    debugPrint('Categoryes request code: ${response.statusCode.toString()}');
    late final Map<String, String> categoriesMap;

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final categoryList = jsonData['categories'] as List<dynamic>;
      categoriesMap = {};

      for (var category in categoryList) {
        final String title = category['title'];
        final List<dynamic> parentAliases = category['parent_aliases'];
        if (parentAliases
            .any((alias) => alias.toLowerCase().contains('restaurants'))) {
          final String alias = category['alias'];
          categoriesMap[title] = alias;
        }
      }
    } else {
      categoriesMap = {};
    }

    return categoriesMap;
  }

  static Future<List<RestaurantModel>> fetchRestaurantsByPageAndCategory(
      String location, int page, String categoryAlias) async {
    final response = await http.get(
      ApiConstants.baseUrl.resolve(searchPath).replace(
        queryParameters: {
          'location': location,
          'term': 'restaurants',
          'limit': '${ApiConstants.fetchLimit}',
          'offset': '${page * ApiConstants.fetchLimit}',
          'categories': categoryAlias.toLowerCase(),
        },
      ),
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
    );

    debugPrint('CategoryPage request code: ${response.statusCode.toString()}');
    late final List<RestaurantModel> categoryPage;

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['businesses'] != null && jsonData['businesses'].isNotEmpty) {
        final deliveryList = jsonData['businesses'] as List<dynamic>;

        categoryPage = deliveryList
            .map((business) => RestaurantModel.fromJson(business))
            .where((restaurant) =>
                restaurant.imageUrl != "" &&
                restaurant.categoryAlias
                    .toLowerCase()
                    .contains(categoryAlias.toLowerCase()))
            .take(7)
            .toList();
      } else {
        categoryPage = [];
      }
    } else {
      categoryPage = [];
    }
    debugPrint("NumberOfEntries: ${categoryPage.length}");
    return categoryPage;
  }

  static Future<DetailedRestaurantModel?> fetchRestaurantDetails(
      String businessId) async {
    final response = await http.get(
      ApiConstants.baseUrl.resolve('$detailsPath/$businessId'),
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
    );

    debugPrint(
        'RestaurantDetails request code: ${response.statusCode.toString()}');

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData != null) {
        return DetailedRestaurantModel.fromJsonDetailed(jsonData);
      }
    }
    return null;
  }

  static Future<List<ReviewModel>> fetchRestaurantReviews(
      String businessId) async {
    final response = await http.get(
      ApiConstants.baseUrl.resolve('$detailsPath/$businessId/reviews'),
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
    );
    debugPrint(
        'RestaurantReviews request code: ${response.statusCode.toString()}');
    late final List<ReviewModel> reviews;

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['reviews'] != null && jsonData['reviews'].isNotEmpty) {
        final reviewsList = jsonData['reviews'] as List<dynamic>;

        reviews =
            reviewsList.map((review) => ReviewModel.fromJson(review)).toList();
      } else {
        reviews = [];
      }
    } else {
      reviews = [];
    }
    return reviews;
  }

  static const int defaultRadiusMeters = 40000;

  static Future<List<DetailedRestaurantModel>> fetchRestaurantsWithinRadius(
      LatLng baseLatLng) async {
    final response = await http.get(
      ApiConstants.baseUrl.resolve(searchPath).replace(
        queryParameters: {
          'term': 'restaurants',
          'latitude': baseLatLng.latitude.toString(),
          'longitude': baseLatLng.longitude.toString(),
          'radius': defaultRadiusMeters.toString(),
          'sort_by': 'rating',
          'limit': '50',
        },
      ),
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
    );

    debugPrint(
        'RestaurantsWithinRadius request code: ${response.statusCode.toString()}');
    late final List<DetailedRestaurantModel> restaurantsWithinRadius;

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['businesses'] != null && jsonData['businesses'].isNotEmpty) {
        final restaurantList = jsonData['businesses'] as List<dynamic>;

        restaurantsWithinRadius = restaurantList
            .map((restaurant) =>
                DetailedRestaurantModel.fromJsonDetailed(restaurant))
            .toList();
      } else {
        restaurantsWithinRadius = [];
      }
    } else {
      restaurantsWithinRadius = [];
    }
    return restaurantsWithinRadius;
  }
}
