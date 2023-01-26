import 'package:cartoon_weather/themes/theme_images.dart';
import 'package:flutter/material.dart';

class SmallWeatherCard extends StatelessWidget {
  final String textDat, textTemp;
  const SmallWeatherCard(this.textDat, this.textTemp, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeImages themeImages = Theme.of(context).extension<ThemeImages>()!;
    return SizedBox(
      width: 112,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, -8),
                        blurStyle: BlurStyle.normal,
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      textDat,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 32,
                  child: Icon(
                    Icons.cloud_circle_outlined,
                    color: Colors.black,
                    size: 98,
                    shadows: [
                      Shadow(
                        color: Colors.black12,
                        offset: Offset(4, 4),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 26,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              image: themeImages.backgroundPrimaryImage,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                textTemp,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontSize: 19,
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
