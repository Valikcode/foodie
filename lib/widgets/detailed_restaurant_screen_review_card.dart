import 'package:flutter/material.dart';
import 'package:foodie/models/review_model.dart';
import 'package:foodie/values/images.dart';

class DetailedRestaurantReviewCard extends StatelessWidget {
  final ReviewModel review;

  const DetailedRestaurantReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: review.user.imageUrl.isNotEmpty
                      ? NetworkImage(review.user.imageUrl)
                      : const AssetImage(AppImages.noUserPhoto)
                          as ImageProvider,
                ),
                const SizedBox(width: 12),
                Text(
                  review.user.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star_rounded,
                      color: index < review.rating.toInt()
                          ? Colors.yellow
                          : Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${review.rating}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              review.text,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
