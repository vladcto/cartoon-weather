import 'package:cartoon_weather/models/weather_daily_forecast.dart';
import 'package:cartoon_weather/pages/detail_page.dart';
import 'package:cartoon_weather/themes/custom_app_icons.dart';
import 'package:cartoon_weather/themes/theme_images.dart';
import 'package:flutter/material.dart';
import "package:cartoon_weather/helpers/open_weather_helper.dart" as weather_helper;

class MainWeatherCard extends StatelessWidget {
  final WeatherDailyForecast dailyForecast;
  const MainWeatherCard(this.dailyForecast, {super.key});

  @override
  Widget build(BuildContext context) {
    ThemeImages themeImages = Theme.of(context).extension<ThemeImages>()!;
    return SizedBox(
      height: 200,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(DetailPage.routeName, arguments: dailyForecast);
        },
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Hero(
              tag: "main_card",
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 4,
                color: Theme.of(context).colorScheme.secondary,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  side: BorderSide(color: Colors.black, width: 2),
                ),
                clipBehavior: Clip.hardEdge,
                child: Row(children: [
                  const SizedBox(
                    width: 164,
                  ),
                  Expanded(
                    // * lists content
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        width: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CardInfoDisplay(
                              CustomAppIcons.thermometer,
                              "${dailyForecast.day.temp.min.toInt()}/${dailyForecast.day.temp.max.toInt()} C",
                              subText: "temperature",
                            ),
                            CardInfoDisplay(
                              CustomAppIcons.wind,
                              "${dailyForecast.day.windSpeed} m/s",
                              subText: "wind speed",
                            ),
                            CardInfoDisplay(
                              CustomAppIcons.pressure,
                              "${dailyForecast.day.pressure} lbs",
                              subText: "pressure",
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ]),
              ),
            ),
            Hero(
              tag: "main_card/green",
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                width: 164,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  image: themeImages.backgroundPrimaryImage,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(64),
                  ),
                  border: const Border.fromBorderSide(
                    BorderSide(
                      strokeAlign: BorderSide.strokeAlignInside,
                      color: Colors.black,
                      width: 4,
                    ),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(4, 0),
                      color: Colors.black12,
                      blurRadius: 8,
                    )
                  ],
                ),
                // * green content
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      weather_helper.getWeatherIcon(dailyForecast.weatherType),
                      size: 84,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      weather_helper.getWeatherName(dailyForecast.weatherType),
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(fontSize: 22),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardInfoDisplay extends StatelessWidget {
  final IconData icon;
  final String mainText, subText;

  const CardInfoDisplay(this.icon, this.mainText, {this.subText = "", super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(icon, size: 32),
            Text(
              mainText,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
        const Divider(
          height: 4,
          thickness: 2,
          color: Colors.black,
        ),
        Text(
          subText,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
