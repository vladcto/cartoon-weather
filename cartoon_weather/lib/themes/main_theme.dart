import 'package:flutter/material.dart';

import 'theme_images.dart';

class MainTheme {
  MainTheme._();

  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: Color.fromARGB(255, 82, 222, 154),
      onPrimary: Colors.black,
      secondary: Color.fromARGB(255, 255, 217, 80),
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(
        fontSize: 23,
        fontFamily: "Inter",
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      labelMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w900,
        fontFamily: "Inter",
        color: Colors.red,
      ),
    ),
    extensions: const [
      ThemeImages.basic,
    ],
  );
}
