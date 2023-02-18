import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_images.dart';

abstract class MainTheme {
  static const String themeKey = "theme";
  static const String lightThemeKey = "light";
  static const String darkThemeKey = "dark";
  static final Logger _logger = Logger("MainTheme");

  static ThemeData light = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: Color.fromARGB(255, 82, 222, 154),
      onPrimary: Colors.black,
      secondary: Color.fromARGB(255, 255, 217, 80),
      surface: Color.fromRGBO(246, 246, 246, 1),
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

  static ThemeData dark = ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: Color.fromRGBO(193, 213, 216, 1),
      onPrimary: Colors.black,
      secondary: Color.fromRGBO(237, 164, 55, 1),
      onSecondary: Colors.black,
      surface: Color.fromRGBO(234, 234, 234, 1),
      onSurface: Colors.black,
      background: Color.fromRGBO(234, 234, 234, 1),
      onBackground: Colors.black,
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

  /// Reruns current saved [ThemeData].
  ///
  /// Default theme is light.
  static Future<ThemeData> getTheme() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(themeKey)) {
      // there is a selected theme
      return prefs.getString(themeKey) == lightThemeKey ? light : dark;
    } else {
      // not selected theme
      prefs.setString(themeKey, lightThemeKey);
      return light;
    }
  }

  /// Saves theme in [SharedPreferences].
  ///
  /// This method didnt set theme for app.
  static void saveTheme(bool isLight) {
    SharedPreferences.getInstance().then(
      (value) => value.setString(MainTheme.themeKey,
          isLight ? MainTheme.lightThemeKey : MainTheme.darkThemeKey),
      onError: (error, stackTrace) =>
          _logger.severe("Theme prefs save failed.", error, stackTrace),
    );
  }
}
