import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpInputField extends StatelessWidget {
  final TextEditingController controller;
  final String verificationId;

  const OtpInputField({
    super.key,
    required this.controller,
    required this.verificationId,
  });

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: controller,
      length: 6,
      showCursor: true,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      defaultPinTheme: PinTheme(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: const Color(0xFF373A4B),
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
      focusedPinTheme: PinTheme(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: const Color(0xFF373A4B),
          border: Border.all(
            color: Colors.white.withOpacity(0.5),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
      isCursorAnimationEnabled: false,
      onCompleted: (String code) {
        // context.read<SignupBloc>().add(VerifyOtp(
        //       verificationId: verificationId,
        //       otp: code,
        //     ));
      },
    );
  }
}
