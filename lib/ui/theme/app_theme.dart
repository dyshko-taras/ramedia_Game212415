// path: lib/ui/theme/app_theme.dart
import 'package:code/ui/theme/app_colors.dart';
import 'package:code/ui/theme/app_fonts.dart';
import 'package:flutter/material.dart';

/// Single Material 3 theme bound to Visual Guide sizes & colors.
final ThemeData appTheme = _buildTheme();

ThemeData _buildTheme() {
  const scheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    secondary: AppColors.primary,
    onSecondary: AppColors.onPrimary,
    error: Color(0xFFB00020),
    onError: AppColors.white,
    surface: AppColors.surface,
    onSurface: AppColors.onSurface,
  );

  // Map TextTheme roughly to our enumerated sizes for convenience in non-BalooText usages.
  const family = AppFonts.family;

  const textTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: family,
      fontSize: FontSizes.score64,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      fontFamily: family,
      fontSize: FontSizes.label40,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: TextStyle(
      fontFamily: family,
      fontSize: FontSizes.button32,
      fontWeight: FontWeight.w400,
    ),
    headlineLarge: TextStyle(
      fontFamily: family,
      fontSize: FontSizes.dialog24,
      fontWeight: FontWeight.w400,
    ),
    headlineMedium: TextStyle(
      fontFamily: family,
      fontSize: FontSizes.caption20,
      fontWeight: FontWeight.w400,
    ),
    headlineSmall: TextStyle(
      fontFamily: family,
      fontSize: FontSizes.dialogLong14,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
      fontFamily: family,
      fontSize: FontSizes.caption20,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      fontFamily: family,
      fontSize: FontSizes.dialog24,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      fontFamily: family,
      fontSize: FontSizes.button32,
      fontWeight: FontWeight.w400,
    ),
    bodyLarge: TextStyle(
      fontFamily: family,
      fontSize: FontSizes.caption20,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontFamily: family,
      fontSize: FontSizes.dialogLong14,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontFamily: family,
      fontSize: FontSizes.info10,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: TextStyle(
      fontFamily: family,
      fontSize: FontSizes.button32,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(
      fontFamily: family,
      fontSize: FontSizes.dialogLong14,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      fontFamily: family,
      fontSize: FontSizes.info10,
      fontWeight: FontWeight.w400,
    ),
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: scheme.surface,
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: textTheme.titleLarge?.copyWith(color: scheme.onSurface),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: scheme.primary),
  );
}
