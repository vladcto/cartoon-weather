import 'package:cartoon_weather/models/weather_temperature.dart';

enum WeatherType { sunny, cloudy, rain, thunderstorm, foggy, drizzle, snow }

abstract class IWeatherForecastModel {
  /// Forecast UNIX time in UTC.
  int get time;

  /// Average temp in Celsius degrees.
  WeatherTemperature get temp;

  /// Average pressure in hPa.
  int get pressure;

  /// Average wind speed in m/s.
  double get windSpeed;

  /// Average wind direction in Celsius degrees.
  int get windDegrees;

  /// The percentage of cloudiness (0 - 100 %).
  int get cloudy;

  /// The rain probability is from 0 to 1.
  List<double> get rainPropability;

  /// The dominant type of weather.
  WeatherType get weatherType;
}
