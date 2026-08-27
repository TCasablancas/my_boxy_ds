import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

abstract final class AppTextStyles {
  static const titleLarge = TextStyle(
    fontSize: 32,
    fontFamily: AppFonts.primary,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  static const titleMedium = TextStyle(
    fontSize: 24,
    fontFamily: AppFonts.primary,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
  );

  static const titleSmall = TextStyle(
    fontSize: 20,
    fontFamily: AppFonts.primary,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const bodyLarge = TextStyle(
    fontSize: 16,
    fontFamily: AppFonts.primary,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const bodyMedium = TextStyle(
    fontSize: 14,
    fontFamily: AppFonts.primary,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  static const bodyMediumStrong = TextStyle(
    fontSize: 14,
    fontFamily: AppFonts.primary,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    height: 1.3,
  );

  static const description = TextStyle(
    fontSize: 13,
    fontFamily: AppFonts.primary,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.3,
  );

  static const labelSmall = TextStyle(
    fontSize: 12,
    fontFamily: AppFonts.primary,
    fontWeight: FontWeight.normal,
    color: AppColors.textTertiary,
  );

  static const button = TextStyle(
    fontSize: 16,
    fontFamily: AppFonts.primary,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );

  static const appBarTitle = TextStyle(
    fontSize: 14,
    fontFamily: AppFonts.primary,
    fontWeight: FontWeight.normal,
    color: AppColors.textTertiary,
  );

  static const linkText = TextStyle(
    fontSize: 14,
    fontFamily: AppFonts.primary,
    fontWeight: FontWeight.w600,
    color: AppColors.gradientStart,
  );

  static const snackBarTitle = TextStyle(
    fontSize: 13,
    fontFamily: AppFonts.primary,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static const switchTag = TextStyle(
    fontSize: 10,
    fontFamily: AppFonts.primary,
    fontWeight: FontWeight.w600,
    color: AppColors.success,
  );

  static const errorInline = TextStyle(
    fontSize: 13,
    color: AppColors.error,
  );

  static const productTitle = TextStyle(
    fontSize: 28,
    fontFamily: AppFonts.primary,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryDark,
    letterSpacing: -0.2,
  );

  static const productSubtitleStrong = TextStyle(
    fontSize: 13,
    fontFamily: AppFonts.primary,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2,
    color: AppColors.grey700,
  );

  static const productSubtitle = TextStyle(
    fontSize: 13,
    fontFamily: AppFonts.primary,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.2,
    color: AppColors.grey500,
  );

  static const price = TextStyle(
    fontSize: 24,
    fontFamily: AppFonts.mono,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryDark,
    letterSpacing: -0.2,
  );

  static const priceInstallment = TextStyle(
    fontSize: 13,
    fontFamily: AppFonts.mono,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static TextStyle snackbar(Color? color) => TextStyle(
        fontSize: 13,
        fontFamily: AppFonts.primary,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.2,
        height: 1.4,
        color: color,
      );

  static TextStyle input() => TextStyle(
        color: Colors.grey[700],
        fontFamily: AppFonts.primary,
        fontWeight: FontWeight.w300,
      );

  static TextStyle titleMediumOf(Color? color, [FontWeight weight = FontWeight.w800]) =>
      TextStyle(
        fontSize: 24,
        fontFamily: AppFonts.primary,
        fontWeight: weight,
        color: color,
        letterSpacing: -0.75,
      );

  static TextStyle titleSmallOf(Color? color, [FontWeight weight = FontWeight.w800]) =>
      TextStyle(
        fontSize: 20,
        fontFamily: AppFonts.primary,
        fontWeight: weight,
        color: color,
        letterSpacing: -0.75,
      );

  static TextStyle bodyLargeOf(
    Color? color, [
    FontWeight weight = FontWeight.normal,
    String fontFamily = AppFonts.primary,
  ]) =>
      TextStyle(
        fontSize: 16,
        fontWeight: weight,
        fontFamily: fontFamily,
        color: color,
        letterSpacing: -0.2,
        height: 1.5,
      );

  static TextStyle descriptionOf(Color? color) => TextStyle(
        fontSize: 13,
        fontFamily: AppFonts.primary,
        fontWeight: FontWeight.normal,
        color: color,
        height: 1.3,
      );

  static TextStyle labelSmallOf(Color? color, [String fontFamily = AppFonts.primary]) => TextStyle(
        height: 1.2,
        fontSize: 12,
        fontWeight: FontWeight.w300,
        fontFamily: fontFamily,
        letterSpacing: -0.2,
        color: color,
      );

  static TextStyle buttonOf({
    required double fontSize,
    required Color color,
    FontWeight fontWeight = FontWeight.w500,
  }) =>
      TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: AppFonts.primary,
        fontWeight: fontWeight,
        letterSpacing: -0.2,
      );
}
