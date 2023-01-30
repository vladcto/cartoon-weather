import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'temperature_weather.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TemperatureWeather extends Equatable {
  final double temp;
  @JsonKey(name: 'feels_like')
  final double tempFeelsLike;
  final double tempMax;
  final double tempMin;

  const TemperatureWeather({
    required this.temp,
    required this.tempFeelsLike,
    required this.tempMax,
    required this.tempMin,
  });

  factory TemperatureWeather.fromJson(Map<String, dynamic> json) =>
      _$TemperatureWeatherFromJson(json);
  Map<String, dynamic> toJson() => _$TemperatureWeatherToJson(this);

  @override
  List<Object?> get props => [
        temp,
        tempFeelsLike,
        tempMax,
        tempMin,
      ];
}
