import 'package:flutter/material.dart';

class MainPageSeparator extends StatelessWidget {
  final String text;
  const MainPageSeparator(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: Row(
        children: [
          buildSeparatorLine(Theme.of(context).colorScheme.primary),
          Text(
            text,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          buildSeparatorLine(Theme.of(context).colorScheme.primary),
        ],
      ),
    );
  }

  Widget buildSeparatorLine(Color color) {
    return Flexible(
      child: Container(
        height: 5,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10000),
          border: Border.all(
            color: Colors.black,
            width: 1.5,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
      ),
    );
  }
}
