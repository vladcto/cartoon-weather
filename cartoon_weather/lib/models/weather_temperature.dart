import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:math' as math;

part 'weather_temperature.g.dart';

/// Model that contains temperature information.
@JsonSerializable(fieldRename: FieldRename.snake)
class WeatherTemperature extends Equatable {
  @JsonKey(name: 'temp')
  final double average;
  @JsonKey(name: 'feels_like')
  final double feelsLike;
  @JsonKey(name: 'temp_max')
  final double max;
  @JsonKey(name: 'temp_min')
  final double min;

  const WeatherTemperature({
    required this.average,
    required this.feelsLike,
    required this.max,
    required this.min,
  });

  factory WeatherTemperature.fromJson(Map<String, dynamic> json) =>
      _$WeatherTemperatureFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherTemperatureToJson(this);

  WeatherTemperature merge(WeatherTemperature other) {
    return WeatherTemperature(
        average: (average + other.average) / 2,
        feelsLike: (feelsLike + other.feelsLike) / 2,
        max: math.max(max, other.max),
        min: math.min(min, other.min));
  }

  @override
  List<Object?> get props => [
        average,
        feelsLike,
        max,
        min,
      ];
}
