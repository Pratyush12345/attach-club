import 'dart:developer';

import 'package:attach_club/bloc/signup/signup_bloc.dart';
import 'package:attach_club/constants.dart';
import 'package:attach_club/core/components/button.dart';
import 'package:attach_club/core/components/text_field.dart';
import 'package:attach_club/views/signup/otp_sheet.dart';
import 'package:attach_club/views/signup/wave_animation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
      context.read<SignupBloc>().add(CheckOnboardingStatus());
    }
  }

  void resendOtp(int count) {
    if (count == 0) {
      context.read<SignupBloc>().add(
            PhoneVerificationTriggered(
                phoneNumber: controller.text,
                verificationFailed: verificationFailed,
                verificationCompleted: verificationCompleted),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is PhoneVerificationSuccess) {
          context.read<SignupBloc>().add(CheckOnboardingStatus());
        }
        if (state is GoogleLoginSuccess) {
          context.read<SignupBloc>().add(const CheckPhoneNumberValidity());
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
        if (state is NavigateToPhoneVerification) {
          Navigator.of(context).popUntil((route) => false);
          Navigator.of(context).pushNamed("/verifyPhone");
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: width,
                  height: 0.48 * height,
                  child: const CircleWaveRoute(),
                ),
                Container(
                  color: const Color(0xFF181B2F),
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // const SizedBox(height: 10,),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 0.0558 * size.width,
                        ),
                        child: Column(
                          children: [
                            CustomTextField(
                              type: TextFieldType.PhoneNumberField,
                              controller: controller,
                              keyboardType: TextInputType.number,
                              onChanged: (_) {
                                setState(() {});
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 24),
                              child: CustomButton(
                                disabled: controller.text.length != 10,
                                title: "Proceed",
                                onPressed: () {
                                  showOtpBottomSheet(
                                    context,
                                    resendOtp,
                                    controller.text,
                                  );
                                  context.read<SignupBloc>().add(
                                        PhoneVerificationTriggered(
                                          phoneNumber: controller.text,
                                          verificationFailed:
                                              verificationFailed,
                                          verificationCompleted:
                                              verificationCompleted,
                                        ),
                                      );
                                },
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 24),
                              child: Row(
                                children: [
                                  Expanded(child: Divider()),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text(
                                      "or",
                                      style: TextStyle(
                                        color: primaryTextColor,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                  Expanded(child: Divider()),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(0.888 * size.width, 56),
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                context
                                    .read<SignupBloc>()
                                    .add(GoogleLoginTriggered());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Continue with",
                                    style: TextStyle(
                                      color: primaryTextColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Image.asset(
                                      "assets/images/google_logo.png",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 0.05472 * height),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            text:
                                "By signing in, you agree with our Terms and Condition and Privacy Policy",
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
