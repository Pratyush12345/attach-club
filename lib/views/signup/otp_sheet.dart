import 'package:attach_club/bloc/signup/signup_bloc.dart';
import 'package:attach_club/core/components/button.dart';
import 'package:attach_club/core/components/custom_modal_sheet.dart';
import 'package:attach_club/views/signup/otp_input_field.dart';
import 'package:attach_club/views/signup/reset_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showOtpBottomSheet(
  BuildContext context,
  String verificationId,
) {
  showCustomModalBottomSheet(
    context: context,
    child: OtpSheet(
      verificationId: verificationId,
    ),
  );
}

class OtpSheet extends StatefulWidget {
  final String verificationId;

  const OtpSheet({
    super.key,
    required this.verificationId,
  });

  @override
  State<OtpSheet> createState() => _OtpSheetState();
}

class _OtpSheetState extends State<OtpSheet> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFF26293B),
      body: BlocListener<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is ShowBottomSheetSnackBar) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
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
                child: OtpInputField(
                  controller: controller,
                  verificationId: widget.verificationId,
                ),
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
                    context.read<SignupBloc>().add(VerifyOtp(
                          verificationId: widget.verificationId,
                          otp: controller.text,
                        ));
                  },
                  title: "Continue",
                  assetName: "assets/svg/arrow_right.svg",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
