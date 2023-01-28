import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'temperature_weather.g.dart';

@JsonSerializable()
class TemperatureWeather extends Equatable {
  double morning;
  double morningFeelsLike;
  double day;
  double dayFeelsLike;
  double evening;
  double eveningFeelsLike;
  double night;
  double nightFeelsLike;
  double min;
  double max;

  TemperatureWeather(
      this.morning,
      this.morningFeelsLike,
      this.day,
      this.dayFeelsLike,
      this.evening,
      this.eveningFeelsLike,
      this.night,
      this.nightFeelsLike,
      this.min,
      this.max);

  factory TemperatureWeather.fromJson(Map<String, dynamic> json) =>
      _$TemperatureWeatherFromJson(json);
  Map<String, dynamic> toJson() => _$TemperatureWeatherToJson(this);

  @override
  List<Object?> get props => [
        morning,
        morningFeelsLike,
        day,
        dayFeelsLike,
        evening,
        eveningFeelsLike,
        night,
        nightFeelsLike,
        min,
        max
      ];
}
