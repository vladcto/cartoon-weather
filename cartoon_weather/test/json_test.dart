import 'dart:convert';
import 'dart:io';

import 'package:cartoon_weather/models/temperature_weather.dart';
import 'package:cartoon_weather/models/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  WeatherModel weatherModel = const WeatherModel(
      time: 12,
      sunrise: 12,
      sunset: 12,
      dailyWeather: TemperatureWeather(
        temp: 296.76,
        tempFeelsLike: 296.98,
        tempMax: 297.87,
        tempMin: 296.76,
      ),
      pressure: 12,
      windSpeed: 12,
      windDegrees: 12,
      cloudy: 12,
      rainPropability: null,
      weatherModel: "Rain");

  String jsonApiExample =
      File("test/assets/json_tests/weather_api_response.json").readAsStringSync();

  WeatherModel jsonModelExample = const WeatherModel(
      time: 1661871600,
      sunrise: 1661834187,
      sunset: 1661882248,
      dailyWeather: TemperatureWeather(
        temp: 296.76,
        tempFeelsLike: 296.98,
        tempMax: 297.87,
        tempMin: 296.76,
      ),
      pressure: 1015,
      windSpeed: 0.62,
      windDegrees: 349,
      cloudy: 100,
      rainPropability: [0.32],
      weatherModel: "Rain");

  group(
    "Encode and decode test:",
    () {
      test(
        "encode -> decode equality",
        () => expect(WeatherModel.fromJson(weatherModel.toJson()), weatherModel),
      );
      test(
        "decode equality",
        () => expect(
            WeatherModel.fromApiJson(jsonDecode(jsonApiExample)), jsonModelExample),
      );
    },
  );
}
