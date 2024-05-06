import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KAppTextTheme {
  KAppTextTheme._();

  static TextTheme lightTextTheme = const TextTheme().copyWith(
    headlineLarge: GoogleFonts.poppins(
        fontSize: 32.0, fontWeight: FontWeight.w700, color: Colors.black),
    headlineMedium: GoogleFonts.poppins(
        fontSize: 24.0, fontWeight: FontWeight.w700, color: Colors.black),
    headlineSmall: GoogleFonts.poppins(
        fontSize: 18.0, fontWeight: FontWeight.w700, color: Colors.black),
    titleLarge: GoogleFonts.poppins(
        fontSize: 16.0, fontWeight: FontWeight.w700, color: Colors.black),
    titleMedium: GoogleFonts.poppins(
        fontSize: 14.0, fontWeight: FontWeight.w700, color: Colors.black),
    titleSmall: GoogleFonts.poppins(
        fontSize: 12.0, fontWeight: FontWeight.w700, color: Colors.black),
    bodyLarge: GoogleFonts.poppins(
        fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black),
    bodyMedium: GoogleFonts.poppins(
        fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.black),
    bodySmall: GoogleFonts.poppins(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: Colors.black.withOpacity(0.75)),
    labelLarge: GoogleFonts.poppins(
        fontSize: 12.0, fontWeight: FontWeight.w500, color: Colors.black),
    labelMedium: GoogleFonts.poppins(
        fontSize: 12.0, fontWeight: FontWeight.w400, color: Colors.black),
    labelSmall: GoogleFonts.poppins(
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        color: Colors.black.withOpacity(0.50)),
  );
}
