import 'dart:io';

import 'package:attach_club/constants.dart';
import 'package:attach_club/core/components/button.dart';
import 'package:attach_club/core/repository/user_data_notifier.dart';
import 'package:attach_club/models/globalVariable.dart';

//import 'package:attach_club/models/user_data.dart';
import 'package:attach_club/views/social_greeting/greeting_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import 'package:cached_network_image/cached_network_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class GreetingDashboard extends StatefulWidget {
  String? imagelink;
  String? fileName;

  GreetingDashboard({super.key, this.imagelink, this.fileName});

  @override
  State<GreetingDashboard> createState() => _GreetingDashboardState();
}

class _GreetingDashboardState extends State<GreetingDashboard> {
  ScreenshotController screenshotController = ScreenshotController();

  PermissionStatus _permissionStatus = PermissionStatus.denied;

   Future<void> requestPermission(Permission permission) async {
          final status = await permission.request();
          setState(() {
            print(status);
            _permissionStatus = status;
          });
        }

  getpermissionStatus() async{
    print("${await Permission.storage.status}");
  _permissionStatus = await Permission.storage.status;
   if(_permissionStatus == PermissionStatus.denied){
    requestPermission(Permission.storage);
   }
  }

  shareWidget()async{
       
       if(_permissionStatus == PermissionStatus.granted){
       screenshotController.capture(delay: Duration(milliseconds: 10))
              .then((capturedImage) async {
                Directory? tempDir = await getDownloadsDirectory();
                String tempPath = tempDir!.path;

                String filename = "image${widget.fileName!.replaceAll(".jpg", "")}.jpg";
                //String imagePath = '/storage/emulated/0/Download/$filename';
                String imagePath = '$tempPath/$filename'; 
                //ShowCapturedWidget(context, capturedImage!);
                print("path----------$imagePath");
                File imageFile = File(imagePath);

                //notification(filename, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZ1VuKA1bfF-J9EICmf9n4YvfTkXkhQb4Zln2kVXHZnw&s');
                await imageFile.writeAsBytes(capturedImage!.buffer.asUint8List());
                String text = "${GlobalVariable.metaData.message!.replaceAll("newline ", "\n").replaceAll("#name", GlobalVariable.userData.name)} \n ${GlobalVariable.metaData.webURL! + GlobalVariable.userData.username}";

                Share.shareXFiles([XFile(imagePath)], text: text);

              }).catchError((onError) {
                print(onError);
                ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(onError.toString()),
                ),
              );
              });
       }
       else{
         requestPermission(Permission.storage);
       }
  }

  @override
  void initState() {
    getpermissionStatus();
    super.initState();
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
            imageurl: widget.imagelink,
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
