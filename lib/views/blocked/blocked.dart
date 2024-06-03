import 'package:attach_club/constants.dart';
import 'package:attach_club/core/components/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BlockedScreen extends StatelessWidget {
  const BlockedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 0.3906976744 * width,
                height: 0.3906976744 * width,
                decoration: BoxDecoration(
                  color: const Color(0xFF26293B),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/svg/close.svg",
                    width: 48,
                    height: 48,
                  ),
                ),
              ),
              SizedBox(height: 0.03433476395 * height),
              const Text(
                "You are Blocked by admin",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Kindly contact admin for unblocking the account",
                style: TextStyle(
                  color: paragraphTextColor,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 0.02575107296 * height),
              CustomButton(
                onPressed: () {},
                title: "Contact",
                buttonType: ButtonType.ShortButton,
                buttonWidth: 0.4279069767,
              )
            ],
          ),
        ),
      ),
    );
  }
}
