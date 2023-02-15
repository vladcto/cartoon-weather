import 'package:cartoon_weather/models/weather_daily_forecast.dart';
import 'package:cartoon_weather/providers/main_providers.dart';
import 'package:cartoon_weather/themes/theme_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/YandexMap.dart';
import 'detail_page.dart';
import 'main_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 1),
      () => Overlay.of(context).insert(
        OverlayEntry(
          builder: (context) => SizedBox.expand(
            child: MyYandexMap(),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        title: Row(
          mainAxisSize: MainAxisSize.max,
          children: const [
            Expanded(
              child: Text(
                "Weather Toon",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inter",
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: YandexLogo(),
            ),
          ],
        ),
        shape: const Border(
          bottom: BorderSide(width: 2),
        ),
        elevation: 8,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: Theme.of(context).extension<ThemeImages>()!.backgroundMenuImage,
        ),
        child: Navigator(
          initialRoute: MainPage.routeName,
          onGenerateRoute: (settings) {
            late Widget page;
            switch (settings.name) {
              case MainPage.routeName:
                page = const MainPage();
                break;
              case DetailPage.routeName:
                page = DetailPage(settings.arguments as WeatherDailyForecast);
                break;
              default:
                throw Exception("Route $settings didnt exsists.");
            }
            return MaterialPageRoute(
              builder: (context) => page,
            );
          },
        ),
      ),
    );
  }
}

class YandexLogo extends StatelessWidget {
  const YandexLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 36,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.asset(
              "assets/images/yandex_logo.png",
              fit: BoxFit.fitHeight,
            ),
          ),
          const Text(
            "Источник данных.",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "Inter",
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
