import 'package:cartoon_weather/custom_app_icons_icons.dart';
import 'package:flutter/material.dart';

class TempDayCard extends StatelessWidget {
  final String headerText;
  const TempDayCard(this.headerText, {Key? key}) : super(key: key);

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
        color: Colors.white,
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
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildIconLabel("21 C", CustomAppIcons.thermometer, context),
                const SizedBox(height: 8),
                const Text("feels like"),
                const SizedBox(height: 4),
                _buildIconLabel("17 C", CustomAppIcons.thermometer, context),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildIconLabel(String text, IconData icon, BuildContext context) {
    var textStyle = Theme.of(context).textTheme.labelMedium;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 32,
        ),
        Text(
          text,
          style: textStyle,
        ),
      ],
    );
  }
}
