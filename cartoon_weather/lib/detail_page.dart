import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    width: 2,
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
                      padding: const EdgeInsets.all(4),
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: curTheme.colorScheme.primary,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(32),
                        ),
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
            )
          ],
        ),
      ),
    );
  }
}
