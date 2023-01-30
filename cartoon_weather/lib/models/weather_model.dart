import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'temperature_weather.dart';

part 'weather_model.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class WeatherModel extends Equatable {
  final int time;
  final int sunrise;
  final int sunset;
  final TemperatureWeather dailyWeather;
  final int pressure;
  final double windSpeed;
  final int windDegrees;
  final int cloudy;
  final List<double>? rainPropability;
  final String weatherModel;

  const WeatherModel(
      {required this.time,
      required this.sunrise,
      required this.sunset,
      required this.dailyWeather,
      required this.pressure,
      required this.windSpeed,
      required this.windDegrees,
      required this.cloudy,
      required this.rainPropability,
      required this.weatherModel});

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

  factory WeatherModel.fromApiJson(Map<String, dynamic> jsonApi) {
    final int time;
    final int sunrise;
    final int sunset;
    final TemperatureWeather dailyWeather;
    final int pressure;
    final double windSpeed;
    final int windDegrees;
    final int cloudy;
    final List<double>? rainPropability;
    final String weatherModel;
    // list object json
    {
      List<dynamic> lists = (jsonApi["list"]);
      Map<String, dynamic> list = lists[0];
      time = list["dt"];
      // main object json
      {
        Map<String, dynamic> main = list["main"];
        pressure = main["pressure"];
        dailyWeather = TemperatureWeather.fromJson(main);
      }
      // weather object json
      {
        Map<String, dynamic> weather = list["weather"][0];
        weatherModel = weather["main"];
      }
      // wind object json
      {
        Map<String, dynamic> wind = list["wind"];
        windSpeed = wind["speed"];
        windDegrees = wind["deg"];
      }
      // clouds object json
      {
        Map<String, dynamic> clouds = list["clouds"];
        cloudy = clouds["all"];
      }
      rainPropability = [list["pop"]];
    }
    // city object json
    {
      Map<String, dynamic> city = jsonApi["city"];
      sunrise = city["sunrise"];
      sunset = city["sunset"];
    }
    return WeatherModel(
        time: time,
        sunrise: sunrise,
        sunset: sunset,
        dailyWeather: dailyWeather,
        pressure: pressure,
        windSpeed: windSpeed,
        windDegrees: windDegrees,
        cloudy: cloudy,
        rainPropability: rainPropability,
        weatherModel: weatherModel);
  }

  @override
  List<Object?> get props => [
        time,
        sunrise,
        sunset,
        dailyWeather,
        pressure,
        windSpeed,
        windDegrees,
        cloudy,
        rainPropability,
        weatherModel
      ];
}
