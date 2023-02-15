import 'package:cartoon_weather/controlers/weather_forecast_controler.dart';
import 'package:cartoon_weather/models/weather_forecast.dart';
import 'package:cartoon_weather/providers/main_providers.dart';
import 'package:cartoon_weather/providers/weather_forecast_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

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
          child: LayoutBuilder(builder: (context, constraints) {
            return Stack(
              alignment: Alignment.center,
              children: [
                YandexMap(
                  rotateGesturesEnabled: false,
                  tiltGesturesEnabled: false,
                  logoAlignment: const MapAlignment(
                    horizontal: HorizontalAlignment.center,
                    vertical: VerticalAlignment.bottom,
                  ),
                  onMapCreated: (controller) => controller.moveCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(target: widget.startPoint),
                    ),
                  ),
                  onCameraPositionChanged: (cameraPosition, reason, finished) {
                    _coord = cameraPosition.target;
                    updateMarkState(finished);
                  },
                ),
                AnimatedBuilder(
                  animation: _animationMark,
                  builder: (context, _) => Positioned(
                    right: 0,
                    bottom: constraints.maxHeight / 2 + _animationMark.value,
                    left: 0,
                    child: Icon(
                      Icons.online_prediction_outlined,
                      size: 64,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
                Positioned(
                  top: constraints.maxHeight / 2 + 32,
                  width: 200,
                  height: 96,
                  child: Container(
                    width: 250,
                    height: 96,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 24,
                  bottom: 24,
                  width: 96,
                  height: 96,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(colorScheme.secondary),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(color: Colors.black, width: 2),
                        ),
                      ),
                    ),
                    onPressed: () => changeForecast(
                        ProviderScope.containerOf(context)
                            .read(forecastProvider.notifier),
                        context),
                    child: Icon(
                      Icons.navigate_next_rounded,
                      size: 64,
                    ),
                  ),
                ),
                Positioned(
                  left: 24,
                  bottom: 24,
                  width: 96,
                  height: 96,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(colorScheme.secondary),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(color: Colors.black, width: 2),
                        ),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Icon(
                      Icons.not_interested_sharp,
                      size: 64,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
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
        .then((value) {
      // TODO: Сделать сохранение выбранной геолокации.
      forecastStateNotifier.setupForecast(value);
      Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
}
