import 'dart:convert';

import 'package:cartoon_weather/controlers/weather_forecast_controler.dart';
import 'package:cartoon_weather/helpers/logger_helper.dart';
import 'package:cartoon_weather/models/weather_forecast.dart';
import 'package:cartoon_weather/providers/main_providers.dart';
import 'package:cartoon_weather/providers/main_theme_state_notifier.dart';
import 'package:cartoon_weather/providers/weather_forecast_state_notifier.dart';
import 'package:cartoon_weather/pages/location_picker_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pages/home_page.dart';
import 'themes/main_theme.dart';

void main() async {
  LoggerHelper.init();

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WeatherForecast forecast = await WeatherForecastControler.initializeForecast();
  var theme = await MainTheme.getTheme();
  FlutterNativeSplash.remove();

  runApp(
    ProviderScope(
      overrides: [
        forecastProvider
            .overrideWith((ref) => WeatherForecastStateNotifier(forecast)),
        themeProvider.overrideWith((ref) => MainThemeStateNotifier(theme)),
      ],
      child: Consumer(
        builder: (context, ref, child) => MaterialApp(
          theme: ref.watch(themeProvider),
          home: const HomePage(),
        ),
      ),
    ),
  );
}
