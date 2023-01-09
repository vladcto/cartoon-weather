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
          buildSeparatorLine(context),
          Text(
            text,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          buildSeparatorLine(context),
        ],
      ),
    );
  }

  Widget buildSeparatorLine(BuildContext context) {
    return Flexible(
      child: Container(
        height: 6,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10000),
          border: Border.all(
            color: Colors.black,
            width: 2,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
      ),
    );
  }
}
