import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MyYandexMap extends StatefulWidget {
  const MyYandexMap({super.key});

  @override
  State<MyYandexMap> createState() {
    return _MyYandexMapState();
  }
}

class _MyYandexMapState extends State<MyYandexMap>
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
    _animationMark = Tween(begin: 0.0, end: 32.0).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              YandexMap(
                rotateGesturesEnabled: false,
                tiltGesturesEnabled: false,
                onCameraPositionChanged: (cameraPosition, reason, finished) {
                  _coord = cameraPosition.target;
                  updateMarkState(finished);
                },
              ),
              AnimatedBuilder(
                animation: _animationMark,
                builder: (context, _) => Positioned(
                  top: 0,
                  right: 0,
                  bottom: 32 + _animationMark.value,
                  left: 0,
                  child: const Icon(
                    Icons.online_prediction_outlined,
                    size: 64,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 96,
          color: Colors.black,
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () => print(_coord),
                child: Text("Click me!"),
              ),
            ],
          ),
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
