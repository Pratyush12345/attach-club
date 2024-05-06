import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Rating extends StatelessWidget {
  final int selected;
  final MainAxisAlignment alignment;
  final double size;
  final void Function(int)? onPressed;

  const Rating({
    super.key,
    required this.selected,
    this.alignment = MainAxisAlignment.start,
    this.size = 12,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: [
        for (var i = 1; i <= selected; i++)
          GestureDetector(
            child: SvgPicture.asset(
              "assets/svg/star_fill.svg",
              colorFilter: const ColorFilter.mode(
                Color(0xFFFFD16A),
                BlendMode.srcIn,
              ),
              width: size,
              height: size,
            ),
            onTap: () {
              if (onPressed != null) {
                onPressed!(i);
              }
            },
          ),
        for (var i = selected + 1; i <= 5; i++)
          GestureDetector(
            child: SvgPicture.asset(
              "assets/svg/star_outline.svg",
              width: size,
              height: size,
            ),
            onTap: () {
              if (onPressed != null) {
                onPressed!(i);
              }
            },
          ),
      ],
    );
  }
}
