import 'package:flutter/material.dart';

class ThemeImages extends ThemeExtension<ThemeImages> {
  static const List<double> blackWhiteColorMatrix = [
    ...[0.21, 0.71, 0.06, 0, 150],
    ...[0.21, 0.71, 0.06, 0, 150],
    ...[0.21, 0.71, 0.06, 0, 150],
    ...[0, 0, 0, 1, 0],
  ];

  static const ThemeImages basic = ThemeImages(
    backgroundMenuImage: DecorationImage(
      image: AssetImage("assets/images/background.jpg"),
      fit: BoxFit.fill,
      colorFilter: ColorFilter.matrix(blackWhiteColorMatrix),
      opacity: 0.15,
    ),
    backgroundPrimaryImage: DecorationImage(
      image: AssetImage("assets/images/white_lines_background.jpg"),
      opacity: 0.13,
      scale: 0.85,
      fit: BoxFit.none,
    ),
  );

  final DecorationImage backgroundPrimaryImage;
  final DecorationImage backgroundMenuImage;

  const ThemeImages(
      {required this.backgroundMenuImage, required this.backgroundPrimaryImage});

  @override
  ThemeExtension<ThemeImages> lerp(
      covariant ThemeExtension<ThemeImages>? other, double t) {
    return other ?? this;
  }

  @override
  ThemeExtension<ThemeImages> copyWith({
    DecorationImage? backgroundPrimaryImage,
    DecorationImage? backgroundMenuImage,
  }) {
    return ThemeImages(
        backgroundMenuImage: backgroundMenuImage ?? this.backgroundMenuImage,
        backgroundPrimaryImage:
            backgroundPrimaryImage ?? this.backgroundPrimaryImage);
  }
}
