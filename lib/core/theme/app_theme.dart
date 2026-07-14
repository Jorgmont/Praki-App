import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Global theme controller to toggle modes reactively
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

  // Brand color tokens using HSL equivalent Color objects
  static const Color sageGreen = Color(0xFFDCEBE7); // Soft sage green (#DCEBE7)
  static const Color offWhite = Color(0xFFF6F0F0);  // Off-white/warm gray (#F6F0F0)
  static const Color warmBeige = Color(0xFFEEE3DF); // Warm light beige (#EEE3DF)

  static const Color primaryLight = Color(0xFF2E4D46);  // Soothing deep pine green for high contrast text/buttons
  static const Color secondaryLight = Color(0xFF4C7B71); // Soft sage-green accent
  static const Color primaryDark = Color(0xFFDCEBE7);   // Light sage green for high contrast in dark mode
  static const Color secondaryDark = Color(0xFF91B5AD);  // Soothing sage green accent

  // Backgrounds
  static const Color bgDark = Color(0xFF0F1614);      // Soothing very dark teal-gray
  static const Color surfaceDark = Color(0xFF1A2623); // Soothing dark container color
  static const Color bgLight = warmBeige;             // Warm light beige background
  static const Color surfaceLight = offWhite;         // Off-white card surface

  // Custom Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryDark,
      scaffoldBackgroundColor: bgDark,
      colorScheme: const ColorScheme.dark(
        primary: primaryDark,
        secondary: secondaryDark,
        surface: surfaceDark,
        onPrimary: bgDark,
        onSecondary: Colors.white,
        onSurface: Color(0xFFF1F5F9), // Slate 100
      ),
      textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme).copyWith(
        displayLarge: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
        titleLarge: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        bodyLarge: GoogleFonts.outfit(fontSize: 16, color: Color(0xFF94A3B8)), // Slate 400
        bodyMedium: GoogleFonts.outfit(fontSize: 14, color: Color(0xFFCBD5E1)), // Slate 300
      ),
      cardTheme: CardThemeData(
        color: surfaceDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: Color(0xFF2A3D39), width: 1.5), // Subtle dark sage border
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: bgDark,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryDark,
          foregroundColor: bgDark,
          elevation: 0,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // Custom Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryLight,
      scaffoldBackgroundColor: bgLight,
      colorScheme: const ColorScheme.light(
        primary: primaryLight,
        secondary: secondaryLight,
        surface: surfaceLight,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Color(0xFF0F172A), // Slate 900
      ),
      textTheme: GoogleFonts.outfitTextTheme(ThemeData.light().textTheme).copyWith(
        displayLarge: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
        titleLarge: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF0F172A)),
        bodyLarge: GoogleFonts.outfit(fontSize: 16, color: Color(0xFF475569)), // Slate 600
        bodyMedium: GoogleFonts.outfit(fontSize: 14, color: Color(0xFF64748B)), // Slate 500
      ),
      cardTheme: CardThemeData(
        color: surfaceLight,
        elevation: 4,
        shadowColor: const Color(0x08000000),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: sageGreen, width: 1.5), // Soothing light sage border
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: bgLight,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFF0F172A)),
        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryLight,
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: primaryLight.withValues(alpha: 0.3),
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
