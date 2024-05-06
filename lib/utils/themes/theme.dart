import 'package:flutter/material.dart';
import 'package:kradadtod/utils/constants/colors.dart';
import 'package:kradadtod/utils/themes/ui/appBarTheme.dart';
import 'package:kradadtod/utils/themes/ui/choiceChipTheme.dart';
import 'package:kradadtod/utils/themes/ui/datePickerTheme.dart';
import 'package:kradadtod/utils/themes/ui/elevatedButtonTheme.dart';
import 'package:kradadtod/utils/themes/ui/iconButtonTheme.dart';
import 'package:kradadtod/utils/themes/ui/textButtonTheme.dart';
import 'package:kradadtod/utils/themes/ui/textFieldTheme.dart';
import 'package:kradadtod/utils/themes/ui/textSelectionTheme.dart';
import 'package:kradadtod/utils/themes/ui/textTheme.dart';

class KAppTheme {
  KAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    textTheme: KAppTextTheme.lightTextTheme,
    brightness: Brightness.light,
    primaryColor: KAppColors.azure,
    appBarTheme: KAppBarTheme.lightAppBarTheme,
    elevatedButtonTheme: KAppElevatedButtonTheme.lightElevatedButtonTheme,
    textButtonTheme: KAppTextButtonTheme.lightTextButtonTheme,
    inputDecorationTheme: KAppTextFieldTheme.lightInputDecorationTheme,
    textSelectionTheme: KAppTextSelectionTheme.lightTextSelectionTheme,
    iconButtonTheme: KAppIconButtonTheme.lightIconButtonTheme,
    chipTheme: KAppChoiceTheme.lightChipTheme,
    datePickerTheme: KAppDatePickerTheme.lightDatePickerThemeData,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    textTheme: KAppTextTheme.lightTextTheme,
    brightness: Brightness.light,
    primaryColor: KAppColors.azure,
    appBarTheme: KAppBarTheme.lightAppBarTheme,
    elevatedButtonTheme: KAppElevatedButtonTheme.lightElevatedButtonTheme,
    textButtonTheme: KAppTextButtonTheme.lightTextButtonTheme,
    inputDecorationTheme: KAppTextFieldTheme.lightInputDecorationTheme,
    textSelectionTheme: KAppTextSelectionTheme.lightTextSelectionTheme,
    iconButtonTheme: KAppIconButtonTheme.lightIconButtonTheme,
    chipTheme: KAppChoiceTheme.lightChipTheme,
    datePickerTheme: KAppDatePickerTheme.lightDatePickerThemeData,
  );
}
