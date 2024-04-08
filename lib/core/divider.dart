import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(height: 0.02575107296 * height),
        Container(
          height: 1,
          width: double.infinity,
          color: Colors.white.withOpacity(0.1),
        ),
        SizedBox(height: 0.02575107296 * height),
      ],
    );
  }
}
