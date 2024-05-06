import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String title;

  const CustomContainer({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 64,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Row(
            children: [
              Text(
                title,
                style: _getTextStyle(
                  Colors.white,
                  20,
                  FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
    );
  }

  _getTextStyle(Color color, double fontSize, FontWeight weight) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: weight,
    );
  }
}
