// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherForecast _$WeatherForecastFromJson(Map<String, dynamic> json) =>
    WeatherForecast(
      Geolocation.fromJson(json['location'] as Map<String, dynamic>),
      (json['dailyForecast'] as List<dynamic>)
          .map((e) => WeatherDailyForecast.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WeatherForecastToJson(WeatherForecast instance) =>
    <String, dynamic>{
      'location': instance.location.toJson(),
      'dailyForecast': instance.dailyForecast.map((e) => e.toJson()).toList(),
    };
