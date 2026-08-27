import 'package:flutter/material.dart';

abstract final class AppRadius {
  static const xs = 2.0;
  static const sm = 6.0;
  static const medium = 8.0;
  static const lg = 10.0;
  static const xl = 12.0;
  static const compact = 14.0;
  static const xxl = 16.0;
  static const xxxl = 20.0;
  static const round = 24.0;
  static const full = 999.0;

  static const allSmall = BorderRadius.all(Radius.circular(sm));
  static const allMedium = BorderRadius.all(Radius.circular(medium));
  static const allLarge = BorderRadius.all(Radius.circular(xl));
  static const allXLarge = BorderRadius.all(Radius.circular(xxl));
  static const allFull = BorderRadius.all(Radius.circular(full));

  static const topSheet = BorderRadius.only(
    topLeft: Radius.circular(xxl),
    topRight: Radius.circular(xxl),
  );
}
