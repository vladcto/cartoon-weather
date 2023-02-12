import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_images.dart';

abstract class MainTheme {
  static const String themeKey = "theme";
  static const String lightThemeKey = "light";
  static const String darkThemeKey = "dark";

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

  static ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: Color.fromRGBO(193, 213, 216, 1),
      onPrimary: Colors.black,
      secondary: Color.fromRGBO(237, 164, 55, 1),
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

  static Future<ThemeData> getTheme() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(themeKey)) {
      // there is a selected theme
      if (prefs.getString(themeKey) == lightThemeKey) {
        return lightTheme;
      } else {
        return darkTheme;
      }
    } else {
      // not selected theme
      prefs.setString(themeKey, lightThemeKey);
      return lightTheme;
    }
  }
}
