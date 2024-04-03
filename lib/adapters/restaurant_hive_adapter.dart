import 'package:foodie/models/restaurant_model.dart';
import 'package:hive/hive.dart';

class RestaurantModelAdapter extends TypeAdapter<RestaurantModel> {
  @override
  final typeId = 0;

  @override
  RestaurantModel read(BinaryReader reader) {
    final id = reader.readString();
    final name = reader.readString();
    final imageUrl = reader.readString();
    final categoryTitle = reader.readString();
    final categoryAlias = reader.readString();
    final location = reader.readString();
    final isOpen = reader.readBool();
    final rating = reader.readDouble();
    final isBookmarked = reader.readBool();
    return RestaurantModel(
        id: id,
        name: name,
        imageUrl: imageUrl,
        categoryTitle: categoryTitle,
        categoryAlias: categoryAlias,
        location: location,
        isOpen: isOpen,
        rating: rating,
        isBookmarked: isBookmarked);
  }

  @override
  void write(BinaryWriter writer, RestaurantModel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.name);
    writer.writeString(obj.imageUrl);
    writer.writeString(obj.categoryTitle);
    writer.writeString(obj.categoryAlias);
    writer.writeString(obj.location);
    writer.writeBool(obj.isOpen);
    writer.writeDouble(obj.rating);
    writer.writeBool(obj.isBookmarked);
  }
}
