import 'package:flutter/material.dart';
import 'detail_page.dart';
import 'main_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Navigator(
        initialRoute: MainPage.routeName,
        onGenerateRoute: (settings) {
          late Widget page;
          switch (settings.name) {
            case MainPage.routeName:
              page = const MainPage();
              break;
            case DetailPage.routeName:
              page = const DetailPage();
              break;
            default:
              throw Exception("Route $settings didnt exsists.");
          }
          return MaterialPageRoute(
            builder: (context) => page,
          );
        },
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
