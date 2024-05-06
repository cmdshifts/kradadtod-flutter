import 'package:flutter/material.dart';

class KAppTextFieldTheme {
  KAppTextFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    filled: true,
    fillColor: Colors.white.withOpacity(0.8),
    prefixIconColor: Colors.black,
    suffixIconColor: Colors.black,
    labelStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.black),
    hintStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.black),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(
      color: Colors.black.withOpacity(0.8),
    ),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(width: 1, color: Colors.black),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(width: 1, color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(width: 1, color: Colors.deepOrange),
    ),
  );
}
