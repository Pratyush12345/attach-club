import 'package:attach_club/bloc/profile_image/profile_image_bloc.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/components/custom_add_icon.dart';
import '../../core/components/label.dart';

class UploadImagesComponent extends StatefulWidget {
  const UploadImagesComponent({super.key});

  @override
  State<UploadImagesComponent> createState() => _UploadImagesComponentState();
}

class _UploadImagesComponentState extends State<UploadImagesComponent> {
  // File? coverImage;
  // File? profilePic;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocConsumer<ProfileImageBloc, ProfileImageState>(
      listener: (context, state) {
        // if (state is ProfileImageUpdated) {
        //   profilePic = state.file;
        // }
        // if (state is BannerImageUpdated) {
        //   coverImage = state.file;
        // }
        // if (state is FetchedImages) {
        //   profilePic = state.profileImage;
        //   coverImage = state.bannerImage;
        // }
      },
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.purple,
            ),
          );
        }
        return SizedBox(
          height: 0.3723175966 * height,
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
    if (context.read<ProfileImageBloc>().bannerImage != null) {
      return SizedBox(
        width: double.infinity,
        height: 0.28751 * height,
        child: Image.file(
          context.read<ProfileImageBloc>().bannerImage!,
          key: UniqueKey(),
        ),
      );
    } else {
      return DottedBorder(
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
    }
  }

  Widget _getProfile(double width) {
    if (context.read<ProfileImageBloc>().profileImage != null) {
      return Container(
        width: 0.3302325581 * width,
        height: 0.3302325581 * width,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: Image.file(
            context.read<ProfileImageBloc>().profileImage!,
            fit: BoxFit.fill,
          ),
        ),
      );
    } else {
      return DottedBorder(
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
    }
  }
}
