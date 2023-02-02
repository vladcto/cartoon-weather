import 'package:cartoon_weather/models/weather_forecast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherForecastStateNotifier extends StateNotifier<WeatherForecast> {
  WeatherForecastStateNotifier(super.state);

  void setupForecast(WeatherForecast forecast) => state = forecast;
}
