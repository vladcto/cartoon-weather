import 'package:cartoon_weather/main_page_separator.dart';
import 'package:flutter/material.dart';
import 'main_weather_card.dart';

void main() {
  runApp(MaterialApp(
    theme: HomePage.lightTheme,
    home: const Scaffold(
      body: HomePage(),
    ),
  ));
}

class HomePage extends StatelessWidget {
  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: Color.fromARGB(255, 82, 222, 154),
      onPrimary: Colors.black,
      secondary: Color.fromARGB(255, 255, 217, 80),
    ),
    textTheme: TextTheme(
        labelLarge: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: Colors.black,
        ),
        labelMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w900,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.2
            ..strokeJoin = StrokeJoin.round
            ..color = Color.fromARGB(255, 30, 30, 30),
        )),
  );

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Weather Toon",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "Inter",
            ),
          ),
        ),
        shape: const Border(
          bottom: BorderSide(width: 2),
        ),
        elevation: 8,
      ),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildLocationPicker(context),
            const MainWeatherCard(),
            const MainPageSeparator("Hello"),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationPicker(BuildContext context) {
    var nowTheme = Theme.of(context);
    return SizedBox(
      height: 36,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Location: ",
            style: nowTheme.textTheme.labelLarge,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(10000),
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              child: Text(
                "Saint-Petersburg",
                overflow: TextOverflow.visible,
                style: nowTheme.textTheme.labelLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
