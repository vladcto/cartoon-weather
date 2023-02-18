import 'package:cartoon_weather/themes/weather_icons.dart';
import 'package:flutter/material.dart';

import '../models/iweather_forecast.dart';

/// Returns [IconData] associated to [type].
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

/// Returns weather name of [type].
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

/// Returns formated [String] that represents date of [forecast].
String getForecastDate(IWeatherForecastModel forecast) {
  const List months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  DateTime time = DateTime.fromMillisecondsSinceEpoch(forecast.time);
  return "${months[time.month - 1]} ${time.day}";
}

/// Shortcut for requests to OpenWeatherMap API.
String createRequest(
    {required double lon, required double lat, required String apiKey}) {
  return "http://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric";
}
