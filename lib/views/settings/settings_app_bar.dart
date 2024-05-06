import 'package:flutter/material.dart';

import '../../constants.dart';

AppBar getSettingsAppBar(BuildContext context,double height) {
  final top = MediaQuery.of(context).viewInsets.top;
  return AppBar(
    toolbarHeight: top + 0.080083691 * height,
    title: const Text(
      "Settings",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
      ),
    ),
  );
}