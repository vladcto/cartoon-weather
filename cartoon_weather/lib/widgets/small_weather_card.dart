import 'package:cartoon_weather/models/weather_daily_forecast.dart';
import 'package:cartoon_weather/pages/detail_page.dart';
import 'package:cartoon_weather/themes/theme_images.dart';
import 'package:flutter/material.dart';
import 'package:cartoon_weather/helpers/open_weather_helper.dart' as weather_helper;

class SmallWeatherCard extends StatelessWidget {
  final WeatherDailyForecast forecast;
  const SmallWeatherCard(this.forecast, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeImages themeImages = Theme.of(context).extension<ThemeImages>()!;

    return SizedBox(
      width: 112,
      child: Column(
        children: [
          // * Main content
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.of(context)
                  .pushNamed(DetailPage.routeName, arguments: forecast),
              // main card
              child: Stack(
                clipBehavior: Clip.none,
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, -8),
                          blurStyle: BlurStyle.normal,
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    // Date
                    child: Center(
                      child: Text(
                        weather_helper.getForecastDate(forecast),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 32,
                    child: Icon(
                      weather_helper.getWeatherIcon(forecast.weatherType),
                      color: Colors.black,
                      size: 98,
                      shadows: const [
                        Shadow(
                          color: Colors.black12,
                          offset: Offset(4, 4),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 26,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              image: themeImages.backgroundPrimaryImage,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
            ),
            // Temp
            child: Center(
              child: Text(
                "${forecast.averageTemp.max.toInt()}/${forecast.averageTemp.min.toInt()} C",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontSize: 19,
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
