import 'dart:convert';
import 'dart:io';

import 'package:cartoon_weather/models/weather_forecast.dart';
import 'package:cartoon_weather/models/weather_temperature.dart';
import 'package:cartoon_weather/models/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Weather Model tests: encode -> decode equality
  WeatherModel weatherModel = const WeatherModel(
      time: 12,
      temp: WeatherTemperature(
        average: 296.76,
        feelsLike: 296.98,
        max: 297.87,
        min: 296.76,
      ),
      pressure: 12,
      windSpeed: 12,
      windDegrees: 12,
      cloudy: 12,
      rainPropability: [],
      weatherType: WeatherType.rain);

  // Weather Model tests: decode equality test
  String jsonApiExample =
      File("test/assets/json_tests/weather_api_response.json").readAsStringSync();
  WeatherModel jsonModelExample = const WeatherModel(
      time: 1661871600 * 1000,
      temp: WeatherTemperature(
        average: 296.76,
        feelsLike: 296.98,
        max: 297.87,
        min: 296.76,
      ),
      pressure: 1015,
      windSpeed: 0.62,
      windDegrees: 349,
      cloudy: 100,
      rainPropability: [0.32],
      weatherType: WeatherType.rain);

  // Weather forecast: encode -> decode equality
  String weatherForecastJson =
      File("test/assets/json_tests/weather_api_response_full.json")
          .readAsStringSync();
  WeatherForecast weatherForecast =
      WeatherForecast.fromApiJson(jsonDecode(weatherForecastJson));

  group(
    "Json Encode and decode test:",
    () {
      group(
        "Weather Model tests:",
        () {
          test(
            "encode -> decode equality",
            () => expect(WeatherModel.fromJson(weatherModel.toJson()), weatherModel),
          );
          test(
            "decode equality",
            () => expect(
                WeatherModel.fromApiJson(jsonDecode(jsonApiExample)["list"][0]),
                jsonModelExample),
          );
        },
      );
      group(
        "Weather forecast:",
        () {
          test(
              "encode -> decode equality",
              () => expect(WeatherForecast.fromJson(weatherForecast.toJson()),
                  weatherForecast));
        },
      );
    },
  );
}
