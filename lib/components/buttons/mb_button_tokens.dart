import 'package:flutter/material.dart';

abstract final class MBButtonColors {
  static const primary = Color(0xFF6ABA02);
  static const primaryDark = Color(0xFF1F6607);
  static const primaryLight = Color(0xFFBFF578);
  static const mainRed = Color(0xFFD8023F);
  static const mainBlue = Color(0xFF007AFF);
  static const border = Color(0xFFE5E7EB);
  static const backgroundAlt = Color(0xFFFAFAFA);
  static const text = Color(0xFF111827);
  static const textSecondary = Color(0xFF6B7280);
  static const white = Color(0xFFFFFFFF);
  static const neutral100 = Color(0xFFF3F4F6);
  static const neutral200 = Color(0xFFE5E7EB);
  static const neutral800 = Color(0xFF1F2937);
  static const disabledText = Color(0xFF9CA3AF);
}

const _fontFamily = 'SFMono';

TextStyle mbButtonTextStyle({
  required double fontSize,
  required Color color,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: _fontFamily,
    fontWeight: fontWeight,
    letterSpacing: -0.5,
  );
}
