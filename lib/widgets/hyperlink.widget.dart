// hyperlink_widget.dart

import 'package:flutter/material.dart';

class HyperlinkWidget extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  HyperlinkWidget({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
