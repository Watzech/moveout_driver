// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class DriverSummaryElement extends StatelessWidget {
  DriverSummaryElement({
    super.key,
    required this.title,
    this.titleSize = 0,
    required this.content,
    this.contentSize = 0,
  });

  String title;
  dynamic content;
  double titleSize;
  double contentSize;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;

    titleSize = titleSize == 0 ? screenHeight * 0.016 : titleSize;
    contentSize = contentSize == 0 ? screenHeight * 0.020 : contentSize;

    var subscription;
    var color;

    try {
      subscription = content["name"];
      color = content["color"];
    } catch (e) {}

    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: titleSize,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.bold),
        ),
        Text(
          subscription ?? content,
          style: TextStyle(
              fontSize: contentSize,
              color: color != null ? HexColor(color) : Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
