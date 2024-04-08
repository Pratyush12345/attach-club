import 'dart:async';

import 'package:flutter/material.dart';

class ResetText extends StatefulWidget {
  const ResetText({super.key});

  @override
  State<ResetText> createState() => _ResetTextState();
}

class _ResetTextState extends State<ResetText> {
  int count = 60;
  late Timer timer;

  @override
  void initState(){
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (count <= 0) {
          count = 61;
        } else {
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
    return Text(
      "Resend $count",
      style: const TextStyle(
        color: Color(0xFF4285F4),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
