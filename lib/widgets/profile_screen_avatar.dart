import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String imageUrl;

  const Avatar({
    required this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isNotEmpty) {
      return CircleAvatar(
        radius: 60,
        backgroundColor: Colors.accents[1],
        backgroundImage: NetworkImage(imageUrl),
      );
    }
    return Container();
  }
}
