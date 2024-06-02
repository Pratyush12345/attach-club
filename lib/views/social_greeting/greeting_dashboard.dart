import 'dart:io';

import 'package:attach_club/constants.dart';
import 'package:attach_club/core/components/button.dart';
import 'package:attach_club/core/repository/user_data_notifier.dart';
//import 'package:attach_club/models/user_data.dart';
import 'package:attach_club/views/social_greeting/greeting_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:cached_network_image/cached_network_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class GreetingDashboard extends StatelessWidget {
  String? imagelink;
 
  GreetingDashboard({super.key, this.imagelink});

  ScreenshotController screenshotController = ScreenshotController();
  
  shareWidget(){
       screenshotController.capture(delay: Duration(milliseconds: 10))
              .then((capturedImage) async {
                //Directory? tempDir = await getExternalStorageDirectory();
                //String tempPath = tempDir!.path;

                String filename = "image${DateTime.now().minute}.jpg";
                String imagePath = '/storage/emulated/0/Download/$filename';

                //ShowCapturedWidget(context, capturedImage!);
                print("path----------$imagePath");
                File imageFile = File(imagePath);
                
                print(capturedImage);
                //notification(filename, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZ1VuKA1bfF-J9EICmf9n4YvfTkXkhQb4Zln2kVXHZnw&s');
                await imageFile.writeAsBytes(capturedImage!.buffer.asUint8List());

                Share.shareXFiles([XFile(imagePath)], text: "Hello message!!");

              }).catchError((onError) {
                print(onError);
              });
  }
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
            fromScreen: "Dashboard",
            imageurl: imagelink,
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
                  if (context.read<UserDataNotifier>().userData.accountType =="premium") {
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
                onPressed: () {
                  shareWidget();
                },
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
