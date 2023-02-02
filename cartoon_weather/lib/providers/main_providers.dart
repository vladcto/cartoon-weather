import 'package:cartoon_weather/models/weather_forecast.dart';
import 'package:cartoon_weather/providers/weather_forecast_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final forecastProvider =
    StateNotifierProvider<WeatherForecastStateNotifier, WeatherForecast>(
  (ref) => throw UnimplementedError(),
);
