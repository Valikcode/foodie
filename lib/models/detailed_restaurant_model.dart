import 'package:foodie/models/opening_hours_model.dart';
import 'package:foodie/models/restaurant_model.dart';
import 'package:foodie/models/special_hours_model.dart';

class DetailedRestaurantModel extends RestaurantModel {
  final double latitude;
  final double longitude;
  final String website;
  final String phoneNumber;
  final List<String> photos;
  final String priceRange;
  final List<OpeningHoursModel> openingHours;
  final List<SpecialHoursModel> specialHours;

  const DetailedRestaurantModel({
    required String id,
    required String name,
    required String imageUrl,
    required String categoryTitle,
    required String categoryAlias,
    required String location,
    required this.latitude,
    required this.longitude,
    required this.website,
    required this.phoneNumber,
    required bool isOpen,
    required double rating,
    required bool isBookmarked,
    required this.photos,
    required this.priceRange,
    required this.openingHours,
    required this.specialHours,
  }) : super(
          id: id,
          name: name,
          imageUrl: imageUrl,
          categoryTitle: categoryTitle,
          categoryAlias: categoryAlias,
          location: location,
          isOpen: isOpen,
          rating: rating,
          isBookmarked: isBookmarked,
        );

  factory DetailedRestaurantModel.fromJsonDetailed(
      Map<String, dynamic> jsonData) {
    final coordinates = jsonData['coordinates'];
    final hours = jsonData['hours'];

    return DetailedRestaurantModel(
      id: jsonData['id'] as String,
      name: jsonData['name'] as String,
      imageUrl:
          jsonData['image_url'] != null ? jsonData['image_url'] as String : '',
      categoryTitle: _extractCategoryNames(jsonData['categories']),
      categoryAlias: _extractCategoryAliases(jsonData['categories']),
      latitude: coordinates['latitude'] as double,
      longitude: coordinates['longitude'] as double,
      website: jsonData['url'] as String,
      location: _extractLocation(jsonData['location']),
      isOpen: jsonData['is_closed'] != null
          ? !(jsonData['is_closed'] as bool)
          : true,
      rating: jsonData['rating'] != null
          ? (jsonData['rating'] as num).toDouble()
          : 0.0,
      isBookmarked: false,
      phoneNumber:
          jsonData['display_phone'] != null && jsonData['display_phone'] != ''
              ? jsonData['display_phone'] as String
              : 'Not provided',
      photos: _extractPhotos(jsonData['photos']),
      priceRange: jsonData['price'] != null
          ? jsonData['price'] as String
          : 'Not provided',
      openingHours: hours != null ? _extractOpeningHours(hours[0]) : [],
      specialHours: _extractSpecialHours(jsonData['special_hours']),
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

  static List<String> _extractPhotos(List<dynamic>? photosData) {
    if (photosData == null || photosData.isEmpty) {
      return [];
    }
    return photosData.map((photo) => photo as String).toList();
  }

  static List<OpeningHoursModel> _extractOpeningHours(
      Map<String, dynamic>? hoursData) {
    if (hoursData == null || hoursData['open'] == null) {
      return [];
    }

    List<OpeningHoursModel> openingHours = [];
    List<dynamic> openHoursData = hoursData['open'];

    for (final entry in openHoursData) {
      openingHours.add(OpeningHoursModel(
        isOvernight: entry['is_overnight'] as bool,
        startTime: _formatTime(entry['start'] as String),
        endTime: _formatTime(entry['end'] as String),
        dayOfWeek: entry['day'] as int,
      ));
    }

    return openingHours;
  }

  static String _formatTime(String time) {
    int timeInMinutes = int.parse(time);
    int hours = timeInMinutes ~/ 100;
    int minutes = timeInMinutes % 100;

    String ampm = hours >= 12 ? 'PM' : 'AM';
    hours = hours % 12;
    hours = hours != 0 ? hours : 12;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')} $ampm';
  }

  static List<SpecialHoursModel> _extractSpecialHours(
      List<dynamic>? specialHoursData) {
    if (specialHoursData == null) {
      return [];
    }

    List<SpecialHoursModel> specialHours = [];

    for (final entry in specialHoursData) {
      specialHours.add(SpecialHoursModel(
        date: entry['date'] as String,
        isClosed: entry['is_closed'] as bool?,
        isOvernight: entry['is_overnight'] as bool,
        startTime: entry['start'] as String,
        endTime: entry['end'] as String,
      ));
    }

    return specialHours;
  }
}
