import 'package:cartoon_weather/pages/location_picker_page.dart';
import 'package:cartoon_weather/providers/main_providers.dart';
import 'package:cartoon_weather/themes/custom_app_icons.dart';
import 'package:cartoon_weather/themes/weather_icons_icons.dart';
import 'package:cartoon_weather/widgets/custom_switch.dart';
import 'package:charts_painter/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../themes/theme_images.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/main_page_separator.dart';
import '../widgets/main_weather_card.dart';
import '../widgets/small_weather_card.dart';

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
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
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
                      child: Consumer(
                        builder:
                            (BuildContext context, WidgetRef ref, Widget? child) {
                          List<double> rains = ref
                              .watch(forecastProvider)
                              .dailyForecast[0]
                              .rainPropabilitys;
                          return _buildWeatherChart(context, rains);
                        },
                      ))),
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
                    onChanged: (active) {
                      ref.watch(themeProvider.notifier).changeTheme(active);
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
            child: GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => LocationPickerPage())),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Center(
                  child: Consumer(
                    builder: (context, ref, child) => InkWell(
                      child: Text(
                        ref.watch(forecastProvider).location.name,
                        overflow: TextOverflow.visible,
                        style: nowTheme.textTheme.labelLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherChart(BuildContext context, List<double> rains) {
    return Chart(
      height: 15,
      state: ChartState<void>(
        data: ChartData(
          [
            rains.map((e) => ChartItem(e * 100)).toList(),
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
