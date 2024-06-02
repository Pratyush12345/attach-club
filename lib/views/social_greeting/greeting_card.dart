import 'dart:io';
import 'package:attach_club/constants.dart';
import 'package:attach_club/core/repository/user_data_notifier.dart';
import 'package:attach_club/models/globalVariable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class GreetingCard extends StatelessWidget {
  
  ScreenshotController? screenshotController;
  final String fromScreen;
  String? imageurl;
  GreetingCard({super.key, @required this.screenshotController, @required this.imageurl, required this.fromScreen,});
 


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final userData = context.read<UserDataNotifier>().userData;

    return GestureDetector(
      onTap: (){
        if(fromScreen == "Dashboard"){
        if (userData.accountType == "premium") {
          Navigator.of(context).pushNamed("/greetings");
        } else {
          Navigator.of(context).pushNamed("/buyPlan");
        }
        }
      },
      child:  ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Column(
          children: [
            SizedBox(
               width: width * 0.8837209302,
               height: width * 0.8837209302,
              child:  imageurl == "link" ? Shimmer.fromColors(
                                direction: ShimmerDirection.ltr,
                                  baseColor:  Colors.grey[800]!,
                                  highlightColor: Colors.grey[600]!,
                            
                                child: Container(
                                  color: Colors.white,
                                ),
                              ):
              
              CachedNetworkImage(
                placeholder: (context, url) {
                  return Shimmer.fromColors(
                                direction: ShimmerDirection.ltr,
                                  baseColor:  Colors.grey[800]!,
                                  highlightColor: Colors.grey[600]!,
                            
                                child: Container(
                                  color: Colors.white,
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
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: QrImageView(
                                        data: "${GlobalVariable.metaData.webURL}${GlobalVariable.userData.username}",
                                        version: QrVersions.auto,
                                        //size: 0.6813953488 * width,
                                        size: 80.0,
                                        backgroundColor: Colors.white,
                                      ),
                              ), 
                              
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            children: [
                               Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 24.0,
                                          width: 24.0,
                                          child: Image.asset("assets/images/splash.png",)),
                                        
                                        const SizedBox(
                                          width: 4.0,
                                        ),
                                        const Text(
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        if(GlobalVariable.userData.phoneNo.isNotEmpty)
                                        const Icon(
                                          Icons.call,
                                          color: Colors.blueAccent,
                                        ),
                                        Text(GlobalVariable.userData.phoneNo,
                                            style:  const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                       SvgPicture.asset("assets/svg/share-whatsapp.svg", width: 24.0,height: 24.0,),
                                       
                                        Text('wa.me/${GlobalVariable.userData.phoneNo}',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400)),
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
