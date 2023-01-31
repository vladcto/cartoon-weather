import 'dart:convert';

import 'package:cartoon_weather/models/weather_forecast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'pages/home_page.dart';
import 'themes/main_theme.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  var apiResponse = await http.get(Uri.parse(
      "http://api.openweathermap.org/data/2.5/forecast?lat=59.937500&lon=30.308611&appid=a7444ccaae8c1c644ca456ddd17cda66"));
  WeatherForecast forecast =
      WeatherForecast.fromApiJson(jsonDecode(apiResponse.body));
  FlutterNativeSplash.remove();

  runApp(
    MaterialApp(
      theme: MainTheme.lightTheme,
      home: const HomePage(),
    ),
  );
}
