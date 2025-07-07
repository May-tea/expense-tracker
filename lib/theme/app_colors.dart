import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color lightSeedColor = Color.fromARGB(255, 96, 59, 181);
  static const Color darkSeedColor = Color.fromARGB(255, 5, 99, 125);

  static final ColorScheme lightColorScheme = ColorScheme.fromSeed(
    seedColor: lightSeedColor,
  );

  static final ColorScheme darkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: darkSeedColor,
  );
}
