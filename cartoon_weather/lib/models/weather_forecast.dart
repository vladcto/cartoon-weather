import 'package:cartoon_weather/models/weather_daily_forecast.dart';
import 'package:cartoon_weather/models/weather_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part "weather_forecast.g.dart";

@JsonSerializable(explicitToJson: true)
class WeatherForecast extends Equatable {
  final List<WeatherDailyForecast> dailyForecast;

  const WeatherForecast(this.dailyForecast);

  factory WeatherForecast.fromJson(Map<String, dynamic> json) =>
      _$WeatherForecastFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherForecastToJson(this);

  factory WeatherForecast.fromApiJson(Map<String, dynamic> json) {
    final int sunrise, sunset;
    final List<WeatherDailyForecast> dailyForecast = [];
    // city json object
    {
      Map<String, dynamic> city = json["city"];
      sunrise = city["sunrise"] * 1000;
      sunset = city["sunset"] * 1000;
    }
    // list json object
    {
      List list = json["list"];
      // create 5 one-day forecast
      for (int i = 0; i < 5; i++) {
        // take 8 3-hours forecast to create 1 day forecast
        List<WeatherModel> models = [
          for (var j = i * 8; j < (i + 1) * 8; j++) WeatherModel.fromApiJson(list[j])
        ];
        dailyForecast
            .add(WeatherDailyForecast.fromWeatherList(sunrise, sunset, models));
      }
    }

    return WeatherForecast(dailyForecast);
  }

  @override
  List<Object?> get props => [dailyForecast];
}
