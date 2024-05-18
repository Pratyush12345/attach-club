import 'package:attach_club/bloc/profile_image/profile_image_bloc.dart';
import 'package:attach_club/constants.dart';
import 'package:attach_club/views/profile_image/upload_images_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/components/button.dart';
import '../../core/components/heading.dart';
import '../../core/components/label.dart';
import '../../core/components/onboarding_hero.dart';

class ProfileImage extends StatefulWidget {
  final bool isInsideManageProfile;

  const ProfileImage({
    super.key,
    this.isInsideManageProfile = false,
  });

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).pushNamed("/onboard3");
  }

  @override
  void initState() {
    super.initState();
    final bloc = context.read<ProfileImageBloc>();
    if (bloc.lastUpdated == null ||
        DateTime.now().difference(bloc.lastUpdated!).inMinutes > 2) {
      bloc.add(FetchImages());
    }
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
              if (!widget.isInsideManageProfile)
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

  _getHeader(BuildContext context, double height) {
    if (!widget.isInsideManageProfile) {
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
