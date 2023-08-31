// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class BackgroundContainer extends StatefulWidget {
  final String src;
  Widget child;
  BackgroundContainer({super.key, required this.src, required this.child});

  @override
  State<BackgroundContainer> createState() => _BackgroundContainerState();
}

class _BackgroundContainerState extends State<BackgroundContainer> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.src),
          fit: BoxFit.cover,
        ),
      ),
      child: widget.child,
    );
  }
}
