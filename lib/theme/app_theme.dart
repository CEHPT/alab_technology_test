import 'package:flutter/material.dart';

class AppTheme {
  // Light Theme Colors
  static const Color _lightPrimary = Color(0xFF6C63FF);
  static const Color _lightPrimaryVariant = Color(0xFF9D4EDD);
  static const Color _lightSecondary = Color(0xFF4CAF50);
  static const Color _lightBackground = Color(0xFFFFFFFF);
  static const Color _lightSurface = Color(0xFFF8F9FA);
  static const Color _lightError = Color(0xFFE53935);
  static const Color _lightOnPrimary = Colors.white;
  static const Color _lightOnSecondary = Colors.white;
  static const Color _lightOnBackground = Color(0xFF1A1A1A);
  static const Color _lightOnSurface = Color(0xFF1A1A1A);
  static const Color _lightOnError = Colors.white;

  // Dark Theme Colors
  static const Color _darkPrimary = Color(0xFF8B80FF);
  static const Color _darkPrimaryVariant = Color(0xFFB47CFF);
  static const Color _darkSecondary = Color(0xFF66BB6A);
  static const Color _darkBackground = Color(0xFF121212);
  static const Color _darkSurface = Color(0xFF1E1E1E);
  static const Color _darkError = Color(0xFFCF6679);
  static const Color _darkOnPrimary = Colors.black;
  static const Color _darkOnSecondary = Colors.black;
  static const Color _darkOnBackground = Colors.white;
  static const Color _darkOnSurface = Colors.white;
  static const Color _darkOnError = Colors.black;

  // Text Themes
  static TextTheme get _lightTextTheme {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: _lightOnBackground,
        letterSpacing: -0.5,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: _lightOnBackground,
        letterSpacing: -0.5,
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: _lightOnBackground,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: _lightOnBackground,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: _lightOnBackground,
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: _lightOnBackground,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: _lightOnBackground.withOpacity(0.8),
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: _lightOnBackground.withOpacity(0.7),
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: _lightOnPrimary,
      ),
    );
  }

  static TextTheme get _darkTextTheme {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: _darkOnBackground,
        letterSpacing: -0.5,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: _darkOnBackground,
        letterSpacing: -0.5,
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: _darkOnBackground,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: _darkOnBackground,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: _darkOnBackground,
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: _darkOnBackground,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: _darkOnBackground.withOpacity(0.8),
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: _darkOnBackground.withOpacity(0.7),
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: _darkOnPrimary,
      ),
    );
  }

  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: _lightPrimary,
        primaryContainer: _lightPrimaryVariant,
        secondary: _lightSecondary,
        background: _lightBackground,
        surface: _lightSurface,
        error: _lightError,
        onPrimary: _lightOnPrimary,
        onSecondary: _lightOnSecondary,
        onBackground: _lightOnBackground,
        onSurface: _lightOnSurface,
        onError: _lightOnError,
      ),
      textTheme: _lightTextTheme,
      scaffoldBackgroundColor: _lightBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: _lightBackground,
        elevation: 0,
        foregroundColor: _lightOnBackground,
        titleTextStyle: _lightTextTheme.headlineSmall,
        iconTheme: const IconThemeData(color: _lightPrimary),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: _lightSurface,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _lightSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: _lightPrimary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: _lightError),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _lightPrimary,
          foregroundColor: _lightOnPrimary,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: _lightTextTheme.labelLarge,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _lightPrimary,
        foregroundColor: _lightOnPrimary,
      ),
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: _darkPrimary,
        primaryContainer: _darkPrimaryVariant,
        secondary: _darkSecondary,
        background: _darkBackground,
        surface: _darkSurface,
        error: _darkError,
        onPrimary: _darkOnPrimary,
        onSecondary: _darkOnSecondary,
        onBackground: _darkOnBackground,
        onSurface: _darkOnSurface,
        onError: _darkOnError,
      ),
      textTheme: _darkTextTheme,
      scaffoldBackgroundColor: _darkBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: _darkBackground,
        elevation: 0,
        foregroundColor: _darkOnBackground,
        titleTextStyle: _darkTextTheme.headlineSmall,
        iconTheme: const IconThemeData(color: _darkPrimary),
      ),
      cardTheme: CardTheme(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: _darkSurface,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _darkSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: _darkPrimary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: _darkError),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _darkPrimary,
          foregroundColor: _darkOnPrimary,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: _darkTextTheme.labelLarge,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _darkPrimary,
        foregroundColor: _darkOnPrimary,
      ),
    );
  }
}