import 'package:cartoon_weather/themes/main_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainThemeStateNotifier extends StateNotifier<ThemeData> {
  static final Logger _logger = Logger("MainThemeStateNotifier");

  MainThemeStateNotifier(super._state);

  void changeTheme(bool isLight) {
    state = isLight ? MainTheme.lightTheme : MainTheme.darkTheme;
    SharedPreferences.getInstance().then(
      (value) => value.setString(MainTheme.themeKey,
          isLight ? MainTheme.lightThemeKey : MainTheme.darkThemeKey),
      onError: (error, stackTrace) =>
          _logger.severe("Theme prefs save failed.", error, stackTrace),
    );
  }

  bool get isLight {
    return state == MainTheme.lightTheme;
  }
}
