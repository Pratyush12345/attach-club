import 'package:attach_club/core/components/button.dart';
import 'package:attach_club/core/components/custom_modal_sheet.dart';
import 'package:attach_club/core/components/text_field.dart';
import 'package:attach_club/core/models/social_media.dart';
import 'package:attach_club/features/on_board3/bloc/on_board3_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/models/social_link.dart';

showAddPlatformInfoModal({
  required BuildContext context,
  required SocialMedia socialMedia,
  SocialLink? socialLink,
}) {
  showCustomModalBottomSheet(
    context: context,
    sheetHeight: 0.3197,
    child: AddPlatformInfo(
      socialMedia: socialMedia,
      socialLink: socialLink,
    ),
  );
}

class AddPlatformInfo extends StatefulWidget {
  final SocialMedia socialMedia;
  final SocialLink? socialLink;


  AddPlatformInfo({
    super.key,
    required this.socialMedia,
    this.socialLink,
  });

  @override
  State<AddPlatformInfo> createState() => _AddPlatformInfoState();
}

class _AddPlatformInfoState extends State<AddPlatformInfo> {
  final labelController = TextEditingController();

  final linkController = TextEditingController();

  @override
  void dispose() {
    labelController.dispose();
    linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    labelController.text = widget.socialLink?.label ?? "";
    linkController.text = widget.socialLink?.link ?? "";
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: 0.02896 * height,
          ),
          CustomTextField(
            type: TextFieldType.RegularTextField,
            controller: labelController,
            hintText: "Enter username",
          ),
          SizedBox(
            height: 0.01287 * height,
          ),
          CustomTextField(
            type: TextFieldType.RegularTextField,
            controller: linkController,
            hintText: "Enter platform link",
            prefixWidget: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: SvgPicture.asset(
                "assets/svg/link.svg",
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
                semanticsLabel: 'link icon',
              ),
            ),
          ),
          SizedBox(
            height: 0.0343 * height,
          ),
          CustomButton(
            onPressed: () {
              _onPress(context);
              Navigator.of(context).pop();
            },
            title: (widget.socialLink != null) ? "Edit" : "Add",
          ),
        ],
      ),
    );
  }

  _onPress(BuildContext context) {
    if (widget.socialLink != null) {
      context.read<OnBoard3Bloc>().add(
            EditSocialLink(
              oldSocialLink: widget.socialLink!,
              socialMedia: widget.socialMedia,
              link: linkController.text,
              label: labelController.text,
            ),
          );
    } else {
      context.read<OnBoard3Bloc>().add(
            SocialLinkAdded(
              socialMedia: widget.socialMedia,
              link: linkController.text,
              label: labelController.text,
            ),
          );
    }
  }
}
