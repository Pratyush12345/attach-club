import 'package:attach_club/constants.dart';
import 'package:attach_club/models/social_link.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'edit_platform_info.dart';

class SocialLinkCard extends StatefulWidget {
  final SocialLink socialLink;
  final List<SocialLink> list;

  const SocialLinkCard({
    super.key,
    required this.socialLink,
    required this.list,
  });

  @override
  State<SocialLinkCard> createState() => _SocialLinkCardState();
}

class _SocialLinkCardState extends State<SocialLinkCard> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showEditPlatformInfoSheet(
          context,
          widget.socialLink,
          widget.list,
        );
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
                      SizedBox(
                        width:  MediaQuery.of(context).size.width *0.5,
                        child: Text(
                          widget.socialLink.title,
                          style: const TextStyle(
                            color: primaryTextColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
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
                            width: 16,
                            height: 16,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width *0.5,
                            child: Text(
                              widget.socialLink.link,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: secondaryTextColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
