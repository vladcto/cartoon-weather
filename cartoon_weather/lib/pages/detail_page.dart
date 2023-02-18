import 'package:cartoon_weather/models/weather_daily_forecast.dart';
import 'package:cartoon_weather/models/weather_model.dart';
import 'package:cartoon_weather/themes/custom_app_icons.dart';
import 'package:cartoon_weather/widgets/line_info_card.dart';
import 'package:cartoon_weather/widgets/temp_day_card.dart';
import 'package:cartoon_weather/themes/theme_images.dart';
import 'package:flutter/material.dart';
import 'package:cartoon_weather/helpers/open_weather_helper.dart' as weather_helper;
import 'dart:math';

import '../widgets/stroke_text.dart';

// Page with detailed forecast view.
class DetailPage extends StatelessWidget {
  static const String kRouteName = "details";
  static const double kCardBorderWidth = 4;
  static const double kHeaderHeight = 124;

  final WeatherDailyForecast forecast;

  const DetailPage(this.forecast, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeImages themeImages = Theme.of(context).extension<ThemeImages>()!;
    var theme = Theme.of(context);

    final String sunriseTime, sunsetTime;
    {
      // Convert sunrise time to string.
      DateTime time = DateTime.fromMillisecondsSinceEpoch(forecast.sunrise);
      sunriseTime = "${time.hour}:${time.minute}";
      // Convert sunset time to string.
      time = DateTime.fromMillisecondsSinceEpoch(forecast.sunset);
      sunsetTime = "${time.hour}:${time.minute}";
    }
    final String cloudyType;
    if (forecast.cloudy < 20) {
      cloudyType = "Cloudless";
    } else if (forecast.cloudy < 60) {
      cloudyType = "Partly cloudy";
    } else {
      cloudyType = "Cloudy";
    }

    List<WeatherModel> daysPeriods = [
      forecast.morning,
      forecast.day,
      forecast.evening,
      forecast.night
    ].whereType<WeatherModel>().toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: Colors.black,
                  width: kCardBorderWidth,
                ),
              ),
              // * main content.
              child: Column(
                children: [
                  const SizedBox(
                    height: kHeaderHeight,
                  ),
                  SizedBox(
                    height: 64,
                    width: double.infinity,
                    // sunrise widgets
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(width: 32),
                        _buildSunriseWidget(sunriseTime, true, theme),
                        const SizedBox(width: 8),
                        Expanded(
                          child: CustomPaint(
                            painter: _ArrowPainer(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        _buildSunriseWidget(sunsetTime, false, theme),
                        const SizedBox(width: 32),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: _TempDaysCards(
                      days: daysPeriods,
                    ),
                  ),
                  // ? - Должен быть способ сделать это поменьше
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Column(
                        children: [
                          Flexible(
                            flex: 2,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      LineInfoCard(
                                          text:
                                              "${forecast.rainPropabilityAverage * 100 ~/ 1}%",
                                          subtext: "rain %",
                                          icon: CustomAppIcons.rain),
                                      LineInfoCard(
                                          text: "${forecast.pressure} hPa",
                                          subtext: "pressure",
                                          icon: CustomAppIcons.pressure),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: _WindRoseWidget(
                                    speed:
                                        "${forecast.windSpeed.toStringAsFixed(1)} m/s",
                                    direction: forecast.windDegrees,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: LineInfoCard(
                              text: cloudyType,
                              subtext: "clouds",
                              icon: CustomAppIcons.cloudy,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            // * top green card
            child: SizedBox(
              height: kHeaderHeight,
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.all(kCardBorderWidth),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      image: themeImages.backgroundPrimaryImage,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(32 - kCardBorderWidth),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black54,
                          offset: Offset(0, 4),
                          spreadRadius: 1,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          weather_helper.getWeatherIcon(forecast.weatherType),
                          size: 80,
                          color: Colors.black,
                        ),
                        StrokeText(
                          text: weather_helper.getWeatherName(forecast.weatherType),
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                fontSize: 22,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: kHeaderHeight - 4,
            left: 0,
            right: 0,
            child: Container(height: 2, color: Colors.black),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                height: 48,
                width: 86,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(32),
                    bottomLeft: Radius.circular(32),
                  ),
                  border: Border.all(
                    color: Colors.black,
                    width: kCardBorderWidth,
                  ),
                ),
                child: const FittedBox(
                  fit: BoxFit.contain,
                  child: Icon(Icons.arrow_back_rounded, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSunriseWidget(String text, bool sunrise, ThemeData theme) {
    return SizedBox(
      width: 96,
      height: 64,
      child: Row(
        textDirection: sunrise ? TextDirection.ltr : TextDirection.rtl,
        children: [
          // side info
          SizedBox(
            width: 48,
            child: Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  color: theme.colorScheme.onPrimary),
              textAlign: TextAlign.center,
            ),
          ),
          // icon display
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                sunrise ? CustomAppIcons.sunrise : CustomAppIcons.sunset,
                color: Colors.black,
                size: 40,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 4),
                    blurRadius: 8,
                  )
                ],
              ),
              Text(
                sunrise ? "sunrise" : "sunset",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: theme.colorScheme.onPrimary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ArrowPainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double arrowHeightPerc = .2;
    const double arrowWidthPerc = .9;
    final double height = size.height;
    final double widgth = size.width;

    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(0, height / 2),
      Offset(widgth, height / 2),
      paint,
    );
    canvas.drawLine(
      Offset(widgth, height / 2),
      Offset(widgth * arrowWidthPerc, height / 2 + height * arrowHeightPerc),
      paint,
    );
    canvas.drawLine(
      Offset(widgth, height / 2),
      Offset(widgth * arrowWidthPerc, height / 2 - height * arrowHeightPerc),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// [ListView] of days average/feelLike temperatures.
class _TempDaysCards extends StatelessWidget {
  final List<WeatherModel> days;

  const _TempDaysCards({super.key, required this.days});

  @override
  Widget build(BuildContext context) {
    return days.length > 2
        ? ListView.separated(
            itemCount: days.length + 2,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (_, index) {
              if (index == 0 || index == days.length + 1) {
                return const SizedBox(width: 4);
              }
              String name = days[index - 1].dayPeriod.name[0].toUpperCase() +
                  days[index - 1].dayPeriod.name.substring(1);
              return TempDayCard(name, temperature: days[index - 1].temp);
            },
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...days.map(
                (e) => TempDayCard(
                    e.dayPeriod.name[0].toUpperCase() +
                        e.dayPeriod.name.substring(1),
                    temperature: e.temp),
              ),
            ],
          );
  }
}

/// Card that displays wind speed and direction in compas-like style
class _WindRoseWidget extends StatelessWidget {
  static const double kStrokeWeatherCardWidth = 2;

  final String speed;
  final int direction;

  const _WindRoseWidget({super.key, required this.speed, required this.direction});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double N = cos(pi / 180 * direction);
    double E = sin(pi / 180 * direction);
    String ns = N.abs() >= (.38) ? (N.sign == 1 ? "N" : "S") : "";
    String ew = E.abs() >= (.38) ? (E.sign == 1 ? "E" : "W") : "";
    int directionAngle = direction.round();
    String directionForm = "$ns$ew, $directionAngle°";

    return Container(
      height: double.infinity,
      margin: const EdgeInsets.fromLTRB(
          kStrokeWeatherCardWidth + 16, 8, kStrokeWeatherCardWidth + 16, 24),
      clipBehavior: Clip.hardEdge,
      width: 128,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: Colors.black,
            width: kStrokeWeatherCardWidth,
            strokeAlign: BorderSide.strokeAlignOutside),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 6),
            blurRadius: 2,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // * Header
          Container(
            height: 32,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              border: const Border(
                bottom:
                    BorderSide(color: Colors.black, width: kStrokeWeatherCardWidth),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CustomAppIcons.wind, color: theme.colorScheme.onPrimary),
                Text(
                  "Wind",
                  style: theme.textTheme.labelLarge!.copyWith(fontSize: 14),
                ),
              ],
            ),
          ),
          // * Body
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset("assets/images/wind_rose.png"),
                Transform.rotate(
                    angle: direction * pi / 180,
                    child: Image.asset("assets/images/wind_rose_arrow.png")),
                Center(
                  child: Text(
                    speed,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: theme.colorScheme.onPrimary),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
            child: Text(
              directionForm,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                  color: theme.colorScheme.onPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
