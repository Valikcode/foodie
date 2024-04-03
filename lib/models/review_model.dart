import 'package:foodie/models/user_model.dart';

class ReviewModel {
  final String id;
  final String url;
  final String text;
  final int rating;
  final DateTime timeCreated;
  final UserModel user;

  ReviewModel(
      {required this.id,
      required this.url,
      required this.text,
      required this.rating,
      required this.timeCreated,
      required this.user});

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      url: json['url'],
      text: json['text'],
      rating: json['rating'],
      timeCreated: DateTime.parse(json['time_created']),
      user: UserModel.fromJson(json['user']),
    );
  }
}
