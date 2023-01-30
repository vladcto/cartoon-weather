// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
      time: json['time'] as int,
      sunrise: json['sunrise'] as int,
      sunset: json['sunset'] as int,
      dailyWeather: TemperatureWeather.fromJson(
          json['dailyWeather'] as Map<String, dynamic>),
      pressure: json['pressure'] as int,
      windSpeed: (json['windSpeed'] as num).toDouble(),
      windDegrees: json['windDegrees'] as int,
      cloudy: json['cloudy'] as int,
      rainPropability: (json['rainPropability'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      weatherModel: json['weatherModel'] as String,
    );

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'time': instance.time,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
      'dailyWeather': instance.dailyWeather.toJson(),
      'pressure': instance.pressure,
      'windSpeed': instance.windSpeed,
      'windDegrees': instance.windDegrees,
      'cloudy': instance.cloudy,
      'rainPropability': instance.rainPropability,
      'weatherModel': instance.weatherModel,
    };
