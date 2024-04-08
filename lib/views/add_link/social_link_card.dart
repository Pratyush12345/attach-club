import 'package:attach_club/models/social_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'edit_platform_info.dart';

class SocialLinkCard extends StatefulWidget {
  final SocialLink socialLink;

  const SocialLinkCard({
    super.key,
    required this.socialLink,
  });

  @override
  State<SocialLinkCard> createState() => _SocialLinkCardState();
}

class _SocialLinkCardState extends State<SocialLinkCard> {
  bool visibility = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showEditPlatformInfoSheet(context, widget.socialLink);
      },
      child: Card(
        color: const Color(0xFF26293B),
        child: Row(
          children: [
            SizedBox(
              width: 82,
              height: 82,
              child: SvgPicture.asset(widget.socialLink.socialMedia.imageUrl),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.socialLink.label,
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
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            widget.socialLink.link,
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
                  IconButton(
                    onPressed: () {
                      setState(() {
                        visibility = !visibility;
                      });
                    },
                    icon: Icon(
                      (visibility) ? Icons.visibility : Icons.visibility_off,
                    ),
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
