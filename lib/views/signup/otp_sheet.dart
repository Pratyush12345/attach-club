import 'package:attach_club/core/button.dart';
import 'package:attach_club/core/custom_modal_sheet.dart';
import 'package:attach_club/views/signup/otp_input_field.dart';
import 'package:attach_club/views/signup/reset_text.dart';
import 'package:flutter/material.dart';

void showOtpBottomSheet(
  BuildContext context,
  double width,
  double height,
) {
  showCustomModalBottomSheet(
    context: context,
    child: const OtpSheet(),
  );
}

class OtpSheet extends StatelessWidget {
  const OtpSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
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
            padding: EdgeInsets.only(top: 0.0579 * height),
            child: CustomButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, "/onboard1");
              },
              title: "Continue",
              assetName: "assets/svg/arrow_right.svg",
            ),
          )
        ],
      ),
    );
  }
}
