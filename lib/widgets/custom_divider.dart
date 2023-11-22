// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 0.25,
      color: Colors.grey[200],
    );
  }
}
