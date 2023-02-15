import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class LocationPickerPage extends StatefulWidget {
  const LocationPickerPage({super.key});

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
                    child: const Icon(
                      Icons.online_prediction_outlined,
                      size: 64,
                    ),
                  ),
                ),
                Positioned(
                  top: constraints.maxHeight / 2,
                  width: 200,
                  height: 96,
                  child: Container(
                    width: 250,
                    height: 96,
                    child: Placeholder(),
                  ),
                ),
                Positioned(
                  right: 24,
                  bottom: 24,
                  width: 96,
                  height: 96,
                  child: Placeholder(),
                ),
                Positioned(
                  left: 24,
                  bottom: 24,
                  width: 96,
                  height: 96,
                  child: Placeholder(),
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
}
