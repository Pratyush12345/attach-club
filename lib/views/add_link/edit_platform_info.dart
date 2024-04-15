import 'package:attach_club/bloc/add_link/add_link_bloc.dart';
import 'package:attach_club/core/components/button.dart';
import 'package:attach_club/core/components/custom_modal_sheet.dart';
import 'package:attach_club/models/social_link.dart';
import 'package:attach_club/views/add_link/add_platform_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showEditPlatformInfoSheet(
  BuildContext context,
  SocialLink socialLink,
  List<SocialLink> list,
) {
  showCustomModalBottomSheet(
    context: context,
    sheetHeight: 0.21,
    child: EditPlatformInfo(
      socialLink: socialLink,
      list: list,
    ),
  );
}

class EditPlatformInfo extends StatelessWidget {
  final SocialLink socialLink;
  final List<SocialLink> list;

  const EditPlatformInfo({
    super.key,
    required this.socialLink,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          CustomButton(
            onPressed: () {
              Navigator.pop(context);
              showAddPlatformInfoModal(
                  context: context,
                  socialMedia: socialLink.socialMedia,
                  socialLink: socialLink,
                  list: list);
            },
            title: "Edit",
            buttonWidth: 0.425581,
          ),
          const SizedBox(
            width: 16,
          ),
          CustomButton(
            onPressed: () {
              context.read<AddLinkBloc>().add(
                    DeleteSocialLink(socialLink),
                  );
            },
            title: "Delete",
            buttonWidth: 0.425581,
            isDark: true,
          ),
        ],
      ),
    );
  }
}
