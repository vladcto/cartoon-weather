import 'package:cartoon_weather/theme_images.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  static const double cardBorderWidth = 4;
  static const double headerHeight = 148;

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
              tag: "main_card/deprecated",
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: headerHeight + 8,
                      ),
                      SizedBox(
                        height: 64,
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(width: 32),
                            _buildSunriseWidget(Icons.wb_sunny, "12:36 PM", true),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: CustomPaint(
                                  painter: ArrowPainer(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            _buildSunriseWidget(Icons.dark_mode, "06:18 AM", false),
                            const SizedBox(width: 32),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: headerHeight,
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
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSunriseWidget(IconData iconData, String text, bool sunrise) {
    return SizedBox(
      width: 96,
      height: 64,
      child: Row(
        textDirection: sunrise ? TextDirection.ltr : TextDirection.rtl,
        children: [
          // side info
          SizedBox(
            width: 48,
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          // icon display
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                color: Colors.black,
                size: 40,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 4),
                    blurRadius: 8,
                  )
                ],
              ),
              Text(
                sunrise ? "sunrise" : "sunset",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ArrowPainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double arrowHeightPerc = .2;
    const double arrowWidthPerc = .9;
    final double height = size.height;
    final double widgth = size.width;

    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(0, height / 2),
      Offset(widgth, height / 2),
      paint,
    );
    canvas.drawLine(
      Offset(widgth, height / 2),
      Offset(widgth * arrowWidthPerc, height / 2 + height * arrowHeightPerc),
      paint,
    );
    canvas.drawLine(
      Offset(widgth, height / 2),
      Offset(widgth * arrowWidthPerc, height / 2 - height * arrowHeightPerc),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
