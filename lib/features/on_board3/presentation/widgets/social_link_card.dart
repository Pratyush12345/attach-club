import 'package:attach_club/features/on_board3/data/models/social_link.dart';
import 'package:attach_club/features/on_board3/presentation/screens/edit_platform_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialLinkCard extends StatelessWidget {
  final SocialLink socialLink;

  const SocialLinkCard({
    super.key,
    required this.socialLink,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        showEditPlatformInfoSheet(context, socialLink);
      },
      child: Card(
        color: const Color(0xFF26293B),
        child: Row(
          children: [
            SizedBox(
              width: 82,
              height: 82,
              child: SvgPicture.asset(socialLink.socialMedia.imageUrl),
            ),
            const SizedBox(width: 20,),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    socialLink.label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/svg/link.svg",
                        colorFilter:
                            const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      ),
                      const SizedBox(width: 4,),
                      Text(
                        socialLink.link,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
