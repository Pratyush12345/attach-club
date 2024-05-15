import 'package:attach_club/bloc/complete_profile/complete_profile_bloc.dart';
import 'package:attach_club/constants.dart';
import 'package:attach_club/core/components/button.dart';
import 'package:attach_club/core/components/heading.dart';
import 'package:attach_club/core/components/label.dart';
import 'package:attach_club/core/components/onboarding_hero.dart';
import 'package:attach_club/core/components/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CompleteProfile extends StatefulWidget {
  final bool isInsideManageProfile;

  const CompleteProfile({
    super.key,
    this.isInsideManageProfile = false,
  });

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  final userNameController = TextEditingController();
  final nameController = TextEditingController();
  final professionController = TextEditingController();
  final descriptionController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final pincodeController = TextEditingController();
  final countryController = TextEditingController();
  int loading = -1;

  bool disabled = true;

  @override
  void dispose() {
    userNameController.dispose();
    nameController.dispose();
    professionController.dispose();
    descriptionController.dispose();
    stateController.dispose();
    cityController.dispose();
    pincodeController.dispose();
    countryController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<CompleteProfileBloc>().add(GetUserData());
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<CompleteProfileBloc, CompleteProfileState>(
          listener: (context, state) {
            if (state is ShowLoading) {
              loading = 0;
              _sendUpdate();
            }
            if (state is ShowVerifiedIcon) {
              loading = 1;
              _sendUpdate();
            }
            if (state is StopLoading) {
              loading = -1;
              _sendUpdate();
            }
            if (state is ButtonStatusUpdated) {
              disabled = state.disabled;
            }
            if (state is ShowSnackBar) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
            if (state is NavigateToNextPage) {
              Navigator.pushNamed(context, "/onboard2");
            }
            if (state is InitialUserData) {
              userNameController.text = state.userData.username;
              nameController.text = state.userData.name;
              professionController.text = state.userData.profession;
              descriptionController.text = state.userData.description;
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ..._getHeader(height),
                          SizedBox(
                            height: 0.0257 * height,
                          ),
                          const Label(title: "Profile Link"),
                          SizedBox(
                            height: 0.0171 * height,
                          ),
                          CustomTextField(
                            type: TextFieldType.RegularTextField,
                            hintText: "Enter username",
                            suffixIcon: _getSuffixIcon(),
                            controller: userNameController,
                            onChanged: (s) {
                              //remove all spaces from username
                              userNameController.text = userNameController.text
                                  .replaceAll(RegExp(r"\s+"), "");
                              _sendUpdate(isUsername: true);
                            },
                            disabled: widget.isInsideManageProfile,
                          ),
                          SizedBox(
                            height: 0.00858 * height,
                          ),
                          if (!widget.isInsideManageProfile)
                            GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Text(
                                  "Verify",
                                  style: _getTextStyle(
                                    const Color(0xFF4285F4),
                                    14,
                                    FontWeight.w400,
                                  ),
                                ),
                              ),
                              onTap: () {
                                context.read<CompleteProfileBloc>().add(
                                      OnVerifyClicked(
                                        userNameController.text,
                                      ),
                                    );
                              },
                            ),
                          SizedBox(
                            height: 0.0343 * height,
                          ),
                          const Label(
                            title: "Your profile will be available at:",
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          RichText(
                            text: TextSpan(
                              text: "www.theattachclub.com/",
                              style: _getTextStyle(
                                  primaryTextColor, 20, FontWeight.w500),
                              children: [
                                TextSpan(text: userNameController.text),
                              ],
                            ),
                          ),
                          SizedBox(height: 0.0343 * height),
                          const Label(title: "Basic Details"),
                          SizedBox(height: 0.01716738197 * height),
                          CustomTextField(
                            type: TextFieldType.RegularTextField,
                            hintText: "Name",
                            controller: nameController,
                            onChanged: (s) {
                              _sendUpdate();
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 0.01287553648 * height,
                            ),
                            child: CustomTextField(
                              type: TextFieldType.RegularTextField,
                              hintText: "Profession",
                              controller: professionController,
                              onChanged: (e) {
                                _sendUpdate();
                              },
                            ),
                          ),
                          CustomTextField(
                            type: TextFieldType.RegularTextField,
                            hintText: "About yourself",
                            isTextArea: true,
                            controller: descriptionController,
                            onChanged: (e) {
                              _sendUpdate();
                            },
                          ),
                          SizedBox(height: 0.0343 * height),
                          const Label(title: "Address"),
                          SizedBox(height: 0.01716738197 * height),
                          CustomTextField(
                            type: TextFieldType.RegularTextField,
                            hintText: "State",
                            controller: stateController,
                            onChanged: (e) {
                              _sendUpdate();
                            },
                          ),
                          SizedBox(height: 0.01287553648*height,),
                          CustomTextField(
                            type: TextFieldType.RegularTextField,
                            hintText: "City",
                            controller: cityController,
                            onChanged: (e) {
                              _sendUpdate();
                            },
                          ),
                          SizedBox(height: 0.01287553648*height,),
                          CustomTextField(
                            type: TextFieldType.RegularTextField,
                            hintText: "Pincode",
                            controller: pincodeController,
                            onChanged: (e) {
                              _sendUpdate();
                            },
                          ),
                          SizedBox(height: 0.01287553648*height,),
                          CustomTextField(
                            type: TextFieldType.RegularTextField,
                            hintText: "Country",
                            controller: countryController,
                            onChanged: (e) {
                              _sendUpdate();
                            },
                          ),
                          SizedBox(height: 0.02467811159*height,),
                        ],
                      ),
                    ),
                  ),
                  if (!widget.isInsideManageProfile)
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: onboardingButtonBottomPadding,
                      ),
                      child: CustomButton(
                        onPressed: () {
                          context
                              .read<CompleteProfileBloc>()
                              .add(NextButtonClicked(
                                username: userNameController.text,
                                name: nameController.text,
                                profession: professionController.text,
                                description: descriptionController.text,
                                state: stateController.text,
                                city: cityController.text,
                                pincode: pincodeController.text,
                                country: countryController.text,
                                isVerified: loading == 1,
                              ));
                        },
                        title: "Next",
                        assetName: "assets/svg/arrow_right.svg",
                        isDark: disabled,
                      ),
                    )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _sendUpdate({bool isUsername = false}) {
    context.read<CompleteProfileBloc>().add(
          OnFieldsUpdated(
            username: userNameController.text,
            name: nameController.text,
            profession: professionController.text,
            about: descriptionController.text,
            loading: loading,
            state: stateController.text,
            city: cityController.text,
            country: countryController.text,
            pincode: pincodeController.text,
            isUsernameUpdated: isUsername,
          ),
        );
  }

  Widget? _getSuffixIcon() {
    if (loading == 0) {
      return const SizedBox(
        width: 12,
        height: 12,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.purple,
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
            colorFilter: const ColorFilter.mode(
              Colors.blue,
              BlendMode.srcIn,
            ),
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

  List<Widget> _getHeader(double height) {
    if (!widget.isInsideManageProfile) {
      return [
        const OnBoardingHero(
          totalBars: 4,
          selectedBars: 1,
        ),
        SizedBox(
          height: 0.0257 * height,
        ),
        const Heading(title: "Complete your profile"),
      ];
    }
    return [];
  }
}
