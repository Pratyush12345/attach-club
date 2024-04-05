import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String title;

  const Label({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: title,
        style: const TextStyle(
          color: Color(0xFFCED2D6),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
