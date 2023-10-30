// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class SlidingPanelConfirmButtonWidget extends StatefulWidget {
  final String text;
  final VoidCallback submitFunction;
  final bool isButtonEnabled;

  const SlidingPanelConfirmButtonWidget({
    super.key,
    required this.text,
    required this.submitFunction,
    required this.isButtonEnabled,
  });

  @override
  State<SlidingPanelConfirmButtonWidget> createState() =>
      _SlidingPanelConfirmButtonWidgetState();
}

class _SlidingPanelConfirmButtonWidgetState
    extends State<SlidingPanelConfirmButtonWidget> {
  @override
  Widget build(BuildContext context) {
    double iconHeight = MediaQuery.sizeOf(context).height * 0.1;
    double textSize = MediaQuery.sizeOf(context).height * 0.035;
    return ElevatedButton(
      onPressed: widget.isButtonEnabled ? widget.submitFunction : null,
      style: widget.isButtonEnabled
          ? ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.secondary),
              fixedSize: MaterialStateProperty.all(Size(200, iconHeight)),
            )
          : ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.onBackground),
              fixedSize: MaterialStateProperty.all(Size(200, iconHeight)),
            ),
      child: Text(
        widget.text,
        textDirection: TextDirection.ltr,
        style: TextStyle(
            color: Colors.white, fontSize: textSize, fontFamily: 'BebasKai'),
      ),
    );
  }
}
