import 'package:flutter/material.dart';

class NavTabData {
  final String label;
  final String assetName;
  final Widget child;
  final AppBar appBar;

  NavTabData({
    required this.label,
    required this.assetName,
    required this.child,
    required this.appBar,
  });
}
