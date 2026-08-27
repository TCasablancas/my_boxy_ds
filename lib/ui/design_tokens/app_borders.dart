import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';

abstract final class AppBorders {
  static const thin = BorderSide(color: AppColors.border, width: 1);
  static const thick = BorderSide(color: AppColors.border, width: 2);

  static const focusThick = BorderSide(color: AppColors.primary, width: 2);
  static const errorThick = BorderSide(color: AppColors.error, width: 2);

  static BorderSide sideOf(Color color, {double width = 2}) =>
      BorderSide(color: color, width: width);

  static OutlineInputBorder outline(Color color, {double radius = AppRadius.lg}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: color, width: 2),
    );
  }

  static const none = InputBorder.none;
}
