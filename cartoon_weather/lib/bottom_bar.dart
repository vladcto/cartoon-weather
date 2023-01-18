import 'dart:math';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  double _bottom = 0;

  @override
  Widget build(BuildContext context) {
    const double barHeight = 256;
    return Positioned(
      bottom: -_bottom - barHeight + 46,
      right: 0,
      left: 0,
      child: SizedBox(
        height: barHeight,
        width: double.infinity,
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            Container(
              height: barHeight,
              width: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 2,
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
                    top: 16,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        _bottom += details.delta.dy;
                        _bottom = max(-barHeight + 48, min(0, _bottom));
                        setState(() {});
                      },
                      child: Container(
                        width: 128,
                        height: 16,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
