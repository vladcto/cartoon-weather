import 'package:cartoon_weather/models/weather_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_daily_forecast.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherDailyForecast extends Equatable {
  // Решил не выносить sunrise и sunset в WeatherForecast, чтоб в случае чего
  // не переписывать много кода и не усложнять использование моделей.
  final int sunrise;
  final int sunset;
  final WeatherModel morning;
  final WeatherModel day;
  final WeatherModel evening;
  final WeatherModel night;

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

  @override
  List<Object?> get props => [sunrise, sunset, morning, day, evening, night];
}
