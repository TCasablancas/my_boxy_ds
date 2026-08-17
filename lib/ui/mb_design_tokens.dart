import 'mb_typography.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF6ABA02);
  static const primaryLight = Color(0xFFBFF578);
  static const primaryDark = Color(0xFF1F6607);

  static const secondary = Color(0xFFBDB1A3);
  static const accent = Color(0xFF58ADB2);

  static const background = Color.fromARGB(250, 240, 240, 240);
  static const lightBackground = Color(0xFFF5F6FA);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceVariant = Color(0xFFF8F9FB);

  static const shadow = Color(0xFFFAFAFA);

  static const textPrimary = Color(0xFF1A1D1F);
  static const textSecondary = Color(0xFF6F767E);
  static const textTertiary = Color(0xFF9A9FA5);

  static const border = Color(0xFFE8EBED);
  static const divider = Color(0xFFF2F4F5);

  static const success = Color(0xFF4CAF50);
  static const warning = Color(0xFFFFC107);
  static const error = Color(0xFFFF5252);
  static const errorLight = Color(0xFFFFD9D9);

  static const focus = Color(0xFF2F80ED);
  static const focusLight = Color(0xFFD6E4FF);

  static const gradientStart = Color(0xFF5B5FED);
  static const gradientEnd = Color(0xFF8B5FED);
}

class AppSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 48.0;
}

class AppRadius {
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 24.0;
  static const full = 999.0;
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: AppTypography.fontFamily,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
      ),
    );
  }
}