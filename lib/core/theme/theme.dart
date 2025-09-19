//contains entire app's theme
import 'package:flutter/material.dart';
import 'package:freelancer_visuals/core/theme/app_pallete.dart';

class AppTheme {
  static _border([Color color = AppPallete.lightEnabledBorder]) =>
      OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 3),
        borderRadius: BorderRadius.circular(15),
      );
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.darkBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppPallete.darkBackgroundColor,
      surfaceTintColor: AppPallete.darkBackgroundColor,
    ),
    primaryColor: AppPallete.primary,
    colorScheme: const ColorScheme.dark(
      surface: AppPallete.darkSurface,
      primary: AppPallete.primary,
      secondary: AppPallete.darkSecondarySurface,
      error: AppPallete.darkError,
      tertiary: AppPallete.darkSuccess,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(15),
      enabledBorder: _border(),
      focusedBorder: _border(Colors.white),
    ),
  );
  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppPallete.lightBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppPallete.lightBackgroundColor,
      surfaceTintColor: AppPallete.lightBackgroundColor,
    ),
    primaryColor: AppPallete.primary,
    colorScheme: ColorScheme.light(
      surface: AppPallete.lightSurface,
      primary: AppPallete.primary,
      secondary: AppPallete.lightSecondarySurface,
      onPrimary: Colors.white,
      onSurface: AppPallete.lightTextSecondary,
      error: AppPallete.lightError,
      tertiary: AppPallete.lightSuccess,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(15),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.lightFocusedBorder),
    ),
  );
}
