import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Define our strict palette
  static const Color _black = Color(0xFF000000);
  static const Color _white = Color(0xFFFFFFFF);
  static const Color _lightGray = Color(0xFFF20F2F); // For subtle backgrounds
  static const Color _mediumGray = Color(0xFF666666); // For secondary text

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: _white,
      primaryColor: _black,
      
      // Typography: Using Inter (a modern Swiss-style grotesque font)
      textTheme: GoogleFonts.interTextTheme().copyWith(
        displayLarge: const TextStyle(
          color: _black,
          fontWeight: FontWeight.w900, // Bold "Swiss" headers
          letterSpacing: -1.5,
        ),
        bodyLarge: const TextStyle(color: _black, fontSize: 16),
        bodyMedium: const TextStyle(color: _mediumGray, fontSize: 14),
      ),

      // AppBar: Flat and minimal
      appBarTheme: const AppBarTheme(
        backgroundColor: _white,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: _black),
        titleTextStyle: TextStyle(
          color: _black,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),

      // Buttons: High contrast, rectangular (Swiss design avoids soft rounds)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _black,
          foregroundColor: _white,
          minimumSize: const Size(double.infinity, 56),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // Sharp corners for Swiss look
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ),

      // Input Decoration: Simple underlines or thin borders
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: _white,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: _black, width: 2),
          borderRadius: BorderRadius.zero,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _black, width: 1),
          borderRadius: BorderRadius.zero,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _black, width: 2.5),
          borderRadius: BorderRadius.zero,
        ),
        labelStyle: TextStyle(color: _black),
      ),

      // Card Design: Zero elevation, thin border
      cardTheme: CardThemeData(
        color: _white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: _black, width: 1),
          borderRadius: BorderRadius.zero,
        ),
      ),

      // Floating Action Button
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _black,
        foregroundColor: _white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
    );
  }
}