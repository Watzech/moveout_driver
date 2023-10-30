// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomIcons {
  CustomIcons._();

  static const _kFontFam = 'CustomIcons';
  static const String? _kFontPkg = null;

  static const IconData truck =
      IconData(0xf0d1, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData truckMoving =
      IconData(0xf4df, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData truckPickup =
      IconData(0xf63c, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}

class TransportSizeSegmentedButton extends StatefulWidget {
  final ValueChanged<String> callback;
  const TransportSizeSegmentedButton({super.key, required this.callback});

  @override
  State<TransportSizeSegmentedButton> createState() =>
      _TransportSizeSegmentedButtonState();
}

class _TransportSizeSegmentedButtonState
    extends State<TransportSizeSegmentedButton> {
  void _sendDataToParent(String value) {
    widget.callback(value);
  }

  String transportSize = ' ';
  Color sColor = Colors.white;
  Color mColor = Colors.white;
  Color lColor = Colors.white;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    transportSize = 'S';
    sColor = Theme.of(context).colorScheme.secondary;
  }

  @override
  Widget build(BuildContext context) {
    double iconSize = MediaQuery.of(context).size.height * 0.025;
    double textSize = MediaQuery.of(context).size.height * 0.020;
    return SegmentedButton<String>(
      segments: <ButtonSegment<String>>[
        ButtonSegment<String>(
            value: 'S',
            label: Text(' Pequeno', style: TextStyle(color: sColor, fontSize: textSize)),
            icon: Icon(
              CustomIcons.truckPickup,
              color: sColor,
              size: iconSize,
            )),
        ButtonSegment<String>(
            value: 'M',
            label: Text(' Médio', style: TextStyle(color: mColor, fontSize: textSize)),
            icon: Icon(
              CustomIcons.truck,
              color: mColor,
              size: iconSize,
            )),
        ButtonSegment<String>(
            value: 'L',
            label: Text(' Grande', style: TextStyle(color: lColor, fontSize: textSize)),
            icon: Icon(
              CustomIcons.truckMoving,
              color: lColor,
              size: iconSize,
            )),
      ],
      showSelectedIcon: false,
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
        side: MaterialStateProperty.all(const BorderSide(color: Colors.white)),
      ),
      selected: <String>{transportSize},
      onSelectionChanged: (Set<String> newSelection) {
        setState(() {
          transportSize = newSelection.first;
          switch (transportSize) {
            case 'S':
              sColor = Theme.of(context).colorScheme.secondary;
              mColor = Colors.white;
              lColor = Colors.white;
              break;
            case 'M':
              sColor = Colors.white;
              mColor = Theme.of(context).colorScheme.secondary;
              lColor = Colors.white;
              break;
            case 'L':
              sColor = Colors.white;
              mColor = Colors.white;
              lColor = Theme.of(context).colorScheme.secondary;
              break;
          }
          _sendDataToParent(transportSize);
        });
      },
    );
  }
}
