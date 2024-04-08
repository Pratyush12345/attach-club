import 'package:attach_club/core/custom_modal_sheet.dart';
import 'package:attach_club/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'add_platform_info.dart';

showPlatformListModal(
  BuildContext context,
) {
  showCustomModalBottomSheet(
    context: context,
    child: const PlatformListModal(),
  );
}

class PlatformListModal extends StatelessWidget {
  const PlatformListModal({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 0.02789 * height,
            ),
            const Text(
              "Choose from suggested platforms",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            SizedBox(
              height: 0.02575 * height,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 80,
                mainAxisExtent: 80,
                mainAxisSpacing: 16,
                crossAxisSpacing: 19,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    showAddPlatformInfoModal(
                      context: context,
                      socialMedia: socialMediaList[index],
                    );
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFF181B2F),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: SvgPicture.asset(
                            socialMediaList[index].imageUrl,
                          ),
                        ),
                        Text(
                          socialMediaList[index].name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: socialMediaList.length,
            ),
          ],
        ),
      ),
    );
  }
}
