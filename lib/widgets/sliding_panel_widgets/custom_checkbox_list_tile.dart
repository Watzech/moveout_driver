// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomCheckboxTextListTile extends StatefulWidget {
  CustomCheckboxTextListTile({
    Key? key,
    required this.label,
    required this.checkboxValue,
    required this.callback,
    required this.onChangedFunction,
    required this.textController,
  }) : super(key: key);

  final String label;
  bool checkboxValue;
  final ValueChanged<bool> callback;
  final VoidCallback onChangedFunction;
  final TextEditingController textController;

  @override
  State<CustomCheckboxTextListTile> createState() =>
      _CustomCheckboxTextListTileState();
}

class _CustomCheckboxTextListTileState extends State<CustomCheckboxTextListTile>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  // bool checkboxValue = false;

  void _sendDataToParent(bool value) {
    widget.callback(value);
  }

  @override
  void dispose() {
    widget.textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckboxListTile(
          title: Text(
            widget.label,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          side: BorderSide(color: Theme.of(context).colorScheme.primary),
          dense: true,
          checkColor: Theme.of(context).colorScheme.secondary,
          value: widget.checkboxValue,
          onChanged: (bool? value) {
            setState(() {
              widget.checkboxValue = value ?? false;
              if (!widget.checkboxValue) {
                widget.textController.clear();
              }
            });
            _sendDataToParent(widget.checkboxValue);
            widget.onChangedFunction();
          },
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: Visibility(
            visible: widget.checkboxValue,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 35, 15),
              child: Row(
                children: [
                  Icon(
                    Icons.subdirectory_arrow_right_sharp,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: TextField(
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                        controller: widget.textController,
                        onChanged: (String value) {
                          widget.onChangedFunction();
                        },
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                          contentPadding: const EdgeInsets.all(1),
                          hintText: 'Descreva seus itens...',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomCheckboxListTile extends StatefulWidget {
  CustomCheckboxListTile({
    super.key,
    required this.label,
    required this.checkboxValue,
    required this.callback,
    required this.onChangedFunction,
  });

  final String label;
  bool checkboxValue;
  final ValueChanged<bool> callback;
  final void Function() onChangedFunction;

  @override
  State<CustomCheckboxListTile> createState() => _CustomCheckboxListTileState();
}

class _CustomCheckboxListTileState extends State<CustomCheckboxListTile>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

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
      value: widget.checkboxValue,
      onChanged: (bool? value) {
        setState(() {
          widget.checkboxValue = value!;
          _sendDataToParent(widget.checkboxValue);
        });
        widget.onChangedFunction();
      },
    );
  }
}
