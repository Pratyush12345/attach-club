import 'package:attach_club/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'dashboard_bottom_sheet.dart';

class LinkCard extends StatelessWidget {
  final Widget prefix;
  final String title;

  const LinkCard({
    super.key,
    required this.prefix,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        showDashboardBottomSheet(context);
      },
      child: Card(
        margin: EdgeInsets.zero,
        color: const Color(0xFF26293B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: SizedBox(
          height: 0.07725321888 * height,
          width: 0.4 * width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                prefix,
                const SizedBox(
                  width: 6,
                ),
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      text: title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: primaryTextColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                  height: 15,
                  child: SvgPicture.asset(
                    "assets/svg/arrow_up_right.svg",
                    width: 15,
                    height: 15,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
