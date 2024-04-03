import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  static const textStyle = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  const CustomButton({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: Size(0.8883 * width, 64),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: const Color(0xFF2D4CF9)),
      onPressed: () {},
      child: const Text("Proceed", style: textStyle,),
    );
  }
}
