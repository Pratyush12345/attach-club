import 'package:attach_club/models/tab_data.dart';
import 'package:attach_club/views/account/account.dart';
import 'package:attach_club/views/add_link/add_link.dart';
import 'package:attach_club/views/add_service/add_service_screen.dart';
import 'package:attach_club/views/complete_profile/complete_profile.dart';
import 'package:attach_club/views/profile_image/profile_image.dart';
import 'package:attach_club/views/reviews/reviews.dart';
import 'package:flutter/material.dart';

class ManageProfile extends StatefulWidget {
  const ManageProfile({super.key});

  @override
  State<ManageProfile> createState() => _ManageProfileState();
}

class _ManageProfileState extends State<ManageProfile> {
  final tabs = <TabData>[
    TabData(title: "Display", tab: const ProfileImage(isInsideManageProfile: true)),
    TabData(title: "Profile", tab: const CompleteProfile(isInsideManageProfile: true)),
    TabData(
        title: "Your Links", tab: const AddLink(isInsideManageProfile: true)),
    TabData(title: "Product", tab: const AddService(isInsideManageProfile: true)),
    TabData(title: "Reviews", tab: const Reviews()),
    TabData(title: "Account", tab: const Account()),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
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
            "Manage your profile",
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
          bottom: TabBar(
            indicatorColor: Colors.blue,
            isScrollable: true,
            tabs: [
              for (var i in tabs) Tab(text: i.title),
            ],
            labelStyle: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            tabAlignment: TabAlignment.start,
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              for (var i in tabs) i.tab,
            ],
          ),
        ),
      ),
    );
  }
}
