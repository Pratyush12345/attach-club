import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final int index;

  const Indicator({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < 3; i++)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: (i == index)
                  ? Colors.white
                  : const Color(0xFFD9D9D9).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
          )
      ],
    );
  }
}
