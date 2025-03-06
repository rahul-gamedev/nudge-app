import 'package:flutter/material.dart';
import 'package:nudge_app/domain/config/theme/app_color.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Define rubik text theme for the entire app
  static TextTheme _buildTextTheme(TextTheme base, Color textColor) {
    return GoogleFonts.rubikTextTheme(base).copyWith(
      headlineLarge: GoogleFonts.rubik(
        textStyle: base.headlineLarge,
        color: textColor,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: GoogleFonts.rubik(
        textStyle: base.headlineMedium,
        color: textColor,
        fontWeight: FontWeight.w600,
      ),

      bodyLarge: GoogleFonts.rubik(
        textStyle: base.bodyLarge,
        color: textColor,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.rubik(
        textStyle: base.bodyMedium,
        color: textColor,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: GoogleFonts.rubik(
        textStyle: base.bodySmall,
        color: textColor,
        fontWeight: FontWeight.w300,
      ),

      labelLarge: GoogleFonts.rubik(
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
      // Add theming for loading indicators
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColor.accent,
        linearTrackColor: AppColor.accent.withValues(alpha: 0.2),
        circularTrackColor: AppColor.accent.withValues(alpha: 0.1),
        refreshBackgroundColor: Colors.grey[200],
      ),
      // Add theming for elevated buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.disabled)) {
              return Colors.grey[300]!;
            }
            if (states.contains(WidgetState.pressed)) {
              return AppColor.accent.withValues(alpha: 0.8);
            }
            return AppColor.accent;
          }),
          foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
          textStyle: WidgetStateProperty.all<TextStyle>(
            GoogleFonts.rubik(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          elevation: WidgetStateProperty.resolveWith<double>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.pressed)) {
              return 2;
            }
            return 1;
          }),
          overlayColor: WidgetStateProperty.all<Color>(
            Colors.white.withValues(alpha: 0.1),
          ),
        ),
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
      // Add theming for loading indicators
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColor.accent,
        linearTrackColor: AppColor.accent.withValues(alpha: 0.2),
        circularTrackColor: AppColor.accent.withValues(alpha: 0.1),
        refreshBackgroundColor: Colors.grey[800],
      ),
      // Add theming for elevated buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.disabled)) {
              return Colors.grey[700]!;
            }
            if (states.contains(WidgetState.pressed)) {
              return AppColor.accent.withValues(alpha: 0.8);
            }
            return AppColor.accent;
          }),
          foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
          textStyle: WidgetStateProperty.all<TextStyle>(
            GoogleFonts.rubik(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          elevation: WidgetStateProperty.resolveWith<double>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.pressed)) {
              return 2;
            }
            return 1;
          }),
          overlayColor: WidgetStateProperty.all<Color>(
            Colors.white.withValues(alpha: 0.1),
          ),
        ),
      ),
    );
  }
}
