// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomSummaryTitle extends StatelessWidget {
  const CustomSummaryTitle({
    super.key,
    required this.context,
    required this.title,
  });

  final BuildContext context;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 20.0, right: 20.0, top: 20.0, bottom: 15.0),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              fontFamily: 'BebasKai',
              fontSize: 35,
              color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
