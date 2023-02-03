import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show immutable;
import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart' as logger;
import 'weather_temperature.dart';

part 'weather_model.g.dart';

enum WeatherType { sunny, cloudy, rain, thunderstorm, foggy, drizzle, snow }

@JsonSerializable(explicitToJson: true)
@immutable
class WeatherModel extends Equatable {
  static final log = logger.Logger("WeatherModel");

  final int time;
  final WeatherTemperature temp;
  final int pressure;
  final double windSpeed;
  final int windDegrees;
  final int cloudy;
  final List<double>? rainPropability;
  final WeatherType weatherType;

  const WeatherModel(
      {required this.time,
      required this.temp,
      required this.pressure,
      required this.windSpeed,
      required this.windDegrees,
      required this.cloudy,
      required this.rainPropability,
      required this.weatherType});

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

  factory WeatherModel.fromApiJson(Map<String, dynamic> jsonApi) {
    final int time;
    final WeatherTemperature temp;
    final int pressure;
    final double windSpeed;
    final int windDegrees;
    final int cloudy;
    final List<double>? rainPropability;
    final WeatherType weatherType;

    time = jsonApi["dt"] * 1000;
    // main object json
    {
      Map<String, dynamic> main = jsonApi["main"];
      pressure = main["pressure"];
      temp = WeatherTemperature.fromJson(main);
    }
    // weather object json
    {
      Map<String, dynamic> weather = jsonApi["weather"][0];
      switch (weather["main"]) {
        case "Thunderstorm":
          weatherType = WeatherType.thunderstorm;
          break;
        case "Drizzle":
          weatherType = WeatherType.drizzle;
          break;
        case "Rain":
          weatherType = WeatherType.rain;
          break;
        case "Snow":
          weatherType = WeatherType.snow;
          break;
        case "Atmosphere":
          weatherType = WeatherType.foggy;
          break;
        case "Clear":
          weatherType = WeatherType.sunny;
          break;
        case "Clouds":
          weatherType = WeatherType.cloudy;
          break;
        default:
          log.warning("Unknown weather type: ${weather["main"]}");
          weatherType = WeatherType.sunny;
      }
    }
    // wind object json
    {
      Map<String, dynamic> wind = jsonApi["wind"];
      windSpeed = (wind["speed"] as num).toDouble();
      windDegrees = wind["deg"];
    }
    // clouds object json
    {
      Map<String, dynamic> clouds = jsonApi["clouds"];
      cloudy = clouds["all"];
    }
    rainPropability = [(jsonApi["pop"] as num).toDouble()];

    return WeatherModel(
        time: time,
        temp: temp,
        pressure: pressure,
        windSpeed: windSpeed,
        windDegrees: windDegrees,
        cloudy: cloudy,
        rainPropability: rainPropability,
        weatherType: weatherType);
  }

  WeatherModel merge(WeatherModel other) {
    return WeatherModel(
        time: time,
        temp: temp.merge(other.temp),
        pressure: (pressure + other.pressure) ~/ 2,
        windSpeed: (windSpeed + other.windSpeed) / 2,
        windDegrees: (windDegrees + other.windDegrees) ~/ 2,
        cloudy: (cloudy + other.cloudy) ~/ 2,
        rainPropability: [...?rainPropability, ...?other.rainPropability],
        weatherType: weatherType);
  }

  @override
  List<Object?> get props => [
        time,
        temp,
        pressure,
        windSpeed,
        windDegrees,
        cloudy,
        rainPropability,
        weatherType
      ];
}
