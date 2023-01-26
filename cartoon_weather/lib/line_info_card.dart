import 'package:flutter/material.dart';

class LineInfoCard extends StatelessWidget {
  final String text, subtext;
  final IconData icon;
  const LineInfoCard(
      {required this.text, required this.subtext, required this.icon, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 52,
          width: double.infinity,
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.black,
              width: 2,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 6),
                blurRadius: 4,
              )
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                width: 56,
                height: double.infinity,
                color: theme.colorScheme.primary,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Icon(icon),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    text,
                    style: theme.textTheme.labelLarge!.copyWith(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 18,
          width: double.infinity,
          child: Center(
            child: Text(
              subtext,
              style: theme.textTheme.labelMedium!.copyWith(
                fontSize: 16,
                letterSpacing: 1,
                wordSpacing: 2,
              ),
            ),
          ),
        )
      ],
    );
  }
}
