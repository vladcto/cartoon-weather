// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_temperature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherTemperature _$WeatherTemperatureFromJson(Map<String, dynamic> json) =>
    WeatherTemperature(
      average: (json['temp'] as num).toDouble(),
      feelsLike: (json['feels_like'] as num).toDouble(),
      max: (json['temp_max'] as num).toDouble(),
      min: (json['temp_min'] as num).toDouble(),
    );

Map<String, dynamic> _$WeatherTemperatureToJson(WeatherTemperature instance) =>
    <String, dynamic>{
      'temp': instance.average,
      'feels_like': instance.feelsLike,
      'temp_max': instance.max,
      'temp_min': instance.min,
    };
