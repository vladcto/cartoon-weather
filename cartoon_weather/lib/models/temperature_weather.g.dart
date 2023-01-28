// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temperature_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TemperatureWeather _$TemperatureWeatherFromJson(Map<String, dynamic> json) =>
    TemperatureWeather(
      (json['morning'] as num).toDouble(),
      (json['morningFeelsLike'] as num).toDouble(),
      (json['day'] as num).toDouble(),
      (json['dayFeelsLike'] as num).toDouble(),
      (json['evening'] as num).toDouble(),
      (json['eveningFeelsLike'] as num).toDouble(),
      (json['night'] as num).toDouble(),
      (json['nightFeelsLike'] as num).toDouble(),
      (json['min'] as num).toDouble(),
      (json['max'] as num).toDouble(),
    );

Map<String, dynamic> _$TemperatureWeatherToJson(TemperatureWeather instance) =>
    <String, dynamic>{
      'morning': instance.morning,
      'morningFeelsLike': instance.morningFeelsLike,
      'day': instance.day,
      'dayFeelsLike': instance.dayFeelsLike,
      'evening': instance.evening,
      'eveningFeelsLike': instance.eveningFeelsLike,
      'night': instance.night,
      'nightFeelsLike': instance.nightFeelsLike,
      'min': instance.min,
      'max': instance.max,
    };
