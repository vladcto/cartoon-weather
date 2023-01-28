// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
      (json['time'] as num).toDouble(),
      (json['sunrise'] as num).toDouble(),
      (json['sunset'] as num).toDouble(),
      TemperatureWeather.fromJson(json['dailyWeather'] as Map<String, dynamic>),
      (json['pressure'] as num).toDouble(),
      (json['humidity'] as num).toDouble(),
      (json['windSpeed'] as num).toDouble(),
      (json['windDegrees'] as num).toDouble(),
      (json['cloudy'] as num).toDouble(),
      (json['rainPropability'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      json['weatherMode'] as String,
    );

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'time': instance.time,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
      'dailyWeather': instance.dailyWeather.toJson(),
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'windSpeed': instance.windSpeed,
      'windDegrees': instance.windDegrees,
      'cloudy': instance.cloudy,
      'rainPropability': instance.rainPropability,
      'weatherMode': instance.weatherMode,
    };
