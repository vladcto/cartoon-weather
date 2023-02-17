import 'package:envied/envied.dart';

part 'envi.g.dart';

@Envied(obfuscate: true, path: ".env")
class Envi {
  @EnviedField(varName: 'OPEN_WEATHER_MAP_KEY')
  static final openWeatherMapKey = _Envi.OpenWeatherMapKey;
}
