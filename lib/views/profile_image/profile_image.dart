import 'package:attach_club/core/button.dart';
import 'package:attach_club/constants.dart';
import 'package:attach_club/core/heading.dart';
import 'package:attach_club/core/label.dart';
import 'package:attach_club/core/onboarding_hero.dart';
import 'package:attach_club/views/profile_image/upload_images_component.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final bool isInsideManageProfile;

  const ProfileImage({
    super.key,
    this.isInsideManageProfile = false,
  });

  _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).pushNamed("/onboard3");
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._getHeader(context, height),
                    SizedBox(
                      height: 0.0257 * height,
                    ),
                    const UploadImagesComponent(),
                  ],
                ),
              ),
              if(!isInsideManageProfile)
                CustomButton(
                  onPressed: () {
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
  _getHeader(BuildContext context, double height){
    if(!isInsideManageProfile){
      return [
          OnBoardingHero(
            totalBars: 4,
            selectedBars: 2,
            showSkipButton: true,
            onSkip: () {
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
        ];
    }
    return [];
  }
}
