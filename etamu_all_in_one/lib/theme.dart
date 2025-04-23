// lib/theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ETAMUTheme {
  // Color Palette
  static const Color primary = Color(0xFF002147);
  static const Color secondary = Color(0xFFF9B300);
  static const Color background = Color(0xFFF5F6FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1C1C1E);
  static const Color accent = Color(0xFF54A8FF);

  // Padding Tokens
  static const double paddingSm = 8.0;
  static const double paddingMd = 16.0;
  static const double paddingLg = 24.0;

  // Radius
  static const double cardRadius = 16.0;

  // Typography
  static TextTheme textTheme = TextTheme(
    headlineLarge: GoogleFonts.breeSerif(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: textPrimary,
    ),
    bodyMedium: GoogleFonts.inter(fontSize: 16, color: textPrimary),
    labelLarge: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: textPrimary,
    ),
  );

  // ThemeData
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: background,
    colorScheme: ColorScheme.light(
      primary: primary,
      secondary: secondary,
      background: background,
    ),
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: primary,
      titleTextStyle: GoogleFonts.breeSerif(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    cardTheme: CardTheme(
      color: surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(cardRadius),
      ),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.05),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
