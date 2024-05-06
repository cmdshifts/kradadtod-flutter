import 'package:flutter/material.dart';
import 'package:kradadtod/utils/constants/colors.dart';

class KAppTextButtonTheme {
  KAppTextButtonTheme._();

  static TextButtonThemeData lightTextButtonTheme = TextButtonThemeData(
      style: TextButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: KAppColors.azure,
          disabledForegroundColor: KAppColors.azure,
          disabledBackgroundColor: Colors.grey.shade400,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          textStyle:
          const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0))));

  static TextButtonThemeData darkTextButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: KAppColors.azure,
      disabledForegroundColor: KAppColors.azure,
      disabledBackgroundColor: Colors.grey.shade400,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      textStyle:
      const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
  );
}
