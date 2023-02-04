import 'package:cartoon_weather/models/weather_model.dart';
import 'package:cartoon_weather/models/weather_temperature.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:math' as math show max, min;

part 'weather_daily_forecast.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class WeatherDailyForecast extends Equatable {
  // Решил не выносить sunrise и sunset в WeatherForecast, чтоб в случае чего
  // не переписывать много кода и не усложнять использование моделей.
  final int sunrise;
  final int sunset;
  final WeatherModel? morning;
  final WeatherModel? day;
  final WeatherModel? evening;
  final WeatherModel? night;

  const WeatherDailyForecast(
      this.sunrise, this.sunset, this.morning, this.day, this.evening, this.night);

  factory WeatherDailyForecast.fromJson(Map<String, dynamic> json) =>
      _$WeatherDailyForecastFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherDailyForecastToJson(this);

  WeatherDailyForecast.fromWeatherList(
      this.sunrise, this.sunset, List<WeatherModel> models)
      : morning = models[0].merge(models[1]),
        day = models[2].merge(models[3]),
        evening = models[4].merge(models[5]),
        night = models[6].merge(models[7]);

  const WeatherDailyForecast.fromPeriods(
      {required this.sunrise,
      required this.sunset,
      this.morning,
      this.day,
      this.evening,
      this.night});

  double get rainPropabilityAverage {
    return rainPropabilitys
        .reduce((value, element) => value + element / rainPropabilitys.length);
  }

  List<double> get rainPropabilitys {
    return [
      ...day?.rainPropability ?? [],
      ...morning?.rainPropability ?? [],
      ...evening?.rainPropability ?? [],
      ...night?.rainPropability ?? []
    ];
  }

  int get pressure {
    return ((morning?.pressure ?? 0) +
            (day?.pressure ?? 0) +
            (evening?.pressure ?? 0) +
            (night?.pressure ?? 0)) ~/
        _notNullPeriods;
  }

  int get windDegrees {
    return ((morning?.windDegrees ?? 0) +
            (day?.windDegrees ?? 0) +
            (evening?.windDegrees ?? 0) +
            (night?.windDegrees ?? 0)) ~/
        _notNullPeriods;
  }

  double get windSpeed {
    return ((morning?.windSpeed ?? 0) +
            (day?.windSpeed ?? 0) +
            (evening?.windSpeed ?? 0) +
            (night?.windSpeed ?? 0)) /
        _notNullPeriods;
  }

  int get firstPeriodTime {
    return morning?.time ?? day?.time ?? evening?.time ?? night!.time;
  }

  WeatherType get weatherType {
    return evening?.weatherType ?? morning?.weatherType ?? night!.weatherType;
  }

  /// Temperature from all day periods
  WeatherTemperature get averageTemp {
    double max = [
      (morning?.temp.max ?? double.negativeInfinity),
      (day?.temp.max ?? double.negativeInfinity),
      (evening?.temp.max ?? double.negativeInfinity),
      (night?.temp.max ?? double.negativeInfinity),
    ].reduce((value, element) => math.max(value, element));

    double min = [
      (morning?.temp.min ?? double.infinity),
      (day?.temp.min ?? double.infinity),
      (evening?.temp.min ?? double.infinity),
      (night?.temp.min ?? double.infinity),
    ].reduce((value, element) => math.min(value, element));

    double average = [
      morning?.temp.average,
      day?.temp.average,
      evening?.temp.average,
      night?.temp.average,
    ]
        .whereType<double>()
        .reduce((value, element) => value + element / _notNullPeriods);

    double feelsLike = [
      morning?.temp.feelsLike,
      day?.temp.feelsLike,
      evening?.temp.feelsLike,
      night?.temp.feelsLike,
    ]
        .whereType<double>()
        .reduce((value, element) => value + element / _notNullPeriods);

    return WeatherTemperature(
        average: average, feelsLike: feelsLike, max: max, min: min);
  }

  /// Returns the number of non-zero periods of the day.s
  int get _notNullPeriods {
    return (morning != null ? 1 : 0) +
        (day != null ? 1 : 0) +
        (evening != null ? 1 : 0) +
        (night != null ? 1 : 0);
  }

  @override
  List<Object?> get props => [sunrise, sunset, morning, day, evening, night];
}
