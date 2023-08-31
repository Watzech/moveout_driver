import 'package:flutter/material.dart';

class IconButtonWidget extends StatefulWidget {
  final IconData selectedIcon;
  const IconButtonWidget({super.key, required this.selectedIcon});

  @override
  State<IconButtonWidget> createState() => _IconButtonWidgetState();
}

class _IconButtonWidgetState extends State<IconButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(20),
        backgroundColor: Theme.of(context).colorScheme.secondary, // <-- Button color
      ),
      child: Icon(widget.selectedIcon, color: Colors.white,)
    );
  }
}