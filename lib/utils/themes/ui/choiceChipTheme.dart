import 'package:flutter/material.dart';

class KAppChoiceTheme {
  KAppChoiceTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    elevation: 0.0,
    disabledColor: Colors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: Colors.black),
    selectedColor: Colors.black,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    checkmarkColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
      side: BorderSide.none,
    ),
  );
}
