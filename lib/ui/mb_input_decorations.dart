import 'package:flutter/material.dart';

class AppInputDecorations {

  static InputDecoration transparentInput(IconButton? icon, String hint) {
    return InputDecoration(
      isDense: true,
      border: InputBorder.none,
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: const EdgeInsets.all(4),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black),
      suffixIcon: icon,
    );
  }
}