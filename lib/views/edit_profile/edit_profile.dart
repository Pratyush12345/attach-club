import 'package:attach_club/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:attach_club/constants.dart';
import 'package:attach_club/core/components/custom_modal_sheet.dart';
import 'package:attach_club/core/components/label.dart';
import 'package:attach_club/core/components/text_field.dart';
import 'package:attach_club/core/repository/user_data_notifier.dart';
import 'package:attach_club/views/edit_profile/custom_container.dart';
import 'package:attach_club/views/edit_profile/edit_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    super.key,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final userNameController = TextEditingController();
  final nameController = TextEditingController();
  final professionController = TextEditingController();
  final descriptionController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final stateController = TextEditingController();
  final pinCodeController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();

  // bool disabled = true;

  @override
  void dispose() {
    userNameController.dispose();
    nameController.dispose();
    professionController.dispose();
    descriptionController.dispose();
    phoneNumberController.dispose();
    stateController.dispose();
    pinCodeController.dispose();
    countryController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final bloc = context.read<EditProfileBloc>();
    final userData = context.read<UserDataNotifier>().userData;
    bloc.username = userData.username;
    bloc.name = userData.name;
    bloc.profession = userData.profession;
    bloc.description = userData.description;
    bloc.phoneNumber = userData.phoneNo;
    bloc.stateText = userData.state;
    bloc.pinCode = userData.pin;
    bloc.country = userData.country;
    bloc.city = userData.city;
    userNameController.text = bloc.username;
    nameController.text = bloc.name;
    professionController.text = bloc.profession;
    descriptionController.text = bloc.description;
    phoneNumberController.text = bloc.phoneNumber;
    stateController.text = bloc.stateText;
    pinCodeController.text = bloc.pinCode;
    countryController.text = bloc.country;
    cityController.text = bloc.city;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<EditProfileBloc, EditProfileState>(
          listener: (context, state) {
            if (state is ShowSnackBar) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
            if (state is InitialUserData) {
              userNameController.text = state.userData.username;
              nameController.text = state.userData.name;
              professionController.text = state.userData.profession;
              descriptionController.text = state.userData.description;
            }
            if (state is DataUpdated) {
              nameController.text = state.name;
              professionController.text = state.profession;
              descriptionController.text = state.description;
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 0.0257 * height),
                    const Label(title: "Profile Link"),
                    SizedBox(height: 0.0171 * height),
                    CustomTextField(
                      type: TextFieldType.RegularTextField,
                      hintText: "Enter username",
                      suffixIcon: SizedBox(
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
                      ),
                      controller: userNameController,
                      onChanged: (s) {
                        //remove all spaces from username
                        userNameController.text = userNameController.text
                            .replaceAll(RegExp(r"\s+"), "");
                        // _sendUpdate(isUsername: true);
                      },
                      disabled: true,
                    ),
                    SizedBox(height: 0.0243 * height),
                    const Label(
                      title: "Your profile will be available at:",
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    RichText(
                      text: TextSpan(
                        text: "www.theattachclub.com/",
                        style: _getTextStyle(Colors.white, 20, FontWeight.w500),
                        children: [
                          TextSpan(text: userNameController.text),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.0343 * height,
                    ),
                    const Label(title: "Basic Details"),
                    SizedBox(height: 0.01716738197 * height),
                    CustomContainer(
                      title: nameController.text,
                      hintText: "Name",
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 0.01287553648 * height,
                      ),
                      child: CustomContainer(
                        title: professionController.text,
                        hintText: "Profession",
                      ),
                    ),
                    CustomContainer(
                      title: phoneNumberController.text,
                      hintText: "Phone Number",
                      disabled: true,
                    ),
                    SizedBox(height: 0.01287553648 * height),
                    CustomContainer(
                      title: descriptionController.text,
                      hintText: "Description",
                    ),
                    SizedBox(height: 0.0343 * height),
                    const Label(title: "Address"),
                    SizedBox(height: 0.01716738197 * height),
                    CustomContainer(
                      title: stateController.text,
                      hintText: "State",
                    ),
                    SizedBox(height: 0.01287553648 * height),
                    CustomContainer(
                      title: cityController.text,
                      hintText: "City",
                    ),
                    SizedBox(height: 0.01287553648 * height),
                    CustomContainer(
                      title: pinCodeController.text,
                      hintText: "Pin Code",
                    ),
                    SizedBox(
                      height: 0.01287553648 * height
                    ),
                    CustomContainer(
                      title: countryController.text,
                      hintText: "Country",
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _getTextStyle(Color color, double fontSize, FontWeight weight) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: weight,
    );
  }

// _sendUpdate({bool isUsername = false}) {
//   context.read<EditProfileBloc>().add(
//     OnFieldsUpdated(
//       username: userNameController.text,
//       name: nameController.text,
//       profession: professionController.text,
//       about: descriptionController.text,
//       loading: loading,
//       isUsernameUpdated: isUsername,
//     ),
//   );
// }

// Widget? _getSuffixIcon() {
//   if (loading == 0) {
//     return const SizedBox(
//       width: 12,
//       height: 12,
//       child: Center(
//         child: CircularProgressIndicator(
//           color: Colors.purple,
//         ),
//       ),
//     );
//   } else if (loading == 1) {
//     return SizedBox(
//       width: 24,
//       height: 24,
//       child: Center(
//         child: SvgPicture.asset(
//           "assets/svg/check_circle.svg",
//           colorFilter: const ColorFilter.mode(
//             Colors.blue,
//             BlendMode.srcIn,
//           ),
//         ),
//       ),
//     );
//   }
//
//   return null;
// }

// List<Widget> _getHeader(double height) {
//   if (!widget.isInsideManageProfile) {
//     return [
//       const OnBoardingHero(
//         totalBars: 4,
//         selectedBars: 1,
//       ),
//       SizedBox(
//         height: 0.0257 * height,
//       ),
//       const Heading(title: "Complete your profile"),
//     ];
//   }
//   return [];
// }
}
