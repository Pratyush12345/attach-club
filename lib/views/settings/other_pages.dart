import 'package:attach_club/constants.dart';
import 'package:attach_club/core/repository/core_repository.dart';
import 'package:attach_club/core/repository/user_data_notifier.dart';
import 'package:attach_club/views/settings/gradient_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/components/line_break.dart';

class OtherPages extends StatefulWidget {
  static const _titleStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18,
    color: primaryTextColor,
  );

  const OtherPages({super.key});

  @override
  State<OtherPages> createState() => _OtherPagesState();
}

class _OtherPagesState extends State<OtherPages> {
  final _subTitleStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: secondaryTextColor,
  );

  showAlertDialog(BuildContext context) {
    // set up the buttons
    final buttonStyle = TextButton.styleFrom(
      backgroundColor: const Color(0xFF2D4CF9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );

    Widget cancelButton = TextButton(
      style: buttonStyle,
      child: const Text(
        "Cancel",
        style: TextStyle(
          color: primaryTextColor,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      style: buttonStyle,
      child: const Text(
        "Continue",
        style: TextStyle(
          color: primaryTextColor,
        ),
      ),
      onPressed: () {
        context.read<CoreRepository>().logout(context);
        Navigator.of(context).popUntil((route) => false);
        Navigator.of(context).pushNamed("/signup");
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: const Color(0xFF181B2F),
      title: const Text(
        "Are you sure?",
        style: TextStyle(
          color: primaryTextColor,
        ),
      ),
      content: const Text(
        "Are you sure you want to log out?",
        style: TextStyle(
          color: primaryTextColor,
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.of(context).pushNamed("/settings/manageProfile");
          },
          title: const Text(
            "Manage Profile",
            style: OtherPages._titleStyle,
          ),
          subtitle: Text(
            "Edit your basic details, social links, products and other details",
            style: _subTitleStyle,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: paragraphTextColor,
          ),
        ),
        const LineBreak(),
        // ListTile(
        //   title: const Text(
        //     "Enquiries",
        //     style: OtherPages._titleStyle,
        //   ),
        //   subtitle: Text(
        //     "Check the enquires of the users",
        //     style: _subTitleStyle,
        //   ),
        //   trailing: Icon(
        //     Icons.arrow_forward_ios,
        //     size: 20,
        //     color: paragraphTextColor,
        //   ),
        // ),
        // const LineBreak(),
        ListTile(
          title: const Text(
            "Detailed Analytics",
            style: OtherPages._titleStyle,
          ),
          subtitle: Text(
            "Check the detailed analytics of your profile",
            style: _subTitleStyle,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: paragraphTextColor,
          ),
          onTap: () {
            Navigator.of(context).pushNamed("/settings/detailedAnalytics");
          },
        ),
        const LineBreak(),
        ListTile(
          title: const Text(
            "Profile Privacy Settings",
            style: OtherPages._titleStyle,
          ),
          subtitle: Text(
            "Choose the details that you want to show to the users.",
            style: _subTitleStyle,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: paragraphTextColor,
          ),
          onTap: () {
            Navigator.of(context).pushNamed("/settings/profilePrivacy");
          },
        ),
        const LineBreak(),
        //if (context.read<UserDataNotifier>().userData.accountType != "premium")
          ListTile(
            title: const Text(
              "Upgrade Your Plan",
              style: OtherPages._titleStyle,
            ),
            subtitle: Text(
              "Upgrade your plan to get access to amazing features",
              style: _subTitleStyle,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: paragraphTextColor,
            ),
            onTap: () {
              Navigator.of(context).pushNamed("/buyPlan");
            },
          ),
        if (context.read<UserDataNotifier>().userData.accountType != "premium")
          const LineBreak(),
        GradientButton(
          title: "Refer to a friend",
          subTitle: "Refer to a friend and earn boogies",
          prefixIcon: const Icon(
            Icons.share,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        const SizedBox(
          height: 16,
        ),
        GradientButton(
          title: "Logout",
          subTitle: "logout from the application",
          prefixIcon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
          isGradient: false,
          onPressed: () {
            showAlertDialog(context);
          },
        ),
        const SizedBox(
          height: 16,
        ),
        GradientButton(
          title: "Deactivate Account",
          subTitle: "Remove all the data and delete account",
          prefixIcon: const Icon(
            Icons.logout,
            color: Colors.red,
          ),
          isGradient: false,
          textColor: Colors.red,
          onPressed: () {},
        ),
      ],
    );
  }
}
