import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        border: Border.all(
          width: 3,
          color: Theme.of(context).colorScheme.secondary,
        ),
        borderRadius: BorderRadius.circular(200),
      ),
      width: 75,
      height: 75,
      child: Icon(
        Icons.camera_alt,
        size: MediaQuery.sizeOf(context).width * 0.075,
        color: Theme.of(context).colorScheme.onBackground,
      ),
    );
  }
}