import 'package:cartoon_weather/models/temperature_weather.dart';
import 'package:cartoon_weather/models/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  WeatherModel weatherModel = WeatherModel(
      1,
      2,
      3,
      TemperatureWeather(
        12,
        132,
        123,
        983,
        13,
        123,
        15,
        13,
        13,
        15,
      ),
      5,
      6,
      7,
      8,
      9,
      null,
      "12");
  group(
    "Serialization and deserialization test",
    () {
      test(
        "deserialize -> serialize equality",
        () => expect(WeatherModel.fromJson(weatherModel.toJson()), weatherModel),
      );
    },
  );
}
