import 'package:flutter/material.dart';

class ConfirmButtonWidget extends StatelessWidget {
  final String lbl;
  final VoidCallback submitFunction;
  double fontSize;
  String fontFamily;
  ConfirmButtonWidget(
      {super.key,
      required this.lbl,
      required this.submitFunction,
      this.fontSize = 12,
      this.fontFamily = ' '});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => submitFunction(),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).colorScheme.secondary),
        fixedSize: MaterialStateProperty.all(const Size(200, 60)),
      ),
      child: Text(
        lbl,
        textDirection: TextDirection.ltr,
        style: fontFamily == ' ' 
        ? TextStyle(
          color: Colors.white,
          fontSize: fontSize,
        )
        : TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontFamily: fontFamily
        ),
      ),
    );
  }
}
