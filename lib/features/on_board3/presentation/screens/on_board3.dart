import 'dart:developer';

import 'package:attach_club/core/components/button.dart';
import 'package:attach_club/core/components/heading.dart';
import 'package:attach_club/core/components/label.dart';
import 'package:attach_club/core/components/onboarding_hero.dart';
import 'package:attach_club/core/constants.dart';
import 'package:attach_club/features/on_board3/bloc/on_board3_bloc.dart';
import 'package:attach_club/features/on_board3/data/models/social_link.dart';
import 'package:attach_club/features/on_board3/presentation/screens/platform_list_modal.dart';
import 'package:attach_club/features/on_board3/presentation/widgets/social_link_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoard3 extends StatefulWidget {
  const OnBoard3({super.key});

  @override
  State<OnBoard3> createState() => _OnBoard3State();
}

class _OnBoard3State extends State<OnBoard3> {
  final List<SocialLink> list = [];

  _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).pushNamed("/onboard4");
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<OnBoard3Bloc, OnBoard3State>(
          listener: (context, state) {
            if (state is AddToList) {
              list.add(state.socialLink);
            }
            if(state is EditList){
              list.remove(state.oldSocialLink);
              list.add(state.socialLink);
            }
            if(state is DeleteFromList){
              list.remove(state.socialLink);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: onBoardingHorizontalPadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OnBoardingHero(
                          totalBars: 4,
                          selectedBars: 3,
                          showSkipButton: true,
                          onSkip: () {
                            _navigateToNextScreen(context);
                          },
                        ),
                        SizedBox(
                          height: 0.0257 * height,
                        ),
                        const Heading(title: "Add Socials Links"),
                        SizedBox(
                          height: 0.0343 * height,
                        ),
                        const Label(
                          title:
                              "Add social media links and other information's",
                        ),
                        SizedBox(
                          height: 0.0257 * height,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return SocialLinkCard(
                              socialLink: list[index],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      CustomButton(
                        onPressed: () {
                          showPlatformListModal(context);
                        },
                        title: "Add Links",
                        assetName: "assets/svg/link.svg",
                        isDark: true,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomButton(
                        onPressed: () {
                          _navigateToNextScreen(context);
                        },
                        title: "Next",
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
