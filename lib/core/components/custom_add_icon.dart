import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAddIcon extends StatelessWidget {
  const CustomAddIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 18,
      height: 18,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF2D4CF9),
                    Color(0xFFB2B3FF),
                  ],
                ),
                shape: BoxShape.circle),
          ),
          SvgPicture.asset(
            "assets/svg/plus.svg",
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
