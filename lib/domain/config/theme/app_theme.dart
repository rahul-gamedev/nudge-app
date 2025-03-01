import 'package:flutter/material.dart';
import 'package:nudge_app/domain/config/theme/app_color.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Define Montserrat text theme for the entire app
  static TextTheme _buildMontserratTextTheme(TextTheme base, Color textColor) {
    return GoogleFonts.montserratTextTheme(base).copyWith(
      headlineLarge: GoogleFonts.montserrat(
        textStyle: base.headlineLarge,
        color: textColor,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: GoogleFonts.montserrat(
        textStyle: base.headlineMedium,
        color: textColor,
        fontWeight: FontWeight.w500,
      ),

      bodyLarge: GoogleFonts.montserrat(
        textStyle: base.bodyLarge,
        color: textColor,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.montserrat(
        textStyle: base.bodyMedium,
        color: textColor,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: GoogleFonts.montserrat(
        textStyle: base.bodySmall,
        color: textColor,
        fontWeight: FontWeight.w300,
      ),

      labelLarge: GoogleFonts.montserrat(
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
      textTheme: _buildMontserratTextTheme(base.textTheme, Colors.black),
      primaryTextTheme: _buildMontserratTextTheme(
        base.primaryTextTheme,
        Colors.black,
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
        selectionColor: AppColor.accent.withValues(alpha: .3),
        selectionHandleColor: AppColor.accent,
      ),
      textTheme: _buildMontserratTextTheme(base.textTheme, Colors.white),
      primaryTextTheme: _buildMontserratTextTheme(
        base.primaryTextTheme,
        Colors.white,
      ),
    );
  }
}
