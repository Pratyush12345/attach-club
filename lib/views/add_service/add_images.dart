import 'dart:io';

import 'package:attach_club/core/components/custom_add_icon.dart';
import 'package:attach_club/core/components/label.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AddImages extends StatelessWidget {
  final void Function(XFile?) callback;
  final XFile? file;
  final String url;

  const AddImages({
    super.key,
    required this.callback,
    required this.file,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () async {
        XFile? selectedFile =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if(context.mounted && selectedFile!=null) {
          CroppedFile? croppedFile = await ImageCropper().cropImage(sourcePath: selectedFile.path);
          if(context.mounted && croppedFile!=null) {
            selectedFile = XFile(croppedFile.path);
          }
        }
        if (selectedFile != null) {
          callback(selectedFile);
        }
      },
      child: (file != null)
          ? SizedBox(
              width: double.infinity,
              height: 0.30472103 * height,
              child: Image.file(
                File(file!.path),
                fit: BoxFit.fill,
              ),
            )
          : (url.isNotEmpty)
              ? SizedBox(
                  width: double.infinity,
                  height: 0.30472103 * height,
                  child: Image.network(
                    url,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Text(
                          "Image not found",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return const Center(
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                )
              : DottedBorder(
                  dashPattern: const [8, 10],
                  color: Colors.white.withOpacity(0.5),
                  borderType: BorderType.RRect,
                  strokeCap: StrokeCap.round,
                  radius: const Radius.circular(8),
                  child: Container(
                    width: double.infinity,
                    height: 0.30472103 * height,
                    color: const Color(0xFF2A2D40),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomAddIcon(),
                        SizedBox(
                          height: 8,
                        ),
                        Label(title: "Add Images"),
                      ],
                    ),
                  ),
                ),
    );
  }
}
