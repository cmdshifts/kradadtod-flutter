import 'package:flutter/material.dart';
import 'package:kradadtod/utils/constants/colors.dart';

class KAppElevatedButtonTheme {
  KAppElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: KAppColors.azure,
      disabledForegroundColor: KAppColors.azure,
      disabledBackgroundColor: Colors.grey.shade400,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      textStyle: const TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36.0))
    )
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: KAppColors.azure,
          disabledForegroundColor: KAppColors.azure,
          disabledBackgroundColor: Colors.grey.shade400,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          textStyle: const TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36.0))
      )
  );
}