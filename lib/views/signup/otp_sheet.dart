import 'package:attach_club/bloc/signup/signup_bloc.dart';
import 'package:attach_club/constants.dart';
import 'package:attach_club/core/components/button.dart';
import 'package:attach_club/core/components/custom_modal_sheet.dart';
import 'package:attach_club/views/signup/otp_input_field.dart';
import 'package:attach_club/views/signup/resend_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showOtpBottomSheet(
  BuildContext context,
    void Function(int) resendOtp,
    String phoneNumber
) {
  showCustomModalBottomSheet(
    context: context,
    child: OtpSheet(
      resendOtp: resendOtp,
        phoneNumber: phoneNumber
    ),
  );
}

class OtpSheet extends StatefulWidget {
  final void Function(int) resendOtp;
  final String phoneNumber;

  const OtpSheet({
    super.key,
    required this.resendOtp,
    required this.phoneNumber,
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
            context.read<SignupBloc>().isContinuePressed = false;
            setState(() {
              
            });
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
                  "Enter your 6 digit pin",
                  style: TextStyle(
                    color: primaryTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  text:
                      "Please enter 6 digit verification code sent to +91${widget.phoneNumber}",
                  style: const TextStyle(
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
                  updateParentState: (){
                    setState(() {});
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ResendText(
                    resendOtp: widget.resendOtp,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 0.0579 * height),
                child: 
                 context.read<SignupBloc>().isContinuePressed ?
                 const  Center(
                  child: SizedBox(
                                height: 20.0,
                                width: 20.0,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.purple,
                                  ),
                                ),
                              ),
                ):
                CustomButton(
                  onPressed: () {
                    context.read<SignupBloc>().isContinuePressed = true;
                    setState(() {
                    });
                    context.read<SignupBloc>().add(VerifyOtp(
                          otp: controller.text,
                        ));
                  },
                  disabled: controller.text.length!=6,
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
