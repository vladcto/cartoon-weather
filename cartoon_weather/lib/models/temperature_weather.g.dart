// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temperature_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TemperatureWeather _$TemperatureWeatherFromJson(Map<String, dynamic> json) =>
    TemperatureWeather(
      temp: (json['temp'] as num).toDouble(),
      tempFeelsLike: (json['feels_like'] as num).toDouble(),
      tempMax: (json['temp_max'] as num).toDouble(),
      tempMin: (json['temp_min'] as num).toDouble(),
    );

Map<String, dynamic> _$TemperatureWeatherToJson(TemperatureWeather instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'feels_like': instance.tempFeelsLike,
      'temp_max': instance.tempMax,
      'temp_min': instance.tempMin,
    };
