import 'dart:io';

import 'package:attach_club/core/custom_add_icon.dart';
import 'package:attach_club/core/label.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImages extends StatelessWidget {
  final void Function(XFile?) callback;
  final XFile? file;

  const AddImages({
    super.key,
    required this.callback,
    required this.file,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () async {
        XFile? selectedFile =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (selectedFile != null) {
          callback(selectedFile);
        }
      },
      child: (file != null)
          ? SizedBox(
        width: double.infinity,
              height: 0.1673 * height,
              child: Image.file(
                File(file!.path),
                fit: BoxFit.fill,
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
                height: 0.1673 * height,
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
