import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData
  (
    colorScheme: ColorScheme.dark(
      surface: Colors.grey.shade900,
      primary: Colors.grey,
      onPrimary: Colors.grey.shade300,
      secondary: Color.fromARGB(255, 57, 57, 57),
      tertiary: Colors.grey.shade300,
      inversePrimary: Colors.grey.shade800,
    )
);