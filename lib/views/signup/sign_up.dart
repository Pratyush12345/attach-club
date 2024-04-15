import 'package:attach_club/bloc/signup/signup_bloc.dart';
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

  void codeSent(String verificationId, int? resendToken) async {
    showOtpBottomSheet(context, verificationId);
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    //Android only
    final user = await FirebaseAuth.instance.signInWithCredential(credential);
    if (user.user != null && context.mounted) {
      context.read<SignupBloc>().add(CheckOnboardingStatus());
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is GoogleLoginSuccess || state is PhoneVerificationSuccess) {
          context.read<SignupBloc>().add(CheckOnboardingStatus());
        }
        if (state is ShowSnackBar) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
        if (state is NavigateToOnboarding) {
          Navigator.of(context).pushNamed("/onboard1");
        }
        if (state is NavigateToDashboard) {
          Navigator.of(context).pushNamed("/home");
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
                SizedBox(
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 0.0558 * size.width),
                        child: Column(
                          children: [
                            CustomTextField(
                              type: TextFieldType.PhoneNumberField,
                              controller: controller,
                              keyboardType: TextInputType.number,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 24),
                              child: CustomButton(
                                title: "Proceed",
                                onPressed: () {
                                  context.read<SignupBloc>().add(
                                        PhoneVerificationTriggered(
                                          phoneNumber: controller.text,
                                          verificationFailed:
                                              verificationFailed,
                                          codeSent: codeSent,
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
                                        color: Colors.white,
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
                                  backgroundColor: Colors.black),
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
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Image.asset(
                                        "assets/images/google_logo.png"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 0.06472 * height),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                              text:
                                  "By signing in, you agree with our Terms and Condition and Privacy Policy",
                              style: TextStyle(color: Color(0xFF676E76))),
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
