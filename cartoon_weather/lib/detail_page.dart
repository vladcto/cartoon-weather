import 'package:cartoon_weather/custom_app_icons_icons.dart';
import 'package:cartoon_weather/line_info_card.dart';
import 'package:cartoon_weather/temp_day_card.dart';
import 'package:cartoon_weather/theme_images.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class DetailPage extends StatelessWidget {
  static const double cardBorderWidth = 4;
  static const double headerHeight = 148;

  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeImages themeImages = Theme.of(context).extension<ThemeImages>()!;
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Detailed report",
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
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: Hero(
                tag: "main_card/deprecated",
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondary,
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: Colors.black,
                      width: cardBorderWidth,
                    ),
                  ),
                  // * main content
                  child: Column(
                    children: [
                      const SizedBox(
                        height: headerHeight,
                      ),
                      SizedBox(
                        height: 64,
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(width: 32),
                            _buildSunriseWidget("12:36 PM", true),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: CustomPaint(
                                  painter: ArrowPainer(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            _buildSunriseWidget("06:18 AM", false),
                            const SizedBox(width: 32),
                          ],
                        ),
                      ),
                      // List of temp cards
                      SizedBox(
                        height: 196,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: const [
                            SizedBox(width: 16),
                            TempDayCard("Morning"),
                            SizedBox(width: 16),
                            TempDayCard("Day"),
                            SizedBox(width: 16),
                            TempDayCard("Evening"),
                            SizedBox(width: 16),
                            TempDayCard("Night"),
                            SizedBox(width: 16),
                          ],
                        ),
                      ),
                      // ? - Должен быть способ сделать это поменьше
                      Expanded(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: const [
                                          LineInfoCard(
                                              text: "1",
                                              subtext: "2",
                                              icon: CustomAppIcons.rain),
                                          LineInfoCard(
                                              text: "1",
                                              subtext: "2",
                                              icon: CustomAppIcons.rain),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child:
                                          _buildWindRoseWidget("12 m/s", 134, theme),
                                    ),
                                  ],
                                ),
                              ),
                              const Flexible(
                                child: LineInfoCard(
                                  text: "Hello",
                                  subtext: "SubHello",
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
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: SizedBox(
                height: headerHeight,
                child: Stack(
                  children: [
                    Hero(
                      tag: "main_card/green",
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.all(cardBorderWidth),
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 32,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          image: themeImages.backgroundPrimaryImage,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(32 - cardBorderWidth),
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
                            const Icon(Icons.sunny, size: 84, color: Colors.black),
                            const SizedBox(height: 4),
                            Text(
                              "Sunny",
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
            ),
            Positioned(
              top: 144,
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
                      width: cardBorderWidth,
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
      ),
    );
  }

  Widget _buildSunriseWidget(String text, bool sunrise) {
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
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
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
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Card that display wind speed and direction in compas-like style
  Widget _buildWindRoseWidget(String speed, double direction, ThemeData theme) {
    const double strokeWeatherCardWidth = 2;

    double N = cos(pi / 180 * direction);
    double E = sin(pi / 180 * direction);
    String ns = N.abs() >= (0.5) ? (N.sign == 1 ? "N" : "S") : "";
    String ew = E.abs() >= (0.5) ? (E.sign == 1 ? "E" : "W") : "";
    int directionAngle = direction.round();
    String directionForm = "$ns$ew, $directionAngle";

    return Container(
      height: double.infinity,
      margin: const EdgeInsets.fromLTRB(
          strokeWeatherCardWidth + 16, 8, strokeWeatherCardWidth + 16, 24),
      clipBehavior: Clip.hardEdge,
      width: 128,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: Colors.black,
            width: strokeWeatherCardWidth,
            strokeAlign: BorderSide.strokeAlignOutside),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 4),
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
                    BorderSide(color: Colors.black, width: strokeWeatherCardWidth),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(CustomAppIcons.wind),
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
                Center(
                  child: Text(
                    speed,
                    style:
                        const TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
            child: Text(
              directionForm,
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class ArrowPainer extends CustomPainter {
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
