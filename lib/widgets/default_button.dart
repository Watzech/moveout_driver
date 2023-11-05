import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    required this.text,
    required this.onPressedFunction,
    this.fontSize = 25,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback onPressedFunction;
  final bool isLoading;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    return isLoading
        ? ElevatedButton(
            onPressed: null,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.onBackground),
              fixedSize: MaterialStatePropertyAll(
                  Size(screenWidth * 0.60, screenHeight * 0.075)),
            ),
            child: const CircularProgressIndicator(
              color: Colors.white,
            ),
          )
        : ElevatedButton(
            onPressed: onPressedFunction,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.secondary),
              fixedSize: MaterialStatePropertyAll(
                  Size(screenWidth * 0.60, screenHeight * 0.075)),
            ),
            child: Text(
              text,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  color: Colors.white, fontSize: fontSize, fontFamily: 'BebasKai'),
            ),
          );
  }
}
