import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Rating extends StatelessWidget {
  final int selected;
  final MainAxisAlignment alignment;
  final double size;

  const Rating({
    super.key,
    required this.selected,
    this.alignment = MainAxisAlignment.start,
    this.size = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: [
        for (var i = 0; i < selected; i++)
          SvgPicture.asset(
            "assets/svg/star_fill.svg",
            colorFilter: const ColorFilter.mode(
              Color(0xFFFFD16A),
              BlendMode.srcIn,
            ),
            width: size,
            height: size,
          ),
        for (var i = 0; i < 5 - selected; i++)
          SvgPicture.asset(
            "assets/svg/star_outline.svg",
            width: size,
            height: size,
          ),
      ],
    );
  }
}
