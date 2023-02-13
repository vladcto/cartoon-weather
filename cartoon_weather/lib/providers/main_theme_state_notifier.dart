import 'package:cartoon_weather/themes/main_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainThemeStateNotifier extends StateNotifier<ThemeData> {
  MainThemeStateNotifier(super._state);

  void changeTheme(bool isLight) {
    state = isLight ? MainTheme.lightTheme : MainTheme.darkTheme;
    MainTheme.saveTheme(isLight);
  }

  bool get isLight => state == MainTheme.lightTheme;
}
