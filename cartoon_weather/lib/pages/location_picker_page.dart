import 'package:cartoon_weather/controlers/weather_forecast_controler.dart';
import 'package:cartoon_weather/providers/main_providers.dart';
import 'package:cartoon_weather/providers/weather_forecast_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../themes/custom_app_icons.dart';

class LocationPickerPage extends StatefulWidget {
  static const Point spbLocation = Point(latitude: 59.937500, longitude: 30.308611);

  final Point startPoint;
  const LocationPickerPage({
    super.key,
    this.startPoint = spbLocation,
  });

  @override
  State<LocationPickerPage> createState() {
    return _LocationPickerPageState();
  }
}

class _LocationPickerPageState extends State<LocationPickerPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animationMark;
  late Point _coord;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _animationMark = Tween(begin: 0.0, end: 16.0).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            child: Stack(
          alignment: Alignment.center,
          children: [
            YandexMap(
              rotateGesturesEnabled: false,
              tiltGesturesEnabled: false,
              logoAlignment: const MapAlignment(
                horizontal: HorizontalAlignment.center,
                vertical: VerticalAlignment.bottom,
              ),
              onMapCreated: (controller) =>
                  controller.moveCamera(CameraUpdate.newCameraPosition(
                CameraPosition(target: widget.startPoint, zoom: 10),
              )),
              onCameraPositionChanged: (cameraPosition, reason, finished) {
                _coord = cameraPosition.target;
                updateMarkState(finished);
              },
            ),
            // pointer shadow
            Container(
              height: 12,
              width: 16,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            // pointer
            AnimatedBuilder(
              animation: _animationMark,
              builder: (context, _) => Positioned(
                right: 0,
                bottom: 102 / 2 + _animationMark.value,
                left: 0,
                top: 0,
                child: _Mark(
                  fillColor: colorScheme.primary,
                  outlineColor: colorScheme.onPrimary,
                  size: 64,
                ),
              ),
            ),
            Positioned(
              right: 24,
              bottom: 24,
              width: 96,
              height: 96,
              child: _ControlButton(
                colorScheme: colorScheme,
                onPressed: () => changeForecast(
                    ProviderScope.containerOf(context)
                        .read(forecastProvider.notifier),
                    context),
                child: const Icon(
                  CustomAppIcons.done,
                  size: 64,
                ),
              ),
            ),
            Positioned(
              left: 24,
              bottom: 24,
              width: 96,
              height: 96,
              child: _ControlButton(
                colorScheme: colorScheme,
                onPressed: () => Navigator.of(context).pop(),
                child: const Icon(
                  CustomAppIcons.close,
                  size: 64,
                ),
              ),
            ),
          ],
        )),
      ],
    );
  }

  void updateMarkState(bool finishedMove) {
    if (finishedMove && _animationController.status != AnimationStatus.reverse) {
      _animationController.reverse();
    } else if (_animationController.status != AnimationStatus.forward) {
      _animationController.forward();
    }
  }

  void changeForecast(
      WeatherForecastStateNotifier forecastStateNotifier, BuildContext context) {
    WeatherForecastControler.getForecastFromApi(_coord.latitude, _coord.longitude)
        .then(
      (value) {
        WeatherForecastControler.saveForecast(value);
        forecastStateNotifier.setupForecast(value);
        Navigator.of(context).pop();
      },
    ).onError((error, stackTrace) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Internet problems. \nCheck your internet connection and try again.",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }, test: (e) => e is ClientException);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
}

class _Mark extends StatelessWidget {
  final Color fillColor, outlineColor;
  final double size;

  const _Mark(
      {required this.fillColor, required this.outlineColor, required this.size});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          CustomAppIcons.location_filled,
          size: size,
          color: fillColor,
        ),
        Icon(
          CustomAppIcons.location,
          size: size,
          color: outlineColor,
        ),
      ],
    );
  }
}

class _ControlButton extends ElevatedButton {
  _ControlButton(
      {required super.onPressed,
      required super.child,
      required ColorScheme colorScheme})
      : super(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(colorScheme.secondary),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: const BorderSide(color: Colors.black, width: 3),
              ),
            ),
            elevation: MaterialStateProperty.all(8),
          ),
        );
}
