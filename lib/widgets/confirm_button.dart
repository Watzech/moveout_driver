import 'package:flutter/material.dart';

class ConfirmButtonWidget extends StatelessWidget {
  final String lbl;
  const ConfirmButtonWidget({super.key, required this.lbl});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.secondary),
        fixedSize: MaterialStateProperty.all(const Size(200, 60)),
      ),
      child: Text(
        lbl,
        textDirection: TextDirection.ltr,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}