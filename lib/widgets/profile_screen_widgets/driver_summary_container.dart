// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DriverSummaryContainer extends StatelessWidget {
  DriverSummaryContainer({
    super.key,
    required this.containerWidth,
    required this.containerHeight,
    required this.childrenWidgets,
  });

  final double containerWidth;
  final double containerHeight;
  Widget childrenWidgets;
  final reaisFormatter = NumberFormat("'R\$:' #,##0.00");

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: containerWidth,
          height: containerHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 5.0,
                  spreadRadius: 2.0,
                  color: Theme.of(context).colorScheme.shadow),
            ],
            border: Border.all(
                color: Theme.of(context).colorScheme.primary, width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: childrenWidgets),
    );
  }
}
