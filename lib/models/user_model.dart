class UserModel {
  final String id;
  final String profileUrl;
  final String imageUrl;
  final String name;

  UserModel(
      {required this.id,
      required this.profileUrl,
      required this.imageUrl,
      required this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      profileUrl: json['profile_url'],
      imageUrl: json['image_url'] ?? '',
      name: json['name'],
    );
  }
}
