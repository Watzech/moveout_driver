// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

class CustomIconButtonContainer extends StatelessWidget {
  final VoidCallback submitFunction;
  final double size;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  const CustomIconButtonContainer({
    super.key,
    required this.submitFunction,
    required this.size,
    required this.icon,
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    final BoxShadow shadow = BoxShadow(
        blurRadius: 5.0,
        spreadRadius: 2.0,
        color: Theme.of(context).colorScheme.shadow);
    return Container(
      decoration: BoxDecoration(boxShadow: [shadow]),
      child: IconButton(
        onPressed: () => submitFunction(),
        icon: Icon(
          icon,
          color: iconColor,
          size: size,
        ),
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)))),
            backgroundColor:
                MaterialStateProperty.all(backgroundColor) // <-- Button color
            ),
      ),
    );
  }
}
