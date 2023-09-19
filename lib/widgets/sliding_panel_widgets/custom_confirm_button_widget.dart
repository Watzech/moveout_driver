// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class SlidingPanelConfirmButtonWidget extends StatefulWidget {
  final String text;
  final VoidCallback submitFunction;
  final TextEditingController originAddressController;
  final TextEditingController destinationAddressController;
  final TextEditingController firstDateController;
  final TextEditingController secondDateController;
  final bool furnitureCheckValue;
  final bool boxCheckValue;
  final bool fragileCheckValue;
  final bool otherCheckValue;

  bool isButtonEnabled = false;

  SlidingPanelConfirmButtonWidget({
    super.key,
    required this.text,
    required this.submitFunction,
    required this.originAddressController,
    required this.destinationAddressController,
    required this.firstDateController,
    required this.secondDateController,
    required this.furnitureCheckValue,
    required this.boxCheckValue,
    required this.fragileCheckValue,
    required this.otherCheckValue,
  });

  @override
  State<SlidingPanelConfirmButtonWidget> createState() =>
      _SlidingPanelConfirmButtonWidgetState();
}

class _SlidingPanelConfirmButtonWidgetState
    extends State<SlidingPanelConfirmButtonWidget> {
  @override
  void initState() {
    super.initState();
    setState(() {
      if ((widget.originAddressController.text.isNotEmpty) &&
          (widget.destinationAddressController.text.isNotEmpty) &&
          ((widget.furnitureCheckValue ||
              widget.boxCheckValue ||
              widget.fragileCheckValue ||
              widget.otherCheckValue)) &&
          (widget.firstDateController.text.isNotEmpty) &&
          (widget.secondDateController.text.isNotEmpty)) {
        widget.isButtonEnabled = true;
      } else {
        widget.isButtonEnabled = false;
      }
    });
  }

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
