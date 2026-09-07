import 'package:flutter/material.dart';

import '../../ui/design_tokens/app_colors.dart';

class MBRatingStars extends StatelessWidget {
  final double rating;
  final int maxStars;
  final double size;
  final Color color;

  const MBRatingStars({
    super.key,
    required this.rating,
    this.maxStars = 5,
    this.size = 36,
    this.color = AppColors.warning,
  });

  @override
  Widget build(BuildContext context) {
    final clampedRating = rating.clamp(0, maxStars).toDouble();
    final fullStars = clampedRating.floor();
    final hasHalfStar = clampedRating - fullStars > 0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxStars, (index) {
        if (index < fullStars) {
          return Icon(Icons.star_rounded, size: size, color: color);
        }
        if (index == fullStars && hasHalfStar) {
          return Icon(Icons.star_half_rounded, size: size, color: color);
        }
        return Icon(Icons.star_outline_rounded, size: size, color: color);
      }),
    );
  }
}
