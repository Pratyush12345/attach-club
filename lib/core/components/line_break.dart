import 'package:flutter/material.dart';

class LineBreak extends StatelessWidget {
  const LineBreak({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Container(
          height: 1,
          color: Colors.white.withOpacity(0.1),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
