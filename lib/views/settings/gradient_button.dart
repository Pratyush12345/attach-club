import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String title;
  final String subTitle;
  final Icon prefixIcon;
  final bool isGradient;
  final Color? textColor;

  const GradientButton({
    super.key,
    required this.title,
    required this.subTitle,
    required this.prefixIcon,
    this.isGradient = true,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF4285F4),
            Color(0xFF2D4CF9),
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          fixedSize: Size(0.88837 * width, 0.07725 * height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          shadowColor:
              (isGradient) ? Colors.transparent : const Color(0xFF26293B),
          backgroundColor:
              (isGradient) ? Colors.transparent : const Color(0xFF26293B),
        ),
        child: Row(
          children: [
            prefixIcon,
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: textColor??Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    subTitle,
                    style: TextStyle(
                      color: textColor??Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
