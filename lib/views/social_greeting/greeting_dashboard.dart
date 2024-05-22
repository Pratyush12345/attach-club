import 'dart:io';

import 'package:attach_club/constants.dart';
import 'package:attach_club/core/components/button.dart';
import 'package:attach_club/core/repository/user_data_notifier.dart';
import 'package:attach_club/models/user_data.dart';
import 'package:attach_club/views/social_greeting/greeting_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class GreetingDashboard extends StatelessWidget {
  GreetingDashboard({super.key});

  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: horizontalPadding,
          ),
          child: GreetingCard(
            imageurl:
                "https://buffer.com/library/content/images/2023/10/free-images.jpg",
            screenshotController: screenshotController,
          ),
        ),
        SizedBox(height: 0.01716738197 * height),
        SizedBox(width: 0.01716738197 * height),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: horizontalPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                onPressed: () {
                  if (context.read<UserDataNotifier>().userData.accountType ==
                      "premium") {
                    Navigator.of(context).pushNamed("/greetings");
                  } else {
                    Navigator.of(context).pushNamed("/buyPlan");
                  }
                },
                title: "View More",
                isDark: true,
                buttonWidth: 0.4255813953,
                buttonType: ButtonType.ShortButton,
              ),
              CustomButton(
                onPressed: () {},
                title: "Share",
                buttonWidth: 0.4255813953,
                buttonType: ButtonType.ShortButton,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
