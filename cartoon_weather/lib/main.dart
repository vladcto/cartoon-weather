import 'package:cartoon_weather/detail_page.dart';
import 'package:cartoon_weather/main_page_separator.dart';
import 'package:cartoon_weather/small_weather_card.dart';
import 'package:flutter/material.dart';
import 'main_weather_card.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      "/": (context) => const HomePage(),
      "/detail_report": (_) => const DetailPage(),
    },
    initialRoute: "/",
    theme: HomePage.lightTheme,
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
          fontSize: 23,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        labelMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w900,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.3
            ..strokeJoin = StrokeJoin.round
            ..color = Color.fromARGB(255, 30, 30, 30),
        )),
  );

  static const List<Widget> smallBroadcastsTest = [
    SmallWeatherCard("12 Sep", "21/17 C"),
    SmallWeatherCard("13 Sep", "20/16 C"),
    SmallWeatherCard("14 Sep", "17/14 C"),
    SmallWeatherCard("15 Sep", "15/10 C"),
    SmallWeatherCard("16 Sep", "18/16 C"),
  ];

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              children: [
                _buildLocationPicker(context),
                const MainWeatherCard(),
                const MainPageSeparator("Next Days"),
              ],
            ),
          ),
          SizedBox(
            height: 156,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              clipBehavior: Clip.none,
              itemCount: smallBroadcastsTest.length,
              itemBuilder: (context, index) => smallBroadcastsTest[index],
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              scrollDirection: Axis.horizontal,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: MainPageSeparator("Rain"),
          ),
        ],
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
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Center(
                child: Text(
                  "Saint-Petersburg",
                  overflow: TextOverflow.visible,
                  style: nowTheme.textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
