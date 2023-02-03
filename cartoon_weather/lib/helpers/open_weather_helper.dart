import 'package:cartoon_weather/models/weather_model.dart';
import 'package:cartoon_weather/themes/weather_icons_icons.dart';
import 'package:flutter/material.dart';

IconData getWeatherIcon(WeatherType type) {
  switch (type) {
    case WeatherType.cloudy:
      return WeatherIcons.cloudy;
    case WeatherType.drizzle:
      return WeatherIcons.drizzle;
    case WeatherType.foggy:
      return WeatherIcons.foggy;
    case WeatherType.rain:
      return WeatherIcons.rainy;
    case WeatherType.snow:
      return WeatherIcons.snow;
    case WeatherType.sunny:
      return WeatherIcons.sunny;
    case WeatherType.thunderstorm:
      return WeatherIcons.thunderstorm;
  }
}

String getWeatherName(WeatherType type) {
  switch (type) {
    case WeatherType.cloudy:
      return "Cloudy";
    case WeatherType.drizzle:
      return "Drizzle";
    case WeatherType.foggy:
      return "Foggy";
    case WeatherType.rain:
      return "Rain";
    case WeatherType.snow:
      return "Snow";
    case WeatherType.sunny:
      return "Sunny";
    case WeatherType.thunderstorm:
      return "Thunderstorm";
  }
}
