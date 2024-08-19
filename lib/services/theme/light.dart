import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  colorScheme: ColorScheme.light(
    brightness: Brightness.light,
    surface: Colors.grey.shade300,
    primary: Colors.grey.shade200,
    secondary: Colors.grey.shade400,
    tertiary: Colors.grey.shade500,
    inversePrimary: Colors.grey.shade800,
  ),
  textTheme: const TextTheme().apply(
    bodyColor: Colors.grey.shade600,
    displayColor: Colors.grey.shade600,
  ),
);
