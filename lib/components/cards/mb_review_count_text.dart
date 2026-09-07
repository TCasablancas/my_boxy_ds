import 'package:flutter/material.dart';

import '../../ui/design_tokens/app_colors.dart';
import '../../ui/design_tokens/app_text_styles.dart';

class MBReviewCountText extends StatelessWidget {
  final int reviews;
  final TextStyle? style;

  const MBReviewCountText({super.key, required this.reviews, this.style});

  String get formattedReviews {
    if (reviews < 1000) {
      return reviews.toString();
    }

    final thousands = reviews ~/ 1000;
    final tenths = reviews % 1000 ~/ 100;
    return '$thousands.${tenths}k';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$formattedReviews Reviews',
      style:
          style ?? AppTextStyles.bodyLarge.copyWith(color: AppColors.grey500),
    );
  }
}
