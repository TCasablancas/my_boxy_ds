import 'package:flutter/material.dart';

import '../../ui/design_tokens/app_colors.dart';
import '../../ui/design_tokens/app_text_styles.dart';
import '../containers/mb_box_rounded_container.dart';
import 'mb_rating_stars.dart';
import 'mb_review_count_text.dart';

class MBLargeRatingCard extends StatelessWidget {
  final double rating;
  final int reviews;

  const MBLargeRatingCard({
    super.key,
    required this.rating,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return MBBoxRoundedContainer(
      child: Row(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            rating.toStringAsFixed(1),
            style: AppTextStyles.titleLarge.copyWith(
              fontSize: 62,
              fontFamily: 'SFMono',
              letterSpacing: -12,
              height: 1,
              color: AppColors.grey700,
            ),
          ),
          Container(width: 1, height: 30, color: AppColors.disabledText),
          Column(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MBRatingStars(rating: rating),
              MBReviewCountText(reviews: reviews),
            ],
          ),
        ],
      ),
    );
  }
}
