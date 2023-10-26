// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomSummarySubtextRow extends StatelessWidget {
  const CustomSummarySubtextRow({
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
      padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color:Colors.grey.shade700),
          ),
          Expanded(
              child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(fontSize: textSize.toDouble(), color:Colors.grey.shade500),
            textAlign: TextAlign.right,
          )),
        ],
      ),
    );
  }
}
