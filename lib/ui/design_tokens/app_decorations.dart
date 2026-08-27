import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_shadows.dart';

abstract final class AppDecorations {
  static BoxDecoration card({
    Color color = AppColors.surface,
    BorderRadius radius = AppRadius.allLarge,
    List<BoxShadow>? shadow,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: radius,
      boxShadow: shadow ?? AppShadows.card,
    );
  }

  static BoxDecoration pill({Color color = AppColors.surface}) {
    return BoxDecoration(
      color: color,
      borderRadius: AppRadius.allFull,
    );
  }

  static BoxDecoration bordered(Color color, {double width = 2, double radius = AppRadius.lg}) {
    return BoxDecoration(
      color: AppColors.white,
      border: Border.all(color: color, width: width),
      borderRadius: BorderRadius.circular(radius),
    );
  }

  static BoxDecoration errorBanner = BoxDecoration(
    color: AppColors.errorBackground,
    borderRadius: BorderRadius.circular(AppRadius.medium),
  );

  static const circle = BoxDecoration(shape: BoxShape.circle);

  static BoxDecoration circleOf(Color color) => BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      );

  static const bottomSheetTop = BoxDecoration(
    color: AppColors.transparent,
    borderRadius: AppRadius.topSheet,
  );
}
