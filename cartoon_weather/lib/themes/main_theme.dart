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
    textTheme: TextTheme(
      labelLarge: const TextStyle(
        fontSize: 23,
        fontFamily: "Inter",
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      labelMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w900,
        fontFamily: "Inter",
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.3
          ..strokeJoin = StrokeJoin.round
          ..color = Color.fromARGB(255, 30, 30, 30),
      ),
    ),
    extensions: const [
      ThemeImages.basic,
    ],
  );
}
