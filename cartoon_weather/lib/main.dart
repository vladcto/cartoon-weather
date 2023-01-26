import 'package:cartoon_weather/pages/detail_page.dart';
import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'themes/main_theme.dart';

void main() {
  runApp(
    MaterialApp(
      routes: {
        "/": (context) => const HomePage(),
        "/detail_report": (_) => const DetailPage(),
      },
      initialRoute: "/",
      theme: MainTheme.lightTheme,
    ),
  );
}
