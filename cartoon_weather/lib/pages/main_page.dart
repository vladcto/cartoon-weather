import 'package:cartoon_weather/models/weather_forecast.dart';
import 'package:cartoon_weather/pages/location_picker_page.dart';
import 'package:cartoon_weather/providers/main_providers.dart';
import 'package:cartoon_weather/themes/custom_app_icons.dart';
import 'package:cartoon_weather/themes/main_theme.dart';
import 'package:cartoon_weather/themes/weather_icons.dart';
import 'package:cartoon_weather/widgets/custom_switch.dart';
import 'package:charts_painter/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../themes/theme_images.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/main_page_separator.dart';
import '../widgets/main_weather_card.dart';
import '../widgets/small_weather_card.dart';

/// Page for forecast preview.
class MainPage extends StatelessWidget {
  static const String routeName = "main";

  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeImages themeImages = Theme.of(context).extension<ThemeImages>()!;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: themeImages.backgroundMenuImage,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Column(
                  children: [
                    _buildLocationPicker(context),
                    Consumer(
                      builder:
                          (BuildContext context, WidgetRef ref, Widget? child) =>
                              MainWeatherCard(
                        ref.watch(forecastProvider).dailyForecast[0],
                      ),
                    ),
                    const MainPageSeparator("Next Days"),
                  ],
                ),
              ),
              SizedBox(
                height: 156,
                child: Consumer(
                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                    List forecasts =
                        ref.watch(forecastProvider).dailyForecast.sublist(1);
                    // build ListView with separated elements in start, btw and end.
                    return ListView.separated(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      clipBehavior: Clip.none,
                      itemCount: forecasts.length,
                      itemBuilder: (context, index) =>
                          SmallWeatherCard(forecasts[index]),
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 16),
                      scrollDirection: Axis.horizontal,
                    );
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: MainPageSeparator("Rain 24h"),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 48,
                    left: 48,
                    bottom: 64,
                  ),
                  child: Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      var forecasts = ref.watch(forecastProvider).dailyForecast;
                      return _buildWeatherChart(
                        context,
                        [
                          ...forecasts[0].rainPropability,
                          ...forecasts[1].rainPropability
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        BottomBar(
          child: SizedBox.expand(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Theme: ",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Consumer(
                  builder: (context, ref, child) => CustomSwitch(
                    onChanged: (darkMode) {
                      ref.watch(themeProvider.notifier).changeTheme(!darkMode);
                    },
                    height: 35,
                    width: 70,
                    activeColor: colorScheme.secondary,
                    inactiveColor: colorScheme.secondary,
                    activeChild: Icon(
                      WeatherIcons.sunny,
                      color: colorScheme.onPrimary,
                    ),
                    inactiveChild: Icon(
                      CustomAppIcons.sunset,
                      color: colorScheme.onPrimary,
                    ),
                    startValue: ref.watch(themeProvider) == MainTheme.dark,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationPicker(BuildContext context) {
    var nowTheme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Location: ",
          style: nowTheme.textTheme.labelLarge,
        ),
        Flexible(
          child: Consumer(
            builder: (context, ref, _) {
              WeatherForecast forecast = ref.watch(forecastProvider);

              return ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.secondary),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10000),
                      side: const BorderSide(color: Colors.black, width: 2),
                    ),
                  ),
                ),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => LocationPickerPage(
                      startPoint: Point(
                        latitude: forecast.location.lat,
                        longitude: forecast.location.lon,
                      ),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text(
                    forecast.location.name,
                    overflow: TextOverflow.ellipsis,
                    style: nowTheme.textTheme.labelLarge,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Build Weather graphics for first 8 rains propabilitys.
  Widget _buildWeatherChart(BuildContext context, List<double> rains) {
    return Chart(
      height: 15,
      state: ChartState<void>(
        data: ChartData(
          [
            rains.take(8).map((e) => ChartItem(e * 100)).toList(),
          ],
          axisMax: 100,
          axisMin: 0,
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
