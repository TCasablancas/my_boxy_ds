import 'package:flutter/material.dart';

class AppBoxDecorations {

  static BoxDecoration borderedBoxDecoration(Color color) {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: color,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }
}