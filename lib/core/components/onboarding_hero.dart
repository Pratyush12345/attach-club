import 'package:attach_club/constants.dart';
import 'package:attach_club/core/components/step_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingHero extends StatelessWidget {
  final int totalBars;
  final int selectedBars;
  final bool showBackButton;
  final bool showSkipButton;
  final void Function()? onSkip;
  final void Function()? onBack;

  const OnBoardingHero({
    super.key,
    required this.totalBars,
    required this.selectedBars,
    this.showBackButton = false,
    this.showSkipButton = false,
    this.onSkip,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: 0.0622 * height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _getBackButton(),
              _getSkipButton(),
            ],
          ),
        ),
        StepProgressIndicator(
          padding: horizontalPadding,
          totalBars: totalBars,
          selectedBars: selectedBars,
        ),
      ],
    );
  }

  Widget _getBackButton() {
    if (showBackButton) {
      return GestureDetector(
        onTap: onBack,
        child: SvgPicture.asset(
          "assets/svg/arrow_left.svg",
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
          semanticsLabel: 'A red up arrow',
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _getSkipButton() {
    if (showSkipButton) {
      return GestureDetector(
        onTap: onSkip,
        child: const Text(
          "Skip",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
