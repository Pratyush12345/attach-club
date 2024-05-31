import 'package:attach_club/constants.dart';
import 'package:attach_club/core/components/heading.dart';
import 'package:attach_club/core/components/text_field.dart';
import 'package:attach_club/views/verify_otp/verify_otp.dart';
import 'package:flutter/material.dart';
import '../../core/components/button.dart';

class VerifyPhone extends StatefulWidget {
  const VerifyPhone({super.key});

  @override
  State<VerifyPhone> createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  final controller = TextEditingController();
  bool disabled = true;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: horizontalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 0.01364806867 * height),
                    const Heading(title: "Verify Mobile Number"),
                    SizedBox(height: 0.0525751073 * height),
                    CustomTextField(
                      type: TextFieldType.PhoneNumberField,
                      hintText: "Enter OTP",
                      controller: controller,
                      keyboardType: TextInputType.number,
                      onChanged: (s) {
                        setState(() {
                          disabled = s.length != 10;
                        });
                      },
                    ),
                  ],
                ),
                CustomButton(
                  title: "Proceed",
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => VerifyOTP(
                          phoneNumber: controller.text,
                        ),
                      ),
                    );
                  },
                  disabled: disabled,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
