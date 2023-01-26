import 'dart:math';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final Widget child;
  const BottomBar({required this.child, Key? key}) : super(key: key);
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  double _bottom = 0;

  @override
  Widget build(BuildContext context) {
    const double barHeight = 256;
    const double barStroke = 2;
    const double sliderHeight = 16;
    const double topSliderMargin = 16;
    const double sliderSize = sliderHeight + topSliderMargin * 2;

    return Positioned(
      bottom: _bottom - barHeight + sliderSize,
      right: 0,
      left: 0,
      child: SizedBox(
        height: barHeight,
        width: double.infinity,
        child: Container(
          height: barHeight,
          width: 400,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
              width: barStroke,
            ),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24),
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, -6),
                blurRadius: 6,
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            fit: StackFit.expand,
            children: [
              Positioned(
                top: topSliderMargin,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    _bottom -= details.delta.dy;
                    _bottom =
                        min(barHeight - sliderSize - barStroke, max(0, _bottom));
                    setState(() {});
                  },
                  child: Container(
                    width: 128,
                    height: sliderHeight,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10000),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: sliderSize,
                bottom: 0,
                right: 0,
                left: 0,
                child: widget.child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
