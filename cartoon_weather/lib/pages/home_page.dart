import 'package:cartoon_weather/models/weather_daily_forecast.dart';
import 'package:cartoon_weather/themes/theme_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'detail_page.dart';
import 'main_page.dart';

/// Start page for app with Scaffold.
class HomePage extends StatelessWidget {
  /// Callback that calls when widget is building.
  final Function(BuildContext homeContext)? buildCallback;
  const HomePage({super.key, this.buildCallback});

  @override
  @override
  Widget build(BuildContext context) {
    buildCallback?.call(context);

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
            SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
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
              child: ApiLogo(),
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
              case DetailPage.kRouteName:
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

class ApiLogo extends StatelessWidget {
  const ApiLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 36,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Expanded(
              child: Text(
            "OpenWeatherMap",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontFamily: "Inter",
              fontSize: 17,
            ),
            textAlign: TextAlign.center,
          )),
          Text(
            "API provider.",
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
