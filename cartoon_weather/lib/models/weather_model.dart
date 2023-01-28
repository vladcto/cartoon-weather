import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'temperature_weather.dart';

part 'weather_model.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class WeatherModel extends Equatable {
  final double time;
  final double sunrise;
  final double sunset;
  final TemperatureWeather dailyWeather;
  final double pressure;
  final double humidity;
  final double windSpeed;
  final double windDegrees;
  final double cloudy;
  final List<double>? rainPropability;
  final String weatherMode;

  const WeatherModel(
      this.time,
      this.sunrise,
      this.sunset,
      this.dailyWeather,
      this.pressure,
      this.humidity,
      this.windSpeed,
      this.windDegrees,
      this.cloudy,
      this.rainPropability,
      this.weatherMode);

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

  @override
  List<Object?> get props => [
        time,
        sunrise,
        sunset,
        dailyWeather,
        pressure,
        humidity,
        windSpeed,
        windDegrees,
        cloudy,
        rainPropability,
        weatherMode
      ];
}
