import 'package:flutter/material.dart';

class StrokeText extends StatelessWidget {
  final Color strokeColor;
  final double strokeWidth;
  final TextStyle style;
  final String text;

  const StrokeText(
      {required this.text,
      required this.style,
      this.strokeColor = Colors.black,
      this.strokeWidth = 4,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(text,
            style: style.copyWith(
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = strokeWidth
                  ..strokeJoin = StrokeJoin.round
                  ..color = strokeColor)),
        Text(text, style: style),
      ],
    );
  }
}
