import 'package:attach_club/bloc/profile_image/profile_image_bloc.dart';
import 'package:attach_club/models/globalVariable.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/components/custom_add_icon.dart';
import '../../core/components/label.dart';

class UploadImagesComponent extends StatefulWidget {
  const UploadImagesComponent({super.key});

  @override
  State<UploadImagesComponent> createState() => _UploadImagesComponentState();
}

class _UploadImagesComponentState extends State<UploadImagesComponent> {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocConsumer<ProfileImageBloc, ProfileImageState>(
      listener: (context, state) {
        if (state is ShowSnackBar) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.grey,
            ),
          );
        }
        return SizedBox(
          height: 0.4023175966 * height,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () async {
                  XFile? pickedImage = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (context.mounted && pickedImage != null) {
                    context.read<ProfileImageBloc>().add(
                          BannerImageUploaded(pickedImage),
                        );
                        GlobalVariable.isAnyChangeInProfile = true;
                  }
                },
                child: _getCover(height),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () async {
                    XFile? pickedImage = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (context.mounted && pickedImage != null) {
                      context.read<ProfileImageBloc>().add(
                            ProfileImageUploaded(pickedImage),
                          );
                          GlobalVariable.isAnyChangeInProfile = true;
                    }
                  },
                  child: _getProfile(width),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _getCover(double height) {
    final border = DottedBorder(
      dashPattern: const [8, 10],
      color: Colors.white.withOpacity(0.5),
      borderType: BorderType.RRect,
      strokeCap: StrokeCap.round,
      radius: const Radius.circular(8),
      child: Container(
        width: double.infinity,
        height: 0.28751 * height,
        color: const Color(0xFF2A2D40),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomAddIcon(),
            SizedBox(
              height: 8,
            ),
            Label(title: "Upload Cover"),
            SizedBox(
              height: 8,
            ),
            Label(title: "500x500 px")
          ],
        ),
      ),
    );
    if (context.read<ProfileImageBloc>().bannerImage.isNotEmpty) {
      return SizedBox(
        width: double.infinity,
        height: 0.28751 * height,
        child : CachedNetworkImage(
                          imageBuilder: (context, imageProvider) {
                            return Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fill,
                              ),
                            ));
                          },
                          imageUrl: context.read<ProfileImageBloc>().bannerImage,
                          errorWidget: (context, error, stackTrace) {
                            return border;
                          },
                          fit: BoxFit.fill,
                            placeholder : (context, url) {
                              return Shimmer.fromColors(
                                direction: ShimmerDirection.ltr,
                                  baseColor:  Colors.grey[800]!,
                                  highlightColor: Colors.grey[600]!,

                                child: Container(
                                  color: Colors.white,
                                ),
                              );

                          } ,
                         ),
        // Image.network(
        //   context.read<ProfileImageBloc>().bannerImage,
        //   key: UniqueKey(),
        //   fit: BoxFit.fill,
        //   loadingBuilder: (context, child, loadingProgress) {
        //     if (loadingProgress == null) {
        //       return child;
        //     } else {
        //       return const Center(
        //         child: SizedBox(
        //           height: 24,
        //           width: 24,
        //           child: CircularProgressIndicator(
        //             color: Colors.purple,
        //           ),
        //         ),
        //       );
        //     }
        //   },
        //   errorBuilder: (context, error, stackTrace) {
        //     return border;
        //   },
        // ),
      );
    } else {
      return border;
    }
  }

  Widget _getProfile(double width) {
    final border = DottedBorder(
      color: Colors.white.withOpacity(0.5),
      borderType: BorderType.Oval,
      dashPattern: const [8, 10],
      strokeCap: StrokeCap.round,
      child: Container(
        width: 0.3302325581 * width,
        height: 0.3302325581 * width,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF2A2D40),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomAddIcon(),
              SizedBox(
                height: 8,
              ),
              Label(title: "Upload Profile Pic")
            ],
          ),
        ),
      ),
    );
    if (context.read<ProfileImageBloc>().profileImage.isNotEmpty) {
      return Container(
        width: 0.3302325581 * width,
        height: 0.3302325581 * width,
         decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 2.5,
                              ),
                              borderRadius: BorderRadius.circular(73.5),
                            ),
        child: ClipOval(
          child: CachedNetworkImage(
                          imageBuilder: (context, imageProvider) {
                            return Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fill,
                              ),
                            ));
                          },
                          imageUrl: context.read<ProfileImageBloc>().profileImage,
                          errorWidget: (context, error, stackTrace) {
                            return border;
                          },
                          fit: BoxFit.fill,
                            placeholder : (context, url) {
                              return Shimmer.fromColors(
                                direction: ShimmerDirection.ltr,
                                  baseColor:  Colors.grey[800]!,
                                  highlightColor: Colors.grey[600]!,

                                child: Container(
                                  color: Colors.white,
                                ),
                              );

                          } ,
                         ),
          
          // Image.network(
          //   context.read<ProfileImageBloc>().profileImage,
          //   fit: BoxFit.fill,
          //   loadingBuilder: (context, child, loadingProgress) {
          //     if (loadingProgress == null) {
          //       return child;
          //     } else {
          //       return const Center(
          //         child: SizedBox(
          //           height: 24,
          //           width: 24,
          //           child: CircularProgressIndicator(
          //             color: Colors.grey,
          //           ),
          //         ),
          //       );
          //     }
          //   },
          //   errorBuilder: (context, error, stackTrace) {
          //     return border;
          //   },
          // ),
        ),
      );
    } else {
      return border;
    }
  }
}
