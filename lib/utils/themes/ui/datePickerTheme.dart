import 'package:flutter/material.dart';
import 'package:kradadtod/utils/constants/colors.dart';

class KAppDatePickerTheme {
  KAppDatePickerTheme._();

  static DatePickerThemeData lightDatePickerThemeData = DatePickerThemeData(
    elevation: 0,
    backgroundColor: Colors.white,
    todayBorder: const BorderSide(color: Colors.black, width: 1.0),
    cancelButtonStyle: TextButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.black,
      backgroundColor: Colors.grey.shade100.withOpacity(0.8),
      disabledForegroundColor: Colors.black.withOpacity(0.75),
      disabledBackgroundColor: Colors.grey.shade400,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    confirmButtonStyle: TextButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: KAppColors.azure,
      disabledForegroundColor: Colors.white.withOpacity(0.75),
      disabledBackgroundColor: KAppColors.azure.withOpacity(0.8),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
  );
}
