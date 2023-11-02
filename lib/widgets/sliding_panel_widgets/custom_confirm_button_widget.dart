// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class SlidingPanelConfirmButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressedFunction;
  final bool isEnabled;

  const SlidingPanelConfirmButtonWidget({
    super.key,
    required this.text,
    required this.onPressedFunction,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    return ElevatedButton(
      onPressed: isEnabled ? onPressedFunction : null,
      style: isEnabled
          ? ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.secondary),
              fixedSize: MaterialStateProperty.all(Size(screenWidth * 0.55, screenHeight * 0.075)),
            )
          : ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.onBackground),
              fixedSize: MaterialStateProperty.all(Size(screenWidth * 0.55, screenHeight * 0.075)),
            ),
      child: Text(
        text,
        textDirection: TextDirection.ltr,
        style: const TextStyle(
            color: Colors.white, fontSize: 25, fontFamily: 'BebasKai'),
      ),
    );
  }
}
