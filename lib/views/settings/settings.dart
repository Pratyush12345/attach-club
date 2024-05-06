import 'package:attach_club/constants.dart';
import 'package:attach_club/views/settings/info_card.dart';
import 'package:attach_club/views/settings/other_pages.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                ),
                child: InfoCard(),
              ),
              SizedBox(
                height: 0.02575 * height,
              ),
              const OtherPages(),
              const SizedBox(
                height: paddingDueToNav,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
