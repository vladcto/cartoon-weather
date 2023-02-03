// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
      time: json['time'] as int,
      temp: WeatherTemperature.fromJson(json['temp'] as Map<String, dynamic>),
      pressure: json['pressure'] as int,
      windSpeed: (json['windSpeed'] as num).toDouble(),
      windDegrees: json['windDegrees'] as int,
      cloudy: json['cloudy'] as int,
      rainPropability: (json['rainPropability'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      weatherType: $enumDecode(_$WeatherTypeEnumMap, json['weatherType']),
    );

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'time': instance.time,
      'temp': instance.temp.toJson(),
      'pressure': instance.pressure,
      'windSpeed': instance.windSpeed,
      'windDegrees': instance.windDegrees,
      'cloudy': instance.cloudy,
      'rainPropability': instance.rainPropability,
      'weatherType': _$WeatherTypeEnumMap[instance.weatherType]!,
    };

const _$WeatherTypeEnumMap = {
  WeatherType.sunny: 'sunny',
  WeatherType.cloudy: 'cloudy',
  WeatherType.rain: 'rain',
  WeatherType.thunderstorm: 'thunderstorm',
  WeatherType.foggy: 'foggy',
  WeatherType.drizzle: 'drizzle',
  WeatherType.snow: 'snow',
};
