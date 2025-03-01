import 'package:flutter/material.dart';
import 'package:nudge_app/domain/config/theme/app_color.dart';

class AppTheme {
  static final lightTheme = ThemeData(
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
      selectionColor: AppColor.accent.withValues(alpha: 0.3),
      selectionHandleColor: AppColor.accent,
    ),
  );

  static final darkTheme = ThemeData(
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
  );
}
