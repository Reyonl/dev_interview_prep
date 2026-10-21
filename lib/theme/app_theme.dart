import 'package:flutter/material.dart';

class AppTheme {
  // Palet Warna Developer Dark (Diselaraskan dengan Portfolio V2 Reyon)
  static const Color background = Color(0xFF090D16);
  static const Color surface = Color(0xFF111827);
  static const Color surfaceElevated = Color(0xFF1E293B);
  static const Color cardBorder = Color(0xFF26334D);

  static const Color accent = Color(0xFFFF8A3D); // Signature Orange/Amber
  static const Color success = Color(0xFF10B981); // Emerald Green
  static const Color error = Color(0xFFEF4444); // Crimson Red
  static const Color info = Color(0xFF06B6D4); // Cyan Blue
  static const Color warning = Color(0xFFF59E0B); // Amber Yellow

  static const Color textPrimary = Color(0xFFF9FAFB);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: accent,
      colorScheme: const ColorScheme.dark(
        primary: accent,
        secondary: info,
        surface: surface,
        error: error,
        onPrimary: Colors.black,
        onSurface: textPrimary,
      ),
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.2,
        ),
        iconTheme: IconThemeData(color: textPrimary),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: cardBorder, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: Colors.black,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textPrimary,
          side: const BorderSide(color: cardBorder),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
