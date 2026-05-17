// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // --- Figma AI Token Palette Mapping ---
  static const Color background = Color(0xFFFFFFFF);
  static const Color foreground = Color(0xFF1A1D1E); // Premium Dark Slate
  static const Color card = Color(0xFFFFFFFF);
  
  static const Color primary = Color(0xFF2D5BFF); // Brand Cobalt Blue
  static const Color secondary = Color(0xFFF8F9FB); // Soft Cool Gray Surface
  static const Color mutedForeground = Color(0xFF6B7280); // Neutral Slate Gray
  static const Color destructive = Color(0xFFEF4444); // Error Red
  static const Color border = Color(0xFFE8E8E8); // Input & Card Structural Line

  // Border Radius Token: 0.75rem = 12px
  static const double radiusValue = 12.0;
  static final BorderRadius defaultRadius = BorderRadius.circular(radiusValue);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: secondary,
        surface: card,
        error: destructive,
        onPrimary: Colors.white,
        onSurface: foreground,
      ),

      // --- Typography Matching Figma Base Layer ---
      textTheme: TextTheme(
        displayLarge: GoogleFonts.spaceGrotesk(
          color: foreground,
          fontWeight: FontWeight.w500, // --font-weight-medium
          letterSpacing: -1.0,
        ),
        bodyLarge: GoogleFonts.inter(
          color: foreground,
          fontWeight: FontWeight.w400, // --font-weight-normal
          fontSize: 16,
        ),
        bodyMedium: GoogleFonts.inter(
          color: foreground,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: GoogleFonts.inter(
          color: mutedForeground,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),

      // --- Cards with Uniform Figma Radius ---
      cardTheme: CardThemeData(
        color: card,
        elevation: 0, 
        shape: RoundedRectangleBorder(
          borderRadius: defaultRadius,
          side: const BorderSide(color: border, width: 1.0),
        ),
      ),

      // --- Soft, Muted Inputs via Token Spec ---
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: secondary, // --input-background
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: GoogleFonts.spaceGrotesk(
          color: mutedForeground,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: defaultRadius,
          borderSide: const BorderSide(color: border, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: defaultRadius,
          borderSide: const BorderSide(color: border, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: defaultRadius,
          borderSide: const BorderSide(color: primary, width: 1.5), // Accent Ring
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: defaultRadius,
          borderSide: const BorderSide(color: destructive, width: 1.0),
        ),
      ),

      // --- Fluid Tech Action Buttons ---
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: defaultRadius,
          ),
          textStyle: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.w500, // --font-weight-medium
            fontSize: 16,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          textStyle: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),

      // --- Context sheets conforming to frame rules ---
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusValue)),
          side: BorderSide(color: border, width: 1.0),
        ),
        showDragHandle: true,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        iconTheme: IconThemeData(color: foreground, size: 24),
        titleTextStyle: TextStyle(
          color: foreground,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
    );
  }
}