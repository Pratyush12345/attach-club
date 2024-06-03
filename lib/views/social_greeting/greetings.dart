import 'dart:io';

import 'package:attach_club/bloc/greetings/greetings_bloc.dart';
import 'package:attach_club/core/components/button.dart';
import 'package:attach_club/core/components/text_field.dart';
import 'package:attach_club/models/globalVariable.dart';
import 'package:attach_club/views/social_greeting/greeting_keep_alive.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:attach_club/views/social_greeting/greeting_card.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

class Greetings extends StatefulWidget {
  const Greetings({super.key});

  @override
  State<Greetings> createState() => _GreetingsState();
}

class _GreetingsState extends State<Greetings> {

  final searchController = TextEditingController();
  int selectedTopic = 0;
  int selectedImage = 0;
  String selectedCategory = "";
  String fileName = "greeting";
  ScreenshotController screenshotController = ScreenshotController();
  final ScrollController _scrollController = ScrollController();
  
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
  }

  shareWidget(String filename)async{
       
       if(_permissionStatus == PermissionStatus.granted){
       screenshotController.capture(delay: Duration(milliseconds: 10))
              .then((capturedImage) async {
                
                //String imagePath = '/storage/emulated/0/Download/$filename';

                Directory? tempDir = await getExternalStorageDirectory();
                String tempPath = tempDir!.path;

                String filename = "image${fileName.replaceAll(".jpg", "")}.jpg";
                //String imagePath = '/storage/emulated/0/Download/$filename';
                String imagePath = '$tempPath/$filename'; 

                //ShowCapturedWidget(context, capturedImage!);
                print("path----------$imagePath");
                File imageFile = File(imagePath);

                //notification(filename, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZ1VuKA1bfF-J9EICmf9n4YvfTkXkhQb4Zln2kVXHZnw&s');
                await imageFile.writeAsBytes(capturedImage!.buffer.asUint8List());
                String text = "${GlobalVariable.metaData.message!.replaceAll(" newline ", "\n").replaceAll("#name", GlobalVariable.userData.name)} \n ${GlobalVariable.metaData.webURL! + GlobalVariable.userData.username}";

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
    super.initState();
    getpermissionStatus();
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
                  color: Colors.grey,
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
                        onSubmitted: (String val){
                          
                         int index = bloc.filteredList.indexWhere((element) => element.categoryName.toLowerCase().contains(val.toLowerCase()));
                         if(index !=-1){
                           selectedTopic = index;
                           selectedImage = 0;
                           selectedCategory = bloc.filteredList[index].categoryName;
                            _scrollController.animateTo(
                            index * 56.0, // Assuming each item has a height of 56.0
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeInOut,
                          );
                           setState(() {}); 
                         }
                         else{
                           ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('category not found'),
                            ),
                          );

                         }
                        },
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
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: bloc.filteredList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              key: ValueKey(index.toString()),
                              onTap: () {
                                setState(() {
                                  selectedTopic = index;
                                  selectedImage = 0;
                                  selectedCategory = bloc.filteredList[index].categoryName;
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
                      
                       

                      GreetingCard(imageurl: bloc.filteredList[selectedTopic].templates[selectedImage].link , screenshotController:  screenshotController , fromScreen: "Social Greeting", ),
                      
                      SizedBox(height: 0.02145922747 * height),
                      SizedBox(
                        height: 0.1126609442 * height,
                        width: width,
                        child: ListView.builder(
                          key: ValueKey(selectedCategory),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: bloc.filteredList[selectedTopic].templates.length,
                          itemBuilder: (context, index) {
                            print("${bloc.filteredList[selectedTopic].hashCode+index}");
                            return GestureDetector(
                              key:  ValueKey("${bloc.filteredList[selectedTopic].hashCode+index}"),
                              onTap: () {
                                setState(() {
                                  selectedImage = index;
                                  fileName = bloc
                                            .filteredList[selectedTopic]
                                            .templates[index]
                                            .name;
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
                                  child: GreetingSmallGrid(imageurl: bloc
                                            .filteredList[selectedTopic]
                                            .templates[index]
                                            .link ,),
                                  // child: Padding(
                                  //   padding: const EdgeInsets.all(2.0),
                                  //   child: ClipRRect(
                                  //     borderRadius: BorderRadius.circular(8),
                                  //     child: CachedNetworkImage(
                                  //        imageUrl: bloc
                                  //           .filteredList[selectedTopic]
                                  //           .templates[index]
                                  //           .link,
                                  //       imageBuilder: (context, imageProvider) {
                                  //         return Container(
                                  //             decoration: BoxDecoration(
                                  //             image: DecorationImage(
                                  //             image: imageProvider,
                                  //             fit: BoxFit.fill,
                                  //             ),
                                  //           ));
                                  //         },
                                  //       placeholder: (context, url) {
                                  //         return Shimmer.fromColors(
                                  //           direction: ShimmerDirection.ltr,
                                  //             baseColor:  Colors.grey[800]!,
                                  //             highlightColor: Colors.grey[600]!,
                                        
                                  //           child: Container(
                                  //             color: Colors.white,
                                  //           ),
                                  //         );
                                  //       },
                                       
                                  //       fit: BoxFit.fill,
                                  //     ),
                                  //   ),
                                  // ),
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
                        shareWidget(fileName);
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
