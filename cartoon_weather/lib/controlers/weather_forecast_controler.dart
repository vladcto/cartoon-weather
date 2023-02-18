import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:http/http.dart' as http;
import 'package:cartoon_weather/helpers/open_weather_helper.dart' as weather_helper;

import '../env/envi.dart';
import '../models/geolocation.dart';
import '../models/weather_forecast.dart';

/// Class, using for control user forecast settings.
abstract class WeatherForecastControler {
  static final Logger logger = Logger("WeatherForecastControler");
  static const String timeKey = "time";
  static const String forecastKey = "forecast";

  /// Returns [WeatherForecast] initialized from API or cache.
  ///
  /// If cache too old or missing, its initialized from API, otherwise from cache.
  /// Throws [ClientException] and [PlatformException] if app lost internet conection.
  static Future<WeatherForecast> initializeForecast() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime? time = prefs.containsKey(timeKey)
        ? DateTime.fromMillisecondsSinceEpoch(prefs.getInt(timeKey)!)
        : null;

    if (time != null &&
        time.difference(DateTime.now().toUtc()).inHours < 3 &&
        prefs.containsKey(forecastKey)) {
      // Should be initialized from cache.
      try {
        return getForecastFromCahce();
      } catch (e, trace) {
        logger.warning("Forecast cache initialize failed.", e, trace);
        return await initializeForecastFromApi();
      }
    } else {
      // Should be initialized from API.
      return initializeForecastFromApi();
    }
  }

  /// Returns [WeatherForecast] from API and save him.
  ///
  /// Throws [ClientException] and [PlatformException] if app lost internet conection.
  static Future<WeatherForecast> initializeForecastFromApi() async {
    logger.info("Initialize forecast from API.");
    Geolocation geolocation = await getCurrentGeolocation();
    WeatherForecast forecast =
        await getForecastFromApi(geolocation.lat, geolocation.lon);

    saveForecast(forecast);
    return forecast;
  }

  /// Returns [WeatherForecast] from API by [lat],[lon] coordinats.
  ///
  /// Throws [ClientException] and [PlatformException] if app lost internet conection.
  static Future<WeatherForecast> getForecastFromApi(double lat, double lon) async {
    logger.info("Call OpenWeatherMap API.");
    var apiResponse = await http.get(Uri.parse(weather_helper.createRequest(
      lat: lat,
      lon: lon,
      apiKey: Envi.openWeatherMapKey,
    )));
    var locationsMark = await geocoding.placemarkFromCoordinates(lat, lon);
    var geolocation = Geolocation(
      name: locationsMark[0].locality.toString().isEmpty
          ? "lat: ${lat.toStringAsFixed(1)}, lon: ${lon.toStringAsFixed(1)}"
          : locationsMark[0].locality.toString(),
      lat: lat,
      lon: lon,
    );
    return WeatherForecast.fromApiJson(geolocation, jsonDecode(apiResponse.body));
  }

  /// Returns [WeatherForecast] from cache.
  ///
  /// Before call, you need to check if the record exsist in cache by using [existCachedForecast].
  static Future<WeatherForecast> getForecastFromCahce() async {
    var prefs = await SharedPreferences.getInstance();
    logger.info("Initialize forecast from cache.");
    return WeatherForecast.fromJson(
      json.decode(
        prefs.getString(forecastKey)!,
      ),
    );
  }

  /// Returns cached of default [Geolocation] of forecast.
  static Future<Geolocation> getCurrentGeolocation() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(forecastKey)) {
      return Geolocation.fromJson(
          jsonDecode(prefs.getString(forecastKey)!)[WeatherForecast.locationKey]);
    } else {
      // default geolocation
      return const Geolocation(
        name: "Sankt-Petersburg",
        lat: 59.937500,
        lon: 30.308611,
      );
    }
  }

  // Saves [forecast] in memory.
  static Future<void> saveForecast(WeatherForecast forecast) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(forecastKey, json.encode(forecast.toJson()));
    await prefs.setInt(timeKey, forecast.dailyForecast[0].time);
  }

  /// Whether the forecast exist in memory.
  static Future<bool> existCachedForecast() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(forecastKey) && prefs.containsKey(timeKey);
  }
}
