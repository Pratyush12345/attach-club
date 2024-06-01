import 'dart:developer';

import 'package:attach_club/constants.dart';
import 'package:attach_club/core/components/button.dart';
import 'package:attach_club/core/components/heading.dart';
import 'package:attach_club/views/signup/otp_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/verify_phone/verify_phone_bloc.dart';

class VerifyOTP extends StatefulWidget {
  final String phoneNumber;

  const VerifyOTP({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<VerifyPhoneBloc>().add(
      PhoneVerificationTriggered(
        phoneNumber: widget.phoneNumber,
        verificationFailed: verificationFailed,
        verificationCompleted: verificationCompleted,
      ),
    );
  }

  void verificationFailed(FirebaseAuthException e) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Could not send OTP ${e.code}"),
      ),
    );
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    //Android only
    final user = await FirebaseAuth.instance.signInWithCredential(credential);
    if (user.user != null && context.mounted) {
      context.read<VerifyPhoneBloc>().add(CheckOnboardingStatus());
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      body: SafeArea(
        child: BlocListener<VerifyPhoneBloc, VerifyPhoneState>(
          listener: (context, state) {
            if (state is PhoneVerificationSuccess){
              context.read<VerifyPhoneBloc>().add(CheckOnboardingStatus());
            }
            if (state is ShowSnackBar) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
            if (state is NavigateToOnboarding) {
              Navigator.of(context).popUntil((route) => false);
              Navigator.of(context).pushNamed("/onboard1");
            }
            if (state is NavigateToDashboard) {
              Navigator.of(context).popUntil((route) => false);
              Navigator.of(context).pushNamed("/home");
            }
          },
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 0.01364806867 * height),
                      const Heading(title: "Enter your 6 digit OTP"),
                      SizedBox(height: 0.0525751073 * height),
                      const Text(
                        "Please enter 6 digit verification code sent to +918279******48",
                      ),
                      SizedBox(height: 0.03433476395 * height),
                      OtpInputField(
                        controller: controller,
                        updateParentState: () {
                          setState(() {});
                        },
                      )
                    ],
                  ),
                  CustomButton(
                    onPressed: () {
                      context.read<VerifyPhoneBloc>().add(VerifyOtp(
                        otp: controller.text,
                      ));
                    },
                    title: "Continue",
                    disabled: controller.text.length != 6,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
