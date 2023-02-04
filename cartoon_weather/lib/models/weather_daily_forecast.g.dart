// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_daily_forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherDailyForecast _$WeatherDailyForecastFromJson(
        Map<String, dynamic> json) =>
    WeatherDailyForecast(
      json['sunrise'] as int,
      json['sunset'] as int,
      json['morning'] == null
          ? null
          : WeatherModel.fromJson(json['morning'] as Map<String, dynamic>),
      json['day'] == null
          ? null
          : WeatherModel.fromJson(json['day'] as Map<String, dynamic>),
      json['evening'] == null
          ? null
          : WeatherModel.fromJson(json['evening'] as Map<String, dynamic>),
      json['night'] == null
          ? null
          : WeatherModel.fromJson(json['night'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherDailyForecastToJson(
        WeatherDailyForecast instance) =>
    <String, dynamic>{
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
      'morning': instance.morning?.toJson(),
      'day': instance.day?.toJson(),
      'evening': instance.evening?.toJson(),
      'night': instance.night?.toJson(),
    };
