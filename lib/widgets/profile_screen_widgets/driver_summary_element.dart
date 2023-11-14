// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class DriverSummaryElement extends StatelessWidget {
  DriverSummaryElement({
    super.key,
    required this.title,
    this.titleSize = 0,
    required this.content,
    this.contentSize = 0,
  });

  String title;
  final String content;
  double titleSize;
  double contentSize;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;

    titleSize = titleSize == 0 ? screenHeight * 0.016 : titleSize;
    contentSize = contentSize == 0 ? screenHeight * 0.020 : contentSize;

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
          content,
          style: TextStyle(
              fontSize: contentSize,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
