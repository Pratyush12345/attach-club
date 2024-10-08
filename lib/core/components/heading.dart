import 'package:attach_club/constants.dart';
import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String title;

  const Heading({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
    );
  }
}
