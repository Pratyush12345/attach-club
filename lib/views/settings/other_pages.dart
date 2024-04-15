import 'package:attach_club/views/settings/gradient_button.dart';
import 'package:flutter/material.dart';

import '../../core/components/line_break.dart';

class OtherPages extends StatelessWidget {
  static const _titleStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18,
    color: Colors.white,
  );

  static const _subTitleStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: Colors.white,
  );

  const OtherPages({super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        ListTile(
          onTap: (){
            Navigator.of(context).pushNamed("/settings/manageProfile");
          },
          title: const Text(
            "Manage Profile",
            style: _titleStyle,
          ),
          subtitle: const Text(
            "Edit your basic details, social links, products and other details",
            style: _subTitleStyle,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 20,
          ),
        ),
        const LineBreak(),
        const ListTile(
          title: Text(
            "Enquiries",
            style: _titleStyle,
          ),
          subtitle: Text(
            "Check the enquires of the users",
            style: _subTitleStyle,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 20,
          ),
        ),
        const LineBreak(),
        const ListTile(
          title: Text(
            "Detailed Analytics",
            style: _titleStyle,
          ),
          subtitle: Text(
            "Check the detailed analytics of your profile",
            style: _subTitleStyle,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 20,
          ),
        ),
        const LineBreak(),
         ListTile(
          title: const Text(
            "Profile Privacy Settings",
            style: _titleStyle,
          ),
          subtitle: const Text(
            "Choose the details that you want to show to the users.",
            style: _subTitleStyle,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 20,
          ),
          onTap: (){
            Navigator.of(context).pushNamed("/settings/profilePrivacy");
          },
        ),
        const LineBreak(),
        const GradientButton(
          title: "Refer to a friend",
          subTitle: "Refer to a friend and earn boogies",
          prefixIcon: Icon(
            Icons.share,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16,),
        const GradientButton(
          title: "Logout",
          subTitle: "logout from the application",
          prefixIcon: Icon(
            Icons.logout,
            color: Colors.white,
          ),
          isGradient: false,
        ),
        const SizedBox(height: 16,),
        const GradientButton(
          title: "Delete Account",
          subTitle: "Remove all the data and delete account",
          prefixIcon: Icon(
            Icons.logout,
            color: Colors.red,
          ),
          isGradient: false,
          textColor: Colors.red,
        ),
      ],
    );
  }
}
