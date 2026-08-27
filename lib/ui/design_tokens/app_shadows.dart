import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppShadows {
  static const card = [
    BoxShadow(
      color: Color(0x1E9E9E9E),
      spreadRadius: 1,
      blurRadius: 5,
      offset: Offset(0, 3),
    ),
  ];

  static const cardStrong = [
    BoxShadow(
      color: Color(0x1E9E9E9E),
      spreadRadius: 2,
      blurRadius: 10,
      offset: Offset(0, 3),
    ),
  ];

  static const iconButton = [
    BoxShadow(
      color: Color(0x1E9E9E9E),
      spreadRadius: 2,
      blurRadius: 10,
      offset: Offset(0, 2),
    ),
  ];

  static const floatingButton = [
    BoxShadow(
      color: Color(0x19000000),
      spreadRadius: 2,
      blurRadius: 8,
      offset: Offset(0, 3),
    ),
  ];

  static const bottomSheet = [
    BoxShadow(
      color: Color(0x1E9E9E9E),
      spreadRadius: 2,
      blurRadius: 10,
      offset: Offset(0, -2),
    ),
  ];

  static const coupon = [
    BoxShadow(
      color: Color(0x33000000),
      offset: Offset(0, 2),
      blurRadius: 12,
    ),
  ];

  static const none = <BoxShadow>[];

  static List<BoxShadow> iconButtonConditional(bool active) => active
      ? [
          BoxShadow(
            color: AppColors.black.withAlpha(25),
            blurRadius: 8.0,
            spreadRadius: 2.0,
            offset: const Offset(0, 3),
          ),
        ]
      : none;
}
