import 'package:flutter/material.dart';
import 'package:nudge_app/domain/config/theme/app_color.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Define raleway text theme for the entire app
  static TextTheme _buildTextTheme(TextTheme base, Color textColor) {
    return GoogleFonts.ralewayTextTheme(base).copyWith(
      headlineLarge: GoogleFonts.raleway(
        textStyle: base.headlineLarge,
        color: textColor,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: GoogleFonts.raleway(
        textStyle: base.headlineMedium,
        color: textColor,
        fontWeight: FontWeight.w600,
      ),

      bodyLarge: GoogleFonts.raleway(
        textStyle: base.bodyLarge,
        color: textColor,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: GoogleFonts.raleway(
        textStyle: base.bodyMedium,
        color: textColor,
        fontWeight: FontWeight.w600,
      ),
      bodySmall: GoogleFonts.raleway(
        textStyle: base.bodySmall,
        color: textColor,
        fontWeight: FontWeight.w300,
      ),

      labelLarge: GoogleFonts.raleway(
        textStyle: base.labelLarge,
        color: textColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  // Light theme
  static ThemeData get lightTheme {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      brightness: Brightness.light,
      primaryColor: AppColor.accent,
      scaffoldBackgroundColor: AppColor.light,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.light,
        foregroundColor: AppColor.dark,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColor.accent,
        selectionColor: AppColor.accent.withValues(alpha: .2),
        selectionHandleColor: AppColor.accent,
      ),
      textTheme: _buildTextTheme(base.textTheme, Colors.black),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme, Colors.black),
      // Add these properties for monochrome ListTiles
      splashColor: Colors.grey.withValues(alpha: .1),
      splashFactory: InkRipple.splashFactory,
      listTileTheme: const ListTileThemeData(
        tileColor: Colors.transparent,
        selectedTileColor: Color(0xFFF5F5F5), // Light grey for selected
        iconColor: AppColor.dark,
        textColor: AppColor.dark,
        selectedColor: AppColor.dark, // Keep text dark even when selected
        contentPadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
      ),
    );
  }

  // Dark theme
  static ThemeData get darkTheme {
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      brightness: Brightness.dark,
      primaryColor: AppColor.accent,
      scaffoldBackgroundColor: AppColor.dark,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.dark,
        foregroundColor: AppColor.light,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColor.accent,
        selectionColor: AppColor.accent.withValues(alpha: .2),
        selectionHandleColor: AppColor.accent,
      ),
      textTheme: _buildTextTheme(base.textTheme, Colors.white),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme, Colors.white),
      // Add these properties for monochrome ListTiles
      splashColor: Colors.white.withValues(alpha: .1),
      splashFactory: InkRipple.splashFactory,
      listTileTheme: const ListTileThemeData(
        tileColor: Colors.transparent,
        selectedTileColor: Color(0xFF333333), // Dark grey for selected
        iconColor: AppColor.light,
        textColor: AppColor.light,
        selectedColor: AppColor.light, // Keep text light even when selected
        contentPadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
      ),
    );
  }
}
