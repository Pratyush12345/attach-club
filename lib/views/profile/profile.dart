import 'package:attach_club/core/button.dart';
import 'package:attach_club/core/divider.dart';
import 'package:attach_club/core/rating.dart';
import 'package:attach_club/constants.dart';
import 'package:attach_club/core/text_field.dart';
import 'package:attach_club/views/profile/product_card_with_enquiry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // static final Product product = Product(title: "Horai CTC Tea",
  static final _list = [
    {
      "name": "Whatsapp",
      "assetName": "assets/svg/whatsapp.svg",
    },
    {
      "name": "Instagram",
      "assetName": "assets/svg/instagram.svg",
    },
    {
      "name": "Facebook",
      "assetName": "assets/svg/facebook.svg",
    },
    {
      "name": "Snapchat",
      "assetName": "assets/svg/snapchat.svg",
    },
    {
      "name": "Whatsapp",
      "assetName": "assets/svg/whatsapp.svg",
    },
    {
      "name": "Instagram",
      "assetName": "assets/svg/instagram.svg",
    },
    {
      "name": "Facebook",
      "assetName": "assets/svg/facebook.svg",
    },
    {
      "name": "Snapchat",
      "assetName": "assets/svg/snapchat.svg",
    }
  ];
  final nameController = TextEditingController();
  final feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 0.3841201717 * height,
                child: Stack(
                  children: [
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Color(0xFF181B2F),
                          ],
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.darken,
                      child: SizedBox(
                        width: double.infinity,
                        height: 0.3240343348 * height,
                        child: Image.asset(
                          "assets/images/image.jpeg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 147,
                        height: 147,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(73.5),
                        ),
                        child: Image.asset(
                          "assets/images/profile_logo.png",
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Text(
                      "Nishant Singh",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "UI/UX Designer @ Vysion Technology",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    Rating(
                      selected: 3,
                      alignment: MainAxisAlignment.center,
                    ),
                    Text(
                      "3 stars out of 5",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "112 reviews",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          onPressed: () {},
                          title: "Save Contact",
                          assetName: "assets/svg/arrow_up_right.svg",
                          buttonWidth: 0.4279069767,
                          doubleSize: 10,
                          isDark: true,
                        ),
                        CustomButton(
                          onPressed: () {},
                          title: "Save Contact",
                          buttonWidth: 0.4279069767,
                        ),
                      ],
                    ),
                    const CustomDivider(),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 30,
                      runSpacing: 12,
                      children: [
                        for (var i in _list)
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: SizedBox(
                              height: 74,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 11.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      i["assetName"]!,
                                      width: 26,
                                      height: 26,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6.0),
                                      child: Text(i["name"] ?? "Whatsapp"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                    const CustomDivider(),
                    const Text(
                      "About",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        text: lorem,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.46),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Products",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        Text(
                          "View All",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          spacing: 25,
                          children: [
                            for (var i = 0; i < 10; i++)
                              const ProductCardWithEnquiry()
                          ],
                        )),
                    const SizedBox(height: 35),
                    const Text(
                      "Review and Ratings",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          const Text(
                            "Rate your experienc working with Akhilesh",
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          const Rating(
                            selected: 0,
                            alignment: MainAxisAlignment.center,
                            size: 36,
                          ),
                          const SizedBox(height: 13),
                          CustomTextField(
                            type: TextFieldType.RegularTextField,
                            controller: nameController,
                            hintText: "Your name",
                          ),
                          const SizedBox(height: 13),
                          CustomTextField(
                            type: TextFieldType.RegularTextField,
                            controller: feedbackController,
                            isTextArea: true,
                            hintText: "Feedback",
                          ),
                          const SizedBox(height: 10),
                          CustomButton(
                            onPressed: () {},
                            title: "Sent",
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
