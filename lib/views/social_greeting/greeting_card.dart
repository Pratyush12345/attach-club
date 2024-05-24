import 'dart:io';
import 'package:attach_club/constants.dart';
import 'package:attach_club/core/repository/user_data_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class GreetingCard extends StatelessWidget {
  
  ScreenshotController? screenshotController;
  String? imageurl;
  GreetingCard({super.key, @required this.screenshotController, @required this.imageurl,});
 


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final userData = context.read<UserDataNotifier>().userData;

    return GestureDetector(
      onTap: (){
        if (userData.accountType == "premium") {
          Navigator.of(context).pushNamed("/greetings");
        } else {
          Navigator.of(context).pushNamed("/buyPlan");
        }
      },
      child:  ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Column(
          children: [
            SizedBox(
               width: width * 0.8837209302,
               height: width * 0.8837209302,
              child:  imageurl == "link" ? const SizedBox(
                                height: 20.0,
                                width: 20.0,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.purple,
                                  ),
                                ),
                              ):
              
              CachedNetworkImage(
                placeholder: (context, url) {
                  return const SizedBox(
                                height: 20.0,
                                width: 20.0,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.purple,
                                  ),
                                ),
                              );
                },
                imageUrl: imageurl!,
                imageBuilder: (context, imageProvider) => Screenshot(
                  controller: screenshotController!,
                  child: Container(
                    width: width * 0.8837209302,
                    height: width * 0.8837209302,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 80.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.white,
                            ),
                            child: const Align(
                              alignment: Alignment.topLeft,
                              child: Icon(
                                Icons.qr_code_2,
                                size: 80.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.light_mode_outlined,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 4.0,
                                        ),
                                        Text(
                                            'Powered by Attach Club\ndownload app today',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 12.0)),
                                      ],
                                    )),
                              ),
                              const SizedBox(height: 2.0),
                              Container(
                                height: 30.0,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.call,
                                          color: Colors.blueAccent,
                                        ),
                                        Text('7985624428',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.wechat_sharp,
                                          color: Colors.green,
                                        ),
                                        Text('wa.me/+917985624428',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        
            //     MaterialButton(onPressed: (){
        
            //   screenshotController!.capture(delay: Duration(milliseconds: 10))
            //     .then((capturedImage) async {
            //       Directory? tempDir = await getExternalStorageDirectory();
            //       String tempPath = tempDir!.path;
        
            //       String filename = "image${DateTime.now().minute}.jpg";
            //       String imagePath = '/storage/emulated/0/Download/$filename';
        
            //       //ShowCapturedWidget(context, capturedImage!);
            //       print("path----------$imagePath");
            //       File imageFile = File(imagePath);
        
            //       //notification(filename, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZ1VuKA1bfF-J9EICmf9n4YvfTkXkhQb4Zln2kVXHZnw&s');
            //       await imageFile.writeAsBytes(capturedImage!.buffer.asUint8List());
        
            //       Share.shareXFiles([XFile(imagePath)], text: "Hello message!!");
        
            //     }).catchError((onError) {
            //       print(onError);
            //     });
        
            // },
            // child: Text("Share"),
            // )
          ],
        ),
      ),
    );
  }
}
