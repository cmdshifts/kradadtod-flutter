import 'package:flutter/material.dart';
import 'package:kradadtod/utils/constants/colors.dart';

class KAppTextSelectionTheme {
  KAppTextSelectionTheme._();

  static TextSelectionThemeData lightTextSelectionTheme =
      TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.black.withOpacity(0.2),
    selectionHandleColor: Colors.black,
  );
}
