import 'package:attach_club/core/components/button.dart';
import 'package:attach_club/core/components/heading.dart';
import 'package:attach_club/core/components/label.dart';
import 'package:attach_club/core/components/onboarding_hero.dart';
import 'package:attach_club/core/constants.dart';
import 'package:attach_club/features/on_board2/presentation/widgets/upload_images_component.dart';
import 'package:flutter/material.dart';

class OnBoard2 extends StatelessWidget {
  const OnBoard2({super.key});

  _navigateToNextScreen(BuildContext context){
    Navigator.of(context).pushNamed("/onboard3");
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: onBoardingHorizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OnBoardingHero(
                      totalBars: 4,
                      selectedBars: 2,
                      showSkipButton: true,
                      onSkip: (){
                        _navigateToNextScreen(context);
                      },
                    ),
                    SizedBox(
                      height: 0.0257 * height,
                    ),
                    const Heading(title: "Display"),
                    SizedBox(
                      height: 0.0343 * height,
                    ),
                    const Label(
                        title:
                            "Upload your character to make fantastic first impression Let your personality shine"),
                    SizedBox(
                      height: 0.0257 * height,
                    ),
                    const UploadImagesComponent(),
                  ],
                ),
              ),
              CustomButton(
                onPressed: (){
                  _navigateToNextScreen(context);
                },
                title: "Next",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
