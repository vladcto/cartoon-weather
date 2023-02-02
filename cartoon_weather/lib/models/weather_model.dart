import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'weather_temperature.dart';

part 'weather_model.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class WeatherModel extends Equatable {
  final int time;
  final WeatherTemperature temp;
  final int pressure;
  final double windSpeed;
  final int windDegrees;
  final int cloudy;
  final List<double>? rainPropability;
  final String weatherModel;

  const WeatherModel(
      {required this.time,
      required this.temp,
      required this.pressure,
      required this.windSpeed,
      required this.windDegrees,
      required this.cloudy,
      required this.rainPropability,
      required this.weatherModel});

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
    final String weatherModel;

    time = jsonApi["dt"];
    // main object json
    {
      Map<String, dynamic> main = jsonApi["main"];
      pressure = main["pressure"];
      temp = WeatherTemperature.fromJson(main);
    }
    // weather object json
    {
      Map<String, dynamic> weather = jsonApi["weather"][0];
      weatherModel = weather["main"];
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
        weatherModel: weatherModel);
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
        weatherModel: weatherModel);
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
        weatherModel
      ];
}
