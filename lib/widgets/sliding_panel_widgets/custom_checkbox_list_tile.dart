// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomCheckboxListTile extends StatefulWidget {
  const CustomCheckboxListTile({
    super.key,
    required this.label,
    required this.callback,
    required this.onChangedFunction,
  });

  final String label;
  final ValueChanged<bool> callback;
  final void Function() onChangedFunction;

  @override
  State<CustomCheckboxListTile> createState() => _CustomCheckboxListTileState();
}

class _CustomCheckboxListTileState extends State<CustomCheckboxListTile>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool checkboxValue = false;

  void _sendDataToParent(bool value) {
    widget.callback(value);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CheckboxListTile(
      title: Text(
        widget.label,
        style: const TextStyle(
          fontSize: 13,
        ),
      ),
      side: BorderSide(color: Theme.of(context).colorScheme.primary),
      dense: true,
      checkColor: Theme.of(context).colorScheme.secondary,
      value: checkboxValue,
      onChanged: (bool? value) {
        setState(() {
          checkboxValue = value!;
          _sendDataToParent(checkboxValue);
        });
        widget.onChangedFunction();
      },
    );
  }
}
