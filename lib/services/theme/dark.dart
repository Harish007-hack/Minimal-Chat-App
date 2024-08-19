import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
  colorScheme: ColorScheme.dark(
    brightness: Brightness.light,
    surface: Colors.grey.shade800,
    primary: Colors.grey.shade900,
    secondary: Colors.grey.shade700,
    tertiary: Colors.grey.shade500,
    inversePrimary: Colors.grey.shade200,
  ),
  textTheme: const TextTheme().apply(
    bodyColor: Colors.grey.shade400,
    displayColor: Colors.grey.shade400,
  ),
);
