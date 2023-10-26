// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class SlidingPanelLoadingButtonWidget extends StatelessWidget {

  const SlidingPanelLoadingButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: null,
      style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.onBackground),
              fixedSize: MaterialStateProperty.all(const Size(200, 60)),
            ),
      child: const CircularProgressIndicator(color: Colors.white,),
    );
  }
}
