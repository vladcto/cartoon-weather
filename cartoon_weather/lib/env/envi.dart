import 'package:envied/envied.dart';

part 'envi.g.dart';

@Envied(obfuscate: true, path: ".env")
class Envi {
  // You can past here own OpenWeatherMap API key.
  @EnviedField(varName: 'OPEN_WEATHER_MAP_KEY')
  static final openWeatherMapKey = _Envi.openWeatherMapKey;
}
