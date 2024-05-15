import 'package:flutter/material.dart';
import '../../constants.dart';

AppBar getSearchConnectionsAppBar(BuildContext context, double height) {
  final top = MediaQuery.of(context).viewInsets.top;
  return AppBar(
    backgroundColor: const Color(0xFF26293B),
    toolbarHeight: top + 0.05364806867 * height,
    title: const Text(
      "Search Connection",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
      ),
    ),
  );
}