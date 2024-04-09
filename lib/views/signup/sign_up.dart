import 'package:attach_club/core/button.dart';
import 'package:attach_club/core/text_field.dart';
import 'package:attach_club/views/signup/otp_sheet.dart';
import 'package:attach_club/views/signup/wave_animation.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 0.0558 * size.width),
                      child: Column(
                        children: [
                          CustomTextField(
                            type: TextFieldType.PhoneNumberField,
                            controller: controller,
                            keyboardType: TextInputType.number,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 24),
                            child: CustomButton(
                              title: "Proceed",
                              onPressed: () {
                                showOtpBottomSheet(context, width, height);
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
                            onPressed: () {},
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
    );
  }
}
