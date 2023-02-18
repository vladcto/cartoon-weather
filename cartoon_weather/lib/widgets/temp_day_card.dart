import 'package:cartoon_weather/models/weather_temperature.dart';
import 'package:cartoon_weather/themes/custom_app_icons.dart';
import 'package:cartoon_weather/widgets/stroke_text.dart';
import 'package:flutter/material.dart';

/// Widget thats shown the average and feel like temperature of [WeatherTemperature].
class TempDayCard extends StatelessWidget {
  final String headerText;
  final WeatherTemperature temperature;
  const TempDayCard(this.headerText, {required this.temperature, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double strokeWidth = 2;
    const double shadowOffsetY = 8;

    var theme = Theme.of(context);

    return Container(
      height: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: strokeWidth,
        vertical: strokeWidth + shadowOffsetY,
      ),
      clipBehavior: Clip.hardEdge,
      width: 128,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: Colors.black,
            width: strokeWidth,
            strokeAlign: BorderSide.strokeAlignOutside),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, shadowOffsetY),
            blurRadius: 2,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // * header
          Container(
            height: 36,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              border: const Border(
                bottom: BorderSide(color: Colors.black, width: strokeWidth),
              ),
            ),
            child: Text(
              headerText,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          // * temperatures
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                _TempLabel(temperature.average.toInt()),
                const SizedBox(height: 8),
                Text("feels like",
                    style: TextStyle(color: theme.colorScheme.onPrimary)),
                const SizedBox(height: 4),
                _TempLabel(temperature.feelsLike.toInt()),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _TempLabel extends StatelessWidget {
  final int temp;

  const _TempLabel(this.temp, {super.key});

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.labelMedium;
    var colorTheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          CustomAppIcons.thermometer,
          size: 32,
          color: colorTheme.onPrimary,
        ),
        StrokeText(
          text: "${temp.toInt()} °C",
          style: textStyle!.copyWith(color: colorTheme.surface),
          strokeWidth: 3,
        ),
      ],
    );
  }
}
