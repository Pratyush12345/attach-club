import 'package:attach_club/bloc/add_link/add_link_bloc.dart';
import 'package:attach_club/constants.dart';
import 'package:attach_club/core/components/button.dart';
import 'package:attach_club/core/components/heading.dart';
import 'package:attach_club/core/components/label.dart';
import 'package:attach_club/core/components/onboarding_hero.dart';
import 'package:attach_club/models/social_link.dart';
import 'package:attach_club/views/add_link/platform_list_modal.dart';
import 'package:attach_club/views/add_link/social_link_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddLink extends StatefulWidget {
  final bool isInsideManageProfile;

  const AddLink({
    super.key,
    this.isInsideManageProfile = false,
  });

  @override
  State<AddLink> createState() => _AddLinkState();
}

class _AddLinkState extends State<AddLink> {
  _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).pushNamed("/onboard4");
  }

  @override
  void initState() {
    super.initState();
    final bloc = context.read<AddLinkBloc>();
    if (bloc.lastUpdated == null ||
        DateTime.now().difference(bloc.lastUpdated!).inMinutes > 2) {
      bloc.add(FetchSocialLinks());
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AddLinkBloc, AddLinkState>(
          listener: (context, state) {
            // if (state is FetchedSocialLinks) {
            //   list = state.list;
            // }
            if (state is ShowSnackBar) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            final list = context.read<AddLinkBloc>().list;
            if (state is AddLinkLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ..._getHeader(height),
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
                              list: list,
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
                          showPlatformListModal(context, list);
                        },
                        title: "Add New Link",
                        assetName: "assets/svg/link.svg",
                        // isDark: true,
                      ),
                      const SizedBox(
                        height: 16,
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
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _getHeader(double height) {
    if (!widget.isInsideManageProfile) {
      return [
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
          title: "Add social media links and other information's",
        ),
      ];
    }
    return [];
  }
}
