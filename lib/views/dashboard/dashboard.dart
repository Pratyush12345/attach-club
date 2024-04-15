import 'package:attach_club/constants.dart';
import 'package:attach_club/core/components/button.dart';
import 'package:attach_club/views/dashboard/link_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'profile_card.dart';

class Dashboard extends StatelessWidget {
  static const analyticsData = [
    {
      "no": "200",
      "title": "Connections",
    },
    {
      "no": "187",
      "title": "Profile Clicks",
    },
    {
      "no": "287",
      "title": "Enquiries",
    }
  ];
  static const connectData = [
    {
      "asset": "assets/svg/whatsapp.svg",
      "title": "Share your profile on whatsapp",
    },
    {
      "asset": "assets/svg/whatsapp.svg",
      "title": "Share on other platforms",
    }
  ];

  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 0.02575107296 * height),
            Container(
              width: double.infinity,
              height: 0.160944206 * height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.red,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  "assets/images/dashboard.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 0.02575107296 * height),
            const Text(
              "Analytics",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 0.01931330472 * height),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 16,
                children: [
                  for (var i in analyticsData)
                    LinkCard(
                      prefix: Text(
                        i["no"] ?? "99",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                      title: i["title"] ?? "title",
                    ),
                ],
              ),
            ),
            SizedBox(height: 0.02575107296 * height),
            const Text(
              "Connect with people",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 0.01931330472 * height),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 16,
                children: [
                  for (var i in connectData)
                    LinkCard(
                      prefix: SvgPicture.asset(
                        i["asset"]!,
                        width: 30,
                        height: 30,
                      ),
                      title: i["title"] ?? "title",
                    ),
                ],
              ),
            ),
            SizedBox(height: 0.02575107296 * height),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Suggested Profiles",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "View All",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xFF4285F4)),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 12,
                children: [
                  for (var i = 0; i < 5; i++)
                    const ProfileCard(
                      name: "Shri Rash B. Rungta",
                      description:
                          "Joint Commissioner of Central GST(Government of India)",
                      asset: "assets/images/image.jpeg",
                      selected: 3,
                    ),
                ],
              ),
            ),
            SizedBox(
              width: 0.01716738197 * height,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Social Greetings",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFFFB743),
                      borderRadius: BorderRadius.circular(15)),
                  height: 30,
                  width: 0.2209302326 * width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/premium.png",
                        width: 12,
                        height: 12,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        "Premium",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Image.asset(
              "assets/images/greetings.png",
              fit: BoxFit.fitWidth,
            ),
            SizedBox(
              width: 0.01716738197 * height,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  onPressed: () {},
                  title: "View More",
                  isDark: true,
                  buttonWidth: 0.4255813953,
                ),
                CustomButton(
                  onPressed: () {},
                  title: "Share",
                  buttonWidth: 0.4255813953,
                ),
              ],
            ),
            const SizedBox(
              height: paddingDueToNav,
            )
          ],
        ),
      ),
    );
  }
}
