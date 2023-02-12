import 'package:cartoon_weather/themes/main_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainThemeStateNotifier extends StateNotifier<ThemeData> {
  bool isLight = true;

  MainThemeStateNotifier(super._state);

  void changeTheme() {
    isLight = !isLight;
    state = isLight ? MainTheme.lightTheme : MainTheme.darkTheme;
    SharedPreferences.getInstance().then(
      (value) => value.setString(MainTheme.themeKey,
          isLight ? MainTheme.lightThemeKey : MainTheme.darkThemeKey),
    );
  }
}
