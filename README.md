# cartoon_weather

Flutter-проект для отображения погоды в милом стиле для **любой точки земного шара**. Проект создавался как закрепление полученных знаний.

В проекте используется: ```REST API (OpenWeatherMap), YandexMapKit, Riverpod``` 

[**Figma**](https://www.figma.com/file/theet6lFyJo5bDvDNUgp9F/WeatherProject?node-id=0%3A1&t=QsEc2bCrt1KFMDn2-1)

## How to start
Для начала обновите зависимости, для этого введите в терминале:
```
flutter pub get
```

Затем нужно установить API ключи:
- Создайте файл ApiKeys.kt в ```\android\app\src\main\kotlin\com\example\cartoon_weather\ApiKeys.kt``` и добавьте в него указанный код с введеным API ключем **YandexMapKit`а**.

	**ApiKeys.kt**
	```kotlin
	object ApiKeys{
		const val YANDEX_MAP_KIT_KEY = "api_key_here"
	}
	```
- Создайте в корне проекта ```.env``` файл и введите в него следующую строку c вашим API ключем для **OpenWeatherMap**.
	```bash
	OPEN_WEATHER_MAP_KEY = "api_key_here"
	```
	Затем сохраните файл и запустите команду:
	```powershell
	flutter pub run build_runner build --delete-conflicting-outputs
	```
Теперь проект можно запустить, введя в терминал команду:

```powershell
flutter run
```

Готово!

## Screen record

https://user-images.githubusercontent.com/55505918/219907087-84c1cf85-d127-477f-b38d-38cfc03d941b.mp4

## Tested on
- Xiaomi Mi 11i
- Samsung SM-G965F
- Google Pixel 4
