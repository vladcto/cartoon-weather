import 'dart:convert';
import 'dart:developer' show log;

import 'package:cartoon_weather/models/weather_forecast.dart';
import 'package:cartoon_weather/providers/main_providers.dart';
import 'package:cartoon_weather/providers/weather_forecast_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/home_page.dart';
import 'themes/main_theme.dart';
import 'package:http/http.dart' as http;
import 'package:cartoon_weather/helpers/open_weather_helper.dart' as weather_helper;
import 'package:logging/logging.dart';

void main() async {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    log('${record.level.name}:[${record.loggerName}]: ${record.message}');
  });
  Logger.root.info("Logger initialized.");

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WeatherForecast forecast = await getCurrentForecast();
  FlutterNativeSplash.remove();

  runApp(
    ProviderScope(
      overrides: [
        forecastProvider
            .overrideWith((ref) => WeatherForecastStateNotifier(forecast)),
      ],
      child: MaterialApp(
        theme: MainTheme.lightTheme,
        home: const HomePage(),
      ),
    ),
  );
}

Future<WeatherForecast> getCurrentForecast() async {
  final Logger logger = Logger("main.dart");

  SharedPreferences prefs = await SharedPreferences.getInstance();
  DateTime? time = prefs.containsKey("time")
      ? DateTime.fromMillisecondsSinceEpoch(prefs.getInt("time")!)
      : null;

  if (time != null &&
      DateTime.now().toUtc().difference(time).inHours < 3 &&
      prefs.containsKey("forecast")) {
    logger.info("Initialize forecast from cache.");
    return WeatherForecast.fromJson(json.decode(
      prefs.getString("forecast")!,
    ));
  } else {
    // Get newer forecast and cache him.
    var apiResponse = await http.get(Uri.parse(weather_helper.createRequest(
      lon: 30.308611,
      lat: 59.937500,
      apiKey: "a7444ccaae8c1c644ca456ddd17cda66",
    )));
    logger.info("Initialize forecast from API.");
    WeatherForecast forecast =
        WeatherForecast.fromApiJson(jsonDecode(apiResponse.body));
    await prefs.setString("forecast", json.encode(forecast.toJson()));
    await prefs.setInt("time", forecast.dailyForecast[0].firstPeriodTime);
    return forecast;
  }
}
