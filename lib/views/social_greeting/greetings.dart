import 'dart:io';

import 'package:attach_club/bloc/greetings/greetings_bloc.dart';
import 'package:attach_club/core/components/button.dart';
import 'package:attach_club/core/components/text_field.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:attach_club/views/social_greeting/greeting_card.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class Greetings extends StatefulWidget {
  const Greetings({super.key});

  @override
  State<Greetings> createState() => _GreetingsState();
}

class _GreetingsState extends State<Greetings> {

  final searchController = TextEditingController();
  int selectedTopic = 0;
  int selectedImage = 0;
  ScreenshotController screenshotController = ScreenshotController();
  
  shareWidget(){
       screenshotController!.capture(delay: Duration(milliseconds: 10))
              .then((capturedImage) async {
                //Directory? tempDir = await getExternalStorageDirectory();
                //String tempPath = tempDir!.path;

                String filename = "image${DateTime.now().minute}.jpg";
                String imagePath = '/storage/emulated/0/Download/$filename';

                //ShowCapturedWidget(context, capturedImage!);
                print("path----------$imagePath");
                File imageFile = File(imagePath);

                //notification(filename, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZ1VuKA1bfF-J9EICmf9n4YvfTkXkhQb4Zln2kVXHZnw&s');
                await imageFile.writeAsBytes(capturedImage!.buffer.asUint8List());

                Share.shareXFiles([XFile(imagePath)], text: "Hello message!!");

              }).catchError((onError) {
                print(onError);
              });
  }
  @override
  void initState() {
    super.initState();
    //context.read<GreetingsBloc>().add(const GetGreetings());
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Social Greetings"),
      ),
      body: SafeArea(
        child: BlocConsumer<GreetingsBloc, GreetingsState>(
          listener: (context, state) {
            if (state is ShowSnackBar) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            final bloc = context.read<GreetingsBloc>();
            if (state is GreetingsLoading || bloc.filteredList.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 0.01502145923 * height),
                      CustomTextField(
                        type: TextFieldType.RegularTextField,
                        controller: searchController,
                        hintText: "Search greetings...",
                        prefixWidget: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 0.01502145923 * height),
                      SizedBox(
                        height: 38,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: bloc.filteredList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedTopic = index;
                                });
                              },
                              child: Container(
                                height: 38,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(54),
                                    color: (selectedTopic == index)
                                        ? const Color(0xFF2D4CF9)
                                        : const Color(0xFF181B2F)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        bloc.filteredList[index].categoryName,
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 0.03326180258 * height),
                      
                        // child: CachedNetworkImage(
                        //   placeholder: (context, url) =>
                        //       const CircularProgressIndicator(
                        //         color: Colors.purple,
                        //       ),
                        //   imageUrl: bloc.filteredList[selectedTopic]
                        //       .templates[selectedImage].link,
                        //   imageBuilder: (context, imageProvider) => Container(
                        //     width: width * 0.8837209302,
                        //     height: width * 0.8837209302,
                        //     decoration: BoxDecoration(
                        //       image: DecorationImage(
                        //         image: imageProvider,
                        //         fit: BoxFit.cover,
                        //       ),
                        //     ),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Padding(
                        //           padding: const EdgeInsets.all(8.0),
                        //           child: Container(
                        //             width: 80.0,
                        //             decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(12.0),
                        //               color: Colors.white,
                        //             ),
                        //             child: const Align(
                        //               alignment: Alignment.topLeft,
                        //               child: Icon(
                        //                 Icons.qr_code_2,
                        //                 size: 80.0,
                        //                 color: Colors.black,
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //         Align(
                        //           alignment: Alignment.bottomCenter,
                        //           child: Column(
                        //             children: [
                        //               const Padding(
                        //                 padding: EdgeInsets.all(8.0),
                        //                 child: Align(
                        //                     alignment: Alignment.topLeft,
                        //                     child: Row(
                        //                       children: [
                        //                         Icon(
                        //                           Icons.light_mode_outlined,
                        //                           color: Colors.white,
                        //                         ),
                        //                         SizedBox(
                        //                           width: 4.0,
                        //                         ),
                        //                         Text(
                        //                             'Powered by Attach Club\ndownload app today',
                        //                             style: TextStyle(
                        //                                 color: Colors.white,
                        //                                 fontWeight:
                        //                                     FontWeight.normal,
                        //                                 fontSize: 12.0)),
                        //                       ],
                        //                     )),
                        //               ),
                        //               const SizedBox(height: 2.0),
                        //               Container(
                        //                 height: 30.0,
                        //                 decoration: const BoxDecoration(
                        //                   color: Colors.white,
                        //                 ),
                        //                 child: const Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.spaceEvenly,
                        //                   children: [
                        //                     Row(
                        //                       children: [
                        //                         Icon(
                        //                           Icons.call,
                        //                           color: Colors.blueAccent,
                        //                         ),
                        //                         Text(
                        //                           '7985624428',
                        //                           style: TextStyle(
                        //                             color: Colors.black,
                        //                             fontWeight: FontWeight.bold,
                        //                           ),
                        //                         ),
                        //                       ],
                        //                     ),
                        //                     Row(
                        //                       children: [
                        //                         Icon(
                        //                           Icons.wechat_sharp,
                        //                           color: Colors.green,
                        //                         ),
                        //                         Text(
                        //                           'wa.me/+917985624428',
                        //                           style: TextStyle(
                        //                             color: Colors.black,
                        //                             fontWeight: FontWeight.bold,
                        //                           ),
                        //                         ),
                        //                       ],
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),

                      GreetingCard(imageurl: bloc.filteredList[selectedTopic].templates[selectedImage].link , screenshotController:  screenshotController , ),
                      
                      SizedBox(height: 0.02145922747 * height),
                      SizedBox(
                        height: 0.1126609442 * height,
                        width: width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount:
                              bloc.filteredList[selectedTopic].templates.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedImage = index;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5.5,
                                ),
                                child: Container(
                                  height: 0.1126609442 * height,
                                  width: 0.1126609442 * height,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: (selectedImage == index)
                                        ? Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          )
                                        : null,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CachedNetworkImage(
                                        placeholder: (context, url) {
                                          return const SizedBox(
                                              height: 10.0,
                                              width: 10.0,
                                              child: Center(
                                                child: CircularProgressIndicator(
                                                  color: Colors.purple,
                                                ),
                                              ),
                                            );
                                        },
                                        imageUrl: bloc
                                            .filteredList[selectedTopic]
                                            .templates[index]
                                            .link,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 11.0),
                    child: CustomButton(
                      onPressed: () {
                        shareWidget();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Downloading image...",
                            ),
                          ),
                        );
                      },
                      title: "Share this Greetings",
                    ),
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
