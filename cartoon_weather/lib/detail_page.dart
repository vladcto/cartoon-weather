import 'package:cartoon_weather/theme_images.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  static const double cardBorderWidth = 4;

  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeImages themeImages = Theme.of(context).extension<ThemeImages>()!;
    var curTheme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Detailed report",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "Inter",
            ),
          ),
        ),
        shape: const Border(
          bottom: BorderSide(width: 2),
        ),
        elevation: 8,
      ),
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Hero(
              tag: "main_card",
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: curTheme.colorScheme.secondary,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: Colors.black,
                    width: cardBorderWidth,
                  ),
                ),
                child: Column(
                  children: const [],
                ),
              ),
            ),
            SizedBox(
              height: 148,
              child: Stack(
                children: [
                  Hero(
                    tag: "main_card/green",
                    child: Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.all(cardBorderWidth),
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 32,
                      ),
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: curTheme.colorScheme.primary,
                        image: themeImages.backgroundPrimaryImage,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(32 - cardBorderWidth),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0, 4),
                            spreadRadius: 1,
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.sunny, size: 84, color: Colors.black),
                          const SizedBox(height: 4),
                          Text(
                            "Sunny",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 144,
              left: 0,
              right: 0,
              child: Container(height: 2, color: Colors.black),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                height: 48,
                width: 86,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(32),
                    bottomLeft: Radius.circular(32),
                  ),
                  border: Border.all(
                    color: Colors.black,
                    width: cardBorderWidth,
                  ),
                ),
                child: const FittedBox(
                  fit: BoxFit.contain,
                  child: Icon(Icons.arrow_back_rounded, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
