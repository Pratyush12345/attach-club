import 'package:attach_club/constants.dart';
import 'package:flutter/material.dart';

AppBar getConnectionsAppBar(BuildContext context, double height) {
  final top = MediaQuery.of(context).viewInsets.top;
  return AppBar(
    backgroundColor: const Color(0xFF26293B),
    toolbarHeight: top + 0.05364806867 * height,
    title: const Text(
      "Connections",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
      ),
    ),
  );
}