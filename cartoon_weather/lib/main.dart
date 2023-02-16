import 'package:cartoon_weather/controlers/weather_forecast_controler.dart';
import 'package:cartoon_weather/helpers/logger_helper.dart';
import 'package:cartoon_weather/models/weather_forecast.dart';
import 'package:cartoon_weather/providers/main_providers.dart';
import 'package:cartoon_weather/providers/main_theme_state_notifier.dart';
import 'package:cartoon_weather/providers/weather_forecast_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'pages/home_page.dart';
import 'themes/main_theme.dart';

void main() async {
  LoggerHelper.init();
  final Logger logger = Logger("main.dart");
  bool forecastOutdated = false;
  bool forecastInitFailed = false;

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // try initialize forecast and handle exceptions
  late WeatherForecast forecast;
  await WeatherForecastControler.initializeForecast()
      // forecast init succesfull
      .then<void>((value) => forecast = value)
      .onError(
    (error, stackTrace) async {
      forecastOutdated = true;
      // try to force a forecast from the cache even if it is out of date.
      if (await WeatherForecastControler.existCachedForecast()) {
        forecast = await WeatherForecastControler.getForecastFromCahce();
      } else {
        logger.info("Forecast initialization failed");
        forecastInitFailed = true;
      }
    },
    test: (e) => e is ClientException || e is PlatformException,
  );
  var theme = await MainTheme.getTheme();
  FlutterNativeSplash.remove();

  if (forecastInitFailed) {
    runApp(_ErrorInitPage());
  } else {
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
            home: HomePage(
              buildCallback: (homeContext) {
                if (forecastOutdated) {
                  forecastOutdated = false;
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) => ScaffoldMessenger.of(homeContext).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          "Forecast update error. Check your internet contection\nNow showed old forecast.",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _ErrorInitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ColoredBox(
        color: Colors.white,
        child: Center(
          child: Container(
            width: 250,
            height: 150,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 82, 222, 154),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black, width: 2),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(4, 4),
                  blurRadius: 6,
                  color: Colors.black26,
                ),
              ],
            ),
            child: const Material(
              type: MaterialType.transparency,
              child: Text(
                "Something went wrong. :(\nCheck internet conection and try again.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
