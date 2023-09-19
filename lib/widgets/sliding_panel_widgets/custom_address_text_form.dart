// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomAddressTextForm extends StatelessWidget {
  const CustomAddressTextForm({
    super.key,
    required this.icon,
    this.fontSize = 12,
    this.iconSize = 25,
    this.hintText = ' ',
    required this.textFieldController,
    required this.onChangedFunction,
  });

  final IconData icon;
  final double fontSize;
  final double iconSize;
  final String hintText;
  final TextEditingController textFieldController;
  final void Function(String?) onChangedFunction;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineBorder = OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
    );

    return TextFormField(
      controller: textFieldController,
      style: TextStyle(
        fontSize: fontSize,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(1),
        hintText: hintText,
        prefixIcon: Icon(
          icon,
          size: iconSize,
          color: Theme.of(context).colorScheme.secondary,
        ),
        enabledBorder: outlineBorder,
        border: outlineBorder,
      ),
      onChanged: onChangedFunction,
    );
  }
}
