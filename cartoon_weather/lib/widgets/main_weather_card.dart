import 'package:cartoon_weather/models/weather_daily_forecast.dart';
import 'package:cartoon_weather/pages/detail_page.dart';
import 'package:cartoon_weather/themes/custom_app_icons.dart';
import 'package:cartoon_weather/themes/theme_images.dart';
import 'package:cartoon_weather/widgets/stroke_text.dart';
import 'package:flutter/material.dart';
import "package:cartoon_weather/helpers/open_weather_helper.dart" as weather_helper;

/// Clickable card that displays basic information of [WeatherDailyForecast].
///
/// On click shown [DetailPage] of [WeatherDailyForecast].
class MainWeatherCard extends StatelessWidget {
  final WeatherDailyForecast dailyForecast;
  const MainWeatherCard(this.dailyForecast, {super.key});

  @override
  Widget build(BuildContext context) {
    ThemeImages themeImages = Theme.of(context).extension<ThemeImages>()!;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 195,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(DetailPage.kRouteName, arguments: dailyForecast);
        },
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            // * Main info.
            Card(
              elevation: 4,
              color: Theme.of(context).colorScheme.secondary,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                side: BorderSide(color: Colors.black, width: 2),
              ),
              clipBehavior: Clip.hardEdge,
              child: Padding(
                padding: const EdgeInsets.only(left: 164, top: 8, bottom: 8),
                // * lists content
                child: Center(
                  child: SizedBox(
                    width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CardInfoDisplay(
                          CustomAppIcons.thermometer,
                          "${dailyForecast.temp.min.toInt()}/${dailyForecast.temp.max.toInt()} ??C",
                          subText: "temperature",
                        ),
                        CardInfoDisplay(
                          CustomAppIcons.wind,
                          "${dailyForecast.windSpeed.toStringAsFixed(1)} m/s",
                          subText: "wind speed",
                        ),
                        CardInfoDisplay(
                          CustomAppIcons.pressure,
                          "${dailyForecast.pressure} hPa",
                          subText: "pressure",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // if insert this container in row, he didnt take all height.
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
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
              // * left container
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
                  StrokeText(
                    text: weather_helper.getWeatherName(dailyForecast.weatherType),
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: colorScheme.primary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget that shows icon with main texts and under them small sub text.
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
            Icon(icon, size: 32, color: Theme.of(context).colorScheme.onPrimary),
            const SizedBox(width: 4),
            StrokeText(
              text: mainText,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.secondary),
              strokeWidth: 3.5,
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
