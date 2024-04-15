import 'dart:developer';

import 'package:attach_club/bloc/profile_privacy/profile_privacy_bloc.dart';
import 'package:attach_club/constants.dart';
import 'package:attach_club/views/profile_privacy/switch_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePrivacy extends StatefulWidget {
  const ProfilePrivacy({super.key});

  @override
  State<ProfilePrivacy> createState() => _ProfilePrivacyState();
}

class _ProfilePrivacyState extends State<ProfilePrivacy> {
  bool isBasicDetailEnabled = false;
  bool isLinkEnabled = false;
  bool isProductEnabled = false;
  bool isReviewEnabled = false;

  @override
  void initState() {
    super.initState();
    context.read<ProfilePrivacyBloc>().add(
          FetchAllStatus(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leadingWidth: 52,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        title: const Text(
          "Profile Privacy Settings",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed("/profile");
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(36))),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Center(
                      child: Text(
                    "View Profile",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.06545064378 * height),
          child: Padding(
            padding: EdgeInsets.only(bottom: 0.02789699571 * height),
            child: const Text(
              "Choose the details that you want to show to the users. ",
            ),
          ),
        ),
      ),
      body: BlocConsumer<ProfilePrivacyBloc, ProfilePrivacyState>(
        listener: (context, state) {
          if (state is BasicDetailsChanged) {
            isBasicDetailEnabled = state.isBasicDetailEnabled;
          }
          if (state is SocialLinkChanged) {
            isLinkEnabled = state.isLinkEnabled;
          }
          if (state is ProductsChanged) {
            isProductEnabled = state.isProductEnabled;
          }
          if (state is ReviewsChanged) {
            isReviewEnabled = state.isReviewEnabled;
          }
          if (state is StatusChanged) {
            isBasicDetailEnabled = state.isBasicDetailEnabled;
            isLinkEnabled = state.isLinkEnabled;
            isProductEnabled = state.isProductEnabled;
            isReviewEnabled = state.isReviewEnabled;
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 0.01675 * height),
                  SwitchCard(
                    title: "Basic Details",
                    subtitle:
                        "you can turn off if you want to hide your  basic details for users.",
                    value: isBasicDetailEnabled,
                    onChange: (newValue) {
                      context.read<ProfilePrivacyBloc>().add(
                            BasicDetailsTriggered(newValue),
                          );
                    },
                  ),
                  const SizedBox(height: 12),
                  SwitchCard(
                    title: "Social media links",
                    subtitle:
                        "you can turn off if you want to hide your  basic details for users.",
                    value: isLinkEnabled,
                    onChange: (newValue) {
                      context.read<ProfilePrivacyBloc>().add(
                            SocialLinkTriggered(newValue),
                          );
                    },
                  ),
                  const SizedBox(height: 12),
                  SwitchCard(
                    title: "Products",
                    subtitle:
                        "you can turn off if you want to hide your  basic details for users.",
                    value: isProductEnabled,
                    onChange: (newValue) {
                      context.read<ProfilePrivacyBloc>().add(
                            ProductsTriggered(newValue),
                          );
                    },
                  ),
                  const SizedBox(height: 12),
                  SwitchCard(
                    title: "Reviews",
                    subtitle:
                        "you can turn off if you want to hide your  basic details for users.",
                    value: isReviewEnabled,
                    onChange: (newValue) {
                      context.read<ProfilePrivacyBloc>().add(
                            ReviewsTriggered(newValue),
                          );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
