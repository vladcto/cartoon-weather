import 'package:cartoon_weather/models/weather_forecast.dart';
import 'package:cartoon_weather/providers/main_theme_state_notifier.dart';
import 'package:cartoon_weather/providers/weather_forecast_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../themes/main_theme.dart';

final forecastProvider =
    StateNotifierProvider<WeatherForecastStateNotifier, WeatherForecast>(
  (ref) => throw UnimplementedError(),
);

final themeProvider = StateNotifierProvider<MainThemeStateNotifier, ThemeData>(
  (ref) => MainThemeStateNotifier(MainTheme.light),
);
