import 'dart:convert';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
    required this.photoString,
  });

  final String photoString;

  @override
  Widget build(BuildContext context) {
    ImageProvider provider;
    provider = MemoryImage(base64Decode(photoString));

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
        child: ClipOval(
          child: SizedBox.fromSize(
            size: const Size.fromRadius(50),
            child: Image(image: provider, fit: BoxFit.cover),
          ),
        ));
  }
}
