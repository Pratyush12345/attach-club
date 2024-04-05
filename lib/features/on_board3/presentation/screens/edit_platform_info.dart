import 'package:attach_club/core/components/button.dart';
import 'package:attach_club/core/components/custom_modal_sheet.dart';
import 'package:attach_club/features/on_board3/bloc/on_board3_bloc.dart';
import 'package:attach_club/features/on_board3/data/models/social_link.dart';
import 'package:attach_club/features/on_board3/presentation/screens/add_platform_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showEditPlatformInfoSheet(
  BuildContext context,
  SocialLink socialLink,
) {
  showCustomModalBottomSheet(
    context: context,
    sheetHeight: 0.21,
    child: EditPlatformInfo(
      socialLink: socialLink,
    ),
  );
}

class EditPlatformInfo extends StatelessWidget {
  final SocialLink socialLink;

  const EditPlatformInfo({
    super.key,
    required this.socialLink,
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
              );
            },
            title: "Edit",
            buttonWidth: 0.425581,
          ),
          const SizedBox(
            width: 16,
          ),
          CustomButton(
            onPressed: () {
              context.read<OnBoard3Bloc>().add(
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
