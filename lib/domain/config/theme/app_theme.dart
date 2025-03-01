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
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.raleway(
        textStyle: base.bodyMedium,
        color: textColor,
        fontWeight: FontWeight.w500,
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
      highlightColor: AppColor.accent,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColor.accent,
        selectionColor: AppColor.accent.withValues(alpha: .3),
        selectionHandleColor: AppColor.accent,
      ),
      textTheme: _buildTextTheme(base.textTheme, Colors.black),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme, Colors.black),
      primaryColorLight: AppColor.light,
      primaryColorDark: AppColor.dark,
      iconButtonTheme: IconButtonThemeData(),
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
        selectionColor: AppColor.accent.withValues(alpha: .3),
        selectionHandleColor: AppColor.accent,
      ),
      textTheme: _buildTextTheme(base.textTheme, Colors.white),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme, Colors.white),
    );
  }
}
