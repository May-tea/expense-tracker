import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTheme {
  static const EdgeInsetsGeometry _cardMargin = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 8,
  );

  static final ThemeData lightTheme = ThemeData().copyWith(
    colorScheme: AppColors.lightColorScheme,
    appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: AppColors.lightColorScheme.onPrimaryContainer,
      foregroundColor: AppColors.lightColorScheme.primaryContainer,
    ),
    cardTheme: const CardThemeData().copyWith(
      color: AppColors.lightColorScheme.secondaryContainer,
      margin: _cardMargin,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightColorScheme.primaryContainer,
        foregroundColor: AppColors.lightColorScheme.onPrimaryContainer,
      ),
    ),
    textTheme: ThemeData().textTheme.copyWith(
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.lightColorScheme.onSecondaryContainer,
        fontSize: 16,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    colorScheme: AppColors.darkColorScheme,
    appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: AppColors.darkColorScheme.onPrimaryContainer,
      foregroundColor: AppColors.darkColorScheme.primaryContainer,
    ),
    cardTheme: const CardThemeData().copyWith(
      color: AppColors.darkColorScheme.secondaryContainer,
      margin: _cardMargin,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkColorScheme.primaryContainer,
        foregroundColor: AppColors.darkColorScheme.onPrimaryContainer,
      ),
    ),
    textTheme: ThemeData.dark().textTheme.copyWith(
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.darkColorScheme.onSecondaryContainer,
        fontSize: 16,
      ),
    ),
  );
}
