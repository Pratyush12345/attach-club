import 'package:attach_club/bloc/profile_image/profile_image_bloc.dart';
import 'package:attach_club/views/profile_image/profile_sheet_modal.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/components/custom_add_icon.dart';
import '../../core/components/label.dart';
import 'package:image_cropper/image_cropper.dart';

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
              color: Colors.purple,
            ),
          );
        }
        return SizedBox(
          height: 0.3723175966 * height,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  if(context.read<ProfileImageBloc>().bannerImage.isEmpty){
                    _selectCoverAndUpload();
                  }else{
                    showProfileSheetModal(
                      context,
                      _selectCoverAndUpload,
                          () {
                        context.read<ProfileImageBloc>().add(
                          BannerImageDeleted(),
                        );
                      },
                    );
                  }
                },
                child: _getCover(height),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () async {
                    if(context.read<ProfileImageBloc>().profileImage.isEmpty){
                      _selectProfileAndUpload();
                    }else {
                      showProfileSheetModal(
                        context,
                        _selectProfileAndUpload,
                            () {
                          context.read<ProfileImageBloc>().add(
                            ProfileImageDeleted(),
                          );
                        },
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

  _selectProfileAndUpload() async {
    XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (context.mounted && pickedImage != null) {
      CroppedFile? croppedFile =
          await ImageCropper().cropImage(sourcePath: pickedImage.path);
      if (context.mounted && croppedFile != null) {
        context.read<ProfileImageBloc>().add(
              ProfileImageUploaded(XFile(croppedFile.path)),
            );
      }
    }
  }

  _selectCoverAndUpload() async {
    XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (context.mounted && pickedImage != null) {
      CroppedFile? croppedFile =
          await ImageCropper().cropImage(sourcePath: pickedImage.path);
      if (context.mounted && croppedFile != null) {
        context.read<ProfileImageBloc>().add(
              BannerImageUploaded(XFile(croppedFile.path)),
            );
      }
    }
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
        child: Image.network(
          context.read<ProfileImageBloc>().bannerImage,
          key: UniqueKey(),
          fit: BoxFit.fill,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return const Center(
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: Colors.purple,
                  ),
                ),
              );
            }
          },
          errorBuilder: (context, error, stackTrace) {
            return border;
          },
        ),
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
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: Image.network(
            context.read<ProfileImageBloc>().profileImage,
            fit: BoxFit.fill,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return const Center(
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Colors.purple,
                    ),
                  ),
                );
              }
            },
            errorBuilder: (context, error, stackTrace) {
              return border;
            },
          ),
        ),
      );
    } else {
      return border;
    }
  }
}
