// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Pure Swiss Minimalist Color Palette Constants
  static const Color starkWhite = Color(0xFFFFFFFF);
  static const Color inkBlack = Color(0xFF000000);
  static const Color neutralGray = Color(0xFFF5F5F5);
  static const Color borderGray = Color(0xFFE0E0E0);
  static const Color textMuted = Color(0xFF757575);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: starkWhite,
      primaryColor: inkBlack,
      
      // Stark typography hierarchy using clean grotesque type scales
      textTheme: TextTheme(
        displayLarge: GoogleFonts.spaceGrotesk(
          color: inkBlack,
          fontWeight: FontWeight.w900,
          letterSpacing: -1.5,
        ),
        bodyMedium: GoogleFonts.inter(
          color: inkBlack,
          fontWeight: FontWeight.w500,
        ),
        bodySmall: GoogleFonts.inter(
          color: textMuted,
          fontWeight: FontWeight.w400,
        ),
      ),

      // Hard-edged card components with zero elevation and solid raw borders
      cardTheme: CardThemeData(
        color: starkWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0), // Sharp Swiss geometry
          side: const BorderSide(color: inkBlack, width: 2.0),
        ),
      ),

      // Stark, high-contrast inputs with clean structural framing
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: neutralGray,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: GoogleFonts.spaceGrotesk(
          color: inkBlack,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: inkBlack, width: 2.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: borderGray, width: 1.5),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: inkBlack, width: 2.5),
        ),
      ),

      // Flat, raw block-style action buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: inkBlack,
          foregroundColor: starkWhite,
          elevation: 0, // No soft shadows
          minimumSize: const Size.fromHeight(56), // Full horizontal block width
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // Flat geometry edge
          ),
          textStyle: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            letterSpacing: 2.0,
          ),
        ),
      ),

      // High-contrast clean icon configurations
      appBarTheme: const AppBarTheme(
        backgroundColor: starkWhite,
        elevation: 0,
        iconTheme: IconThemeData(color: inkBlack, size: 24),
        titleTextStyle: TextStyle(
          color: inkBlack,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}