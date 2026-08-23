import 'mb_design_tokens.dart';
import 'package:flutter/material.dart';

class AppTypography {
  static final fontFamily = 'Lexend';

  static TextStyle setSnackbarStyle(Color? color) {
    return TextStyle(
      fontSize: 13,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.2,
      height: 1.4,
      color: color,
    );
  }

  static TextStyle setInputStyle() {
    return TextStyle(
      color: Colors.grey[700],
      fontFamily: 'Lexend',
      fontWeight: FontWeight.w300,
    );
  }

  static TextStyle h2Fn(Color? color, [FontWeight weight = FontWeight.w800]) {
    return TextStyle(
      fontSize: 24,
      fontFamily: fontFamily,
      fontWeight: weight,
      color: color,
      letterSpacing: -0.75,
    );
  }

  static TextStyle h3Fn(Color? color, [FontWeight weight = FontWeight.w800]) {
    return TextStyle(
      fontSize: 20,
      fontFamily: fontFamily,
      fontWeight: weight,
      color: color,
      letterSpacing: -0.75,
    );
  }

  static TextStyle body1Fn(
    Color? color, 
    [FontWeight weight = FontWeight.normal, String fontFamily = 'Lexend']
  ) {
    return TextStyle(
      fontSize: 16,
      fontWeight: weight,
      fontFamily: fontFamily,
      color: color,
      letterSpacing: -0.2,
      height: 1.5,
    );
  }

  static TextStyle descriptionFn(Color? color) {
    return TextStyle(
      fontSize: 13,
      fontFamily: fontFamily,
      fontWeight: FontWeight.normal,
      color: color,
      height: 1.3,
    );
  }

  static TextStyle captionFn(Color? color, [String fontFamily = 'Lexend']) {
    return TextStyle(
      height: 1.2,
      fontSize: 12,
      fontWeight: FontWeight.normal,
      fontFamily: fontFamily,
      letterSpacing: -0.2,
      color: color,
    );
  }

  static const h1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  static const h2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontFamily: 'Lexend',
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
  );

  static const h3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const body1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    fontFamily: 'Lexend',
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const body2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  static const body3 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    height: 1.3,
  );

  static const description = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.normal,
    fontFamily: 'Lexend',
    color: AppColors.textSecondary,
    height: 1.3,
  );

  static const caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    fontFamily: 'Lexend',
    color: AppColors.textTertiary,
  );

  static const button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );

  static const appBarTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textTertiary,
  );

  static const linkText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.gradientStart,
  );

  static const snackBarTitle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static const switchTag = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColors.success
  );
}