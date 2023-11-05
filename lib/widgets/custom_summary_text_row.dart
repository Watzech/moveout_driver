// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomSummaryTextRow extends StatelessWidget {
  const CustomSummaryTextRow({
    super.key,
    required this.title,
    required this.text,
    this.textSize = 15,
  });

  final String title;
  final String text;
  final int textSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Expanded(
              child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(fontSize: textSize.toDouble()),
            textAlign: TextAlign.right,
          )),
        ],
      ),
    );
  }
}
