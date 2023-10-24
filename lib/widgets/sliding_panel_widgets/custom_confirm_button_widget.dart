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
    return ElevatedButton(
      onPressed: widget.isButtonEnabled ? widget.submitFunction : null,
      style: widget.isButtonEnabled
          ? ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.secondary),
              fixedSize: MaterialStateProperty.all(const Size(200, 60)),
            )
          : ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.onBackground),
              fixedSize: MaterialStateProperty.all(const Size(200, 60)),
            ),
      child: Text(
        widget.text,
        textDirection: TextDirection.ltr,
        style: const TextStyle(
            color: Colors.white, fontSize: 25, fontFamily: 'BebasKai'),
      ),
    );
  }
}
