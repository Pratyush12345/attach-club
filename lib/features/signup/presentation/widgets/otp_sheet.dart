import 'package:attach_club/core/components/button.dart';
import 'package:attach_club/features/signup/presentation/widgets/otp_input_field.dart';
import 'package:attach_club/features/signup/presentation/widgets/reset_text.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

void showOtpBottomSheet(
  BuildContext context,
  double width,
  double height,
) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return OtpSheet(
        width: width,
        height: height,
      );
    },
    isScrollControlled: true,
  );
}

class OtpSheet extends StatelessWidget {
  final double width;
  final double height;

  const OtpSheet({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        margin: EdgeInsets.zero,
        color: Colors.transparent,
        width: width,
        height: 0.5 * height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.5),
              ),
              child: SizedBox(
                width: 0.323 * width,
                height: 5,
              ),
            ),
            Expanded(
              child: Card(
                color: const Color(0xFF26293B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.0556 * width),
                  child: SizedBox(
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 0.045 * height,
                            bottom: 8,
                          ),
                          child: const Text(
                            "Enter your 4 digit pin",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        RichText(
                          text: const TextSpan(
                            text:
                                "Please enter X digit verification code sent to +918279******48",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 0.0625 * width,
                            right: 0.0625 * width,
                            top: 0.0343 * height,
                            bottom: 0.0171 * height,
                          ),
                          child: const OtpInputField(),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ResetText(),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:0.0579*height),
                          child: CustomButton(
                            onPressed: () {
                              Navigator.popAndPushNamed(context, "/onboard");
                            },
                            title: "Continue",
                            assetName: "assets/svg/arrow_right.svg",
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
