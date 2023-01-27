import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'themes/main_theme.dart';

void main() {
  runApp(
    MaterialApp(
      theme: MainTheme.lightTheme,
      home: const HomePage(),
    ),
  );
}
