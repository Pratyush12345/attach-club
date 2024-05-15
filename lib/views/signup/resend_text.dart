import 'dart:async';

import 'package:flutter/material.dart';

class ResendText extends StatefulWidget {
  final void Function(int) resendOtp;

  const ResendText({
    super.key,
    required this.resendOtp,
  });

  @override
  State<ResendText> createState() => _ResendTextState();
}

class _ResendTextState extends State<ResendText> {
  int count = 60;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (count > 0) {
          count--;
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(
        (count == 0) ? "Resend code" : "Resend $count",
        style: const TextStyle(
          color: Color(0xFF4285F4),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {},
    );
  }
}
