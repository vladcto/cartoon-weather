import 'package:cartoon_weather/widgets/bottom_bar.dart';
import 'package:cartoon_weather/widgets/small_weather_card.dart';
import 'package:cartoon_weather/themes/theme_images.dart';
import 'package:flutter/material.dart';
import '../widgets/main_page_separator.dart';
import '../widgets/main_weather_card.dart';
import 'package:charts_painter/chart.dart';

class HomePage extends StatelessWidget {
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
    ThemeImages themeImages = Theme.of(context).extension<ThemeImages>()!;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Expanded(
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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: themeImages.backgroundMenuImage,
            ),
            child: Column(
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
                  padding: EdgeInsets.all(8),
                  child: MainPageSeparator("Rain"),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 48,
                      left: 48,
                      bottom: 64,
                      top: 0,
                    ),
                    child: _buildWeatherChart(context),
                  ),
                ),
              ],
            ),
          ),
          const BottomBar(
            child: Center(child: Text("Bottom Bar Container")),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationPicker(BuildContext context) {
    var nowTheme = Theme.of(context);
    return SizedBox(
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

  Widget _buildWeatherChart(BuildContext context) {
    return Chart(
      height: 15,
      state: ChartState<void>(
        data: ChartData(
          [
            [
              ChartItem(1),
              ChartItem(2),
              ChartItem(8),
              ChartItem(45),
              ChartItem(95),
              ChartItem(60),
              ChartItem(35),
              ChartItem(2),
              ChartItem(0),
              ChartItem(0),
              ChartItem(1),
              ChartItem(4),
            ],
          ],
        ),
        itemOptions: BarItemOptions(
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
          ),
          barItemBuilder: (data) => BarItem(
            color: Theme.of(context).colorScheme.primary,
            radius: BorderRadius.circular(4),
            border: const BorderSide(
              color: Colors.black,
              width: 1.5,
            ),
          ),
        ),
        foregroundDecorations: [
          HorizontalAxisDecoration(
            showValues: true,
            showTopValue: true,
            axisValue: (value) => "$value %",
            legendPosition: HorizontalLegendPosition.start,
            legendFontStyle: const TextStyle(
              color: Colors.black,
              fontSize: 10,
            ),
            axisStep: 20,
            dashArray: [8, 2],
          ),
          WidgetDecoration(
            widgetDecorationBuilder:
                (context, chartState, itemWidth, verticalMultiplier) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 4,
                    right: 0,
                    bottom: -8,
                    child: Container(
                      height: 2,
                      color: Colors.black,
                    ),
                  ),
                  Positioned(
                    left: -8,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 2,
                      color: Colors.black,
                    ),
                  )
                ],
              );
            },
          ),
        ],
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
