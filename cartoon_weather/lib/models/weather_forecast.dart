import 'package:cartoon_weather/models/weather_daily_forecast.dart';
import 'package:cartoon_weather/models/weather_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'geolocation.dart';

part "weather_forecast.g.dart";

/// Container of days forecast [WeatherDailyForecast].
@JsonSerializable(explicitToJson: true)
class WeatherForecast extends Equatable {
  static const locationKey = "location";

  @JsonKey(name: locationKey)
  final Geolocation location;
  final List<WeatherDailyForecast> dailyForecast;

  const WeatherForecast(this.location, this.dailyForecast);

  factory WeatherForecast.fromJson(Map<String, dynamic> json) =>
      _$WeatherForecastFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherForecastToJson(this);

  factory WeatherForecast.fromApiJson(
      Geolocation geolocation, Map<String, dynamic> json) {
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
      // create one-day forecast from 40 periods
      // Forecast can be not full, so we create a part of forecast
      List<WeatherModel?> models = List.filled(4, null);
      for (int i = 0; i < 40; i++) {
        // take 8 3-hours forecast to create 1 day forecast (if can)
        WeatherModel model = WeatherModel.fromApiJson(list[i]);
        int modelHour = DateTime.fromMillisecondsSinceEpoch(model.time).hour;
        models[modelHour ~/ 6] = models[modelHour ~/ 6]?.merge(model) ?? model;
        // Completed one day forecast
        if (modelHour == 21) {
          dailyForecast.add(
            WeatherDailyForecast.fromPeriods(
                sunrise: sunrise,
                sunset: sunset,
                morning: models[0],
                day: models[1],
                evening: models[2],
                night: models[3]),
          );
          models = List.filled(4, null);
        }
      }
      // remain not added forecast(not full)
      if (models[0] != null) {
        dailyForecast.add(
          WeatherDailyForecast.fromPeriods(
              sunrise: sunrise,
              sunset: sunset,
              morning: models[0],
              day: models[1],
              evening: models[2],
              night: models[3]),
        );
      }
    }

    return WeatherForecast(geolocation, dailyForecast);
  }

  @override
  List<Object?> get props => [location, dailyForecast];
}
