import 'dart:developer';

import 'package:attach_club/core/components/button.dart';
import 'package:attach_club/core/components/step_progress_indicator.dart';
import 'package:attach_club/core/components/text_field.dart';
import 'package:attach_club/features/on_board1/bloc/on_board1_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoard1 extends StatefulWidget {
  static const globalPadding = 24.0;

  const OnBoard1({super.key});

  @override
  State<OnBoard1> createState() => _OnBoard1State();
}

class _OnBoard1State extends State<OnBoard1> {
  final userNameController = TextEditingController();
  final nameController = TextEditingController();
  final professionController = TextEditingController();
  final aboutController = TextEditingController();
  int loading = -1;

  bool disabled = true;

  @override
  void dispose() {
    userNameController.dispose();
    nameController.dispose();
    professionController.dispose();
    aboutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<OnBoard1Bloc, OnBoard1State>(
          listener: (context, state) {
            if (state is ShowLoading) {
              loading = 0;
              _sendUpdate();
            }
            if (state is ShowVerifiedIcon) {
              loading = 1;
              _sendUpdate();
            }
            if (state is ButtonStatusUpdated) {
              disabled = state.disabled;
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: OnBoard1.globalPadding),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 0.0622 * height),
                      child: const StepProgressIndicator(
                        padding: OnBoard1.globalPadding,
                        totalBars: 4,
                        selectedBars: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 0.0257 * height,
                        bottom: 0.0343 * height,
                      ),
                      child: const Text(
                        "Complete your profile",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                    const Text(
                      "Profile Link",
                      style: TextStyle(
                        color: Color(0xFFCED2D6),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 0.0171 * height,
                        bottom: 0.008583690987 * height,
                      ),
                      child: CustomTextField(
                        type: TextFieldType.RegularTextField,
                        hintText: "Enter username",
                        suffixIcon: _getSuffixIcon(),
                        controller: userNameController,
                        onChanged: (s) {
                          _sendUpdate();
                        },
                      ),
                    ),
                    GestureDetector(
                      child: Text(
                        "Verify",
                        style: _getTextStyle(
                            const Color(0xFF4285F4), 14, FontWeight.w400),
                      ),
                      onTap: () {
                        context.read<OnBoard1Bloc>().add(
                              OnVerifyClicked(userNameController.text),
                            );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0.0343 * height, bottom: 4),
                      child: Text(
                        "Your profile will be available at:",
                        style: _getTextStyle(Colors.white, 14, FontWeight.w400),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                          text: "www.theattachclub.com/",
                          style:
                              _getTextStyle(Colors.white, 20, FontWeight.w500),
                          children: const [TextSpan(text: "username")]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 0.0343 * height,
                        bottom: 0.01716738197 * height,
                      ),
                      child: Text(
                        "Basic Details",
                        style: _getTextStyle(
                            const Color(0xFFCED2D6), 14, FontWeight.w500),
                      ),
                    ),
                    CustomTextField(
                      type: TextFieldType.RegularTextField,
                      hintText: "Name",
                      controller: nameController,
                      onChanged: (s){
                        _sendUpdate();
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 0.01287553648 * height),
                      child: CustomTextField(
                        type: TextFieldType.RegularTextField,
                        hintText: "Profession",
                        controller: professionController,
                        onChanged: (e){
                          _sendUpdate();
                        },
                      ),
                    ),
                    CustomTextField(
                      type: TextFieldType.RegularTextField,
                      hintText: "About yourself",
                      isTextArea: true,
                      controller: aboutController,
                      onChanged: (e){
                        _sendUpdate();
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0.03 * height),
                      child: CustomButton(
                        onPressed: () {
                          log("clicked");
                        },
                        title: "Next",
                        assetName: "assets/svg/arrow_right.svg",
                        disabled: disabled,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _sendUpdate(){
    context.read<OnBoard1Bloc>().add(
      OnFieldsUpdated(
        username: userNameController.text,
        name: nameController.text,
        profession: professionController.text,
        about: aboutController.text,
        loading: loading,
      ),
    );
  }

  Widget? _getSuffixIcon() {
    if (loading == 0) {
      return const SizedBox(
        width: 24,
        height: 24,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    } else if (loading == 1) {
      return SizedBox(
        width: 24,
        height: 24,
        child: Center(
          child: SvgPicture.asset(
            "assets/svg/check_circle.svg",
            color: Colors.blue,
          ),
        ),
      );
    }

    return null;
  }

  _getTextStyle(Color color, double fontSize, FontWeight weight) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: weight,
    );
  }
}
