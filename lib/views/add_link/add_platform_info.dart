import 'package:attach_club/bloc/add_link/add_link_bloc.dart';
import 'package:attach_club/constants.dart';
import 'package:attach_club/core/components/button.dart';
import 'package:attach_club/core/components/custom_modal_sheet.dart';
import 'package:attach_club/core/components/text_field.dart';
import 'package:attach_club/models/globalVariable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/social_link.dart';
import '../../models/social_media.dart';

showAddPlatformInfoModal({
  required BuildContext context,
  required SocialMedia socialMedia,
  required List<SocialLink> list,
  SocialLink? socialLink,
}) {
  showCustomModalBottomSheet(
    context: context,
    sheetHeight: 0.5197,
    child: AddPlatformInfo(
      socialMedia: socialMedia,
      socialLink: socialLink,
      list: list,
    ),
  );
}

class AddPlatformInfo extends StatefulWidget {
  final SocialMedia socialMedia;
  final SocialLink? socialLink;
  final List<SocialLink> list;

  const AddPlatformInfo({
    super.key,
    required this.socialMedia,
    required this.list,
    this.socialLink,
  });

  @override
  State<AddPlatformInfo> createState() => _AddPlatformInfoState();
}

class _AddPlatformInfoState extends State<AddPlatformInfo> {
  final labelController = TextEditingController();
  final linkController = TextEditingController();
  bool isDisabled = false;

  @override
  void dispose() {
    labelController.dispose();
    linkController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    labelController.text = widget.socialLink?.title ?? "";
    linkController.text = widget.socialLink?.link ?? "";
    if(widget.socialLink != null){
      isDisabled = !(widget.socialLink!.isEnabled);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 0.01 * height,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Disable",
                  style: TextStyle(
                    color: primaryTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Switch(
                  value: isDisabled,
                  onChanged: (value) {
                    setState(() {
                      isDisabled = value;
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 0.0171 * height),
          RichText(
            text: TextSpan(
                text:
                    "Turning this option on will hide this link from your profile for all users",
                style: TextStyle(
                  color: paragraphTextColor,
                )),
          ),
          SizedBox(height: 0.0171 * height),
          CustomTextField(
            type: TextFieldType.RegularTextField,
            controller: labelController,
            hintText: "Enter title",
            onChanged: (_) {
              setState(() {});
            },
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
            onChanged: (_) {
              setState(() {});
            },
          ),
          SizedBox(
            height: 0.0343 * height,
          ),
          CustomButton(
            onPressed: () {
              _onPress(context);
              Navigator.of(context).pop();
            },
            title: (widget.socialLink != null) ? "Save" : "Add",
            disabled:
                linkController.text.isEmpty || labelController.text.isEmpty,
          ),
        ],
      ),
    );
  }

  _onPress(BuildContext context) {
    if (widget.socialLink != null) {
      context.read<AddLinkBloc>().add(
            EditSocialLink(
              oldSocialLink: widget.socialLink!,
              socialMedia: widget.socialMedia,
              link: linkController.text,
              title: labelController.text,
              disabled: isDisabled,
            ),
          );

    } else {
      context.read<AddLinkBloc>().add(
            SocialLinkAdded(
              socialMedia: widget.socialMedia,
              link: linkController.text,
              title: labelController.text,
              list: widget.list,
              disabled: isDisabled,
            ),
          );
    }
    GlobalVariable.isAnyChangeInProfile = true;
  }
}
