import 'package:attach_club/constants.dart';
import 'package:attach_club/views/profile_privacy/switch_card.dart';
import 'package:flutter/material.dart';

class ProfilePrivacy extends StatelessWidget {
  const ProfilePrivacy({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leadingWidth: 52,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        title: const Text(
          "Profile Privacy Settings",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamed("/profile");
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(36))),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Center(
                      child: Text(
                    "View Profile",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.06545064378 * height),
          child: Padding(
            padding: EdgeInsets.only(bottom: 0.02789699571 * height),
            child: const Text(
              "Choose the details that you want to show to the users. ",
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 0.01675 * height),
              const SwitchCard(
                title: "Basic Details",
                subtitle:
                    "you can turn off if you want to hide your  basic details for users.",
              ),
              const SizedBox(height: 12),
              const SwitchCard(
                title: "Social media links",
                subtitle:
                "you can turn off if you want to hide your  basic details for users.",
              ),
              const SizedBox(height: 12),
              const SwitchCard(
                title: "Products",
                subtitle:
                "you can turn off if you want to hide your  basic details for users.",
              ),
              const SizedBox(height: 12),
              const SwitchCard(
                title: "Reviews",
                subtitle:
                "you can turn off if you want to hide your  basic details for users.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
