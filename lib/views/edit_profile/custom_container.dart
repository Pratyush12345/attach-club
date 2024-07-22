import 'package:attach_club/core/components/custom_modal_sheet.dart';
import 'package:attach_club/core/components/text_field.dart';
import 'package:attach_club/views/edit_profile/edit_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../bloc/edit_profile/edit_profile_bloc.dart';
import '../../constants.dart';

class CustomContainer extends StatefulWidget {
  final String title;
  final String hintText;
  final bool disabled;
  final String param;
  final bool isProfessionDropdown;
  final void Function(String) updateTitle;

  const CustomContainer({
    super.key,
    required this.title,
    required this.hintText,
    this.disabled = false,
    required this.param,
    required this.updateTitle,
    this.isProfessionDropdown = false,
  });

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (!widget.disabled) ? _decideModel : null,
      child: Container(
          height: widget.hintText == "Description" ? 110 :64,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width *0.85,
                  
                  child: Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    widget.title,
                    style: _getTextStyle(
                      Colors.white,
                      20,
                      FontWeight.w400,
                    ),
                  ),
                
              ),
              (widget.isProfessionDropdown)
                  ? Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: SvgPicture.asset(
                        "assets/svg/arrow_down.svg",
                        width: 24,
                        height: 24,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  _decideModel() {
    if (widget.isProfessionDropdown) {
      _onProfessionClick(MediaQuery.of(context).size.height);
    } else {
      _openModal();
    }
  }

  _getTextStyle(Color color, double fontSize, FontWeight weight) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: weight,
    );
  }

  _onProfessionClick(double height) {
    final controller = TextEditingController();
    showCustomModalBottomSheet(
      context: context,
      sheetHeight: 0.6,
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 0.4887700535 * height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 0.03540772532 * height),
              const Text(
                "Select Profession",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 0.02789699571 * height),
              CustomTextField(
                type: TextFieldType.RegularTextField,
                controller: controller,
                hintText: "Search",
                onChanged: (text) {
                  context.read<EditProfileBloc>().add(
                        FilterProfessions(text),
                      );
                },
              ),
              SizedBox(height: 0.02789699571 * height),
              BlocBuilder<EditProfileBloc, EditProfileState>(
                builder: (context, state) {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: context
                          .read<EditProfileBloc>()
                          .filteredProfessionsList
                          .length,
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.updateTitle(context
                                  .read<EditProfileBloc>()
                                  .filteredProfessionsList[i]);
                              Navigator.pop(context);
                              context.read<EditProfileBloc>().add(
                                    UpdateTriggered(
                                      key: widget.param,
                                      value: context
                                          .read<EditProfileBloc>()
                                          .filteredProfessionsList[i],
                                    ),
                                  );
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xFF181B2F),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              height: 48,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 18),
                                          child: Text(
                                            context
                                                .read<EditProfileBloc>()
                                                .filteredProfessionsList[i],
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
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
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
    // showModalBottomSheet(
    //   context: context,
    //   isScrollControlled: true,
    //   builder: (context) {
    //     return SizedBox(
    //       width: double.infinity,
    //       height: 0.4887700535 * height,
    //       child: Padding(
    //         padding: const EdgeInsets.symmetric(
    //           horizontal: horizontalPadding,
    //         ),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             SizedBox(height: 0.03540772532 * height),
    //             const Text(
    //               "Selected Platform",
    //               style: TextStyle(fontSize: 16, color: Colors.white),
    //             ),
    //             SizedBox(height: 0.02789699571 * height),
    //             CustomTextField(
    //               type: TextFieldType.RegularTextField,
    //               controller: controller,
    //               hintText: "Search",
    //               onChanged: (text) {
    //                 context.read<EditProfileBloc>().add(
    //                       FilterProfessions(text),
    //                     );
    //               },
    //             ),
    //             SizedBox(height: 0.02789699571 * height),
    //             BlocBuilder<EditProfileBloc, EditProfileState>(
    //               builder: (context, state) {
    //                 return ListView.builder(
    //                   shrinkWrap: true,
    //                   itemCount: context
    //                       .read<EditProfileBloc>()
    //                       .filteredProfessionsList
    //                       .length,
    //                   itemBuilder: (context, i) {
    //                     return GestureDetector(
    //                       onTap: () {
    //                         setState(() {
    //                           widget.updateTitle(context
    //                               .read<EditProfileBloc>()
    //                               .filteredProfessionsList[i]);
    //                           Navigator.pop(context);
    //                           context.read<EditProfileBloc>().add(
    //                                 UpdateTriggered(
    //                                   key: widget.param,
    //                                   value: context
    //                                       .read<EditProfileBloc>()
    //                                       .filteredProfessionsList[i],
    //                                 ),
    //                               );
    //                         });
    //                       },
    //                       child: Padding(
    //                         padding: const EdgeInsets.only(bottom: 8.0),
    //                         child: Container(
    //                           width: double.infinity,
    //                           decoration: BoxDecoration(
    //                             color: const Color(0xFF181B2F),
    //                             borderRadius: BorderRadius.circular(8),
    //                           ),
    //                           height: 48,
    //                           child: Row(
    //                             children: [
    //                               Expanded(
    //                                 child: Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.start,
    //                                   crossAxisAlignment:
    //                                       CrossAxisAlignment.center,
    //                                   children: [
    //                                     Padding(
    //                                       padding:
    //                                           const EdgeInsets.only(left: 18),
    //                                       child: Text(
    //                                         context
    //                                             .read<EditProfileBloc>()
    //                                             .filteredProfessionsList[i],
    //                                         style: const TextStyle(
    //                                           fontSize: 16,
    //                                           color: Colors.white,
    //                                         ),
    //                                       ),
    //                                     )
    //                                   ],
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ),
    //                     );
    //                   },
    //                 );
    //               },
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );
  }

  _openModal() {
    showCustomModalBottomSheet(
      context: context,
      sheetHeight: 0.22,
      child: EditSheet(
        initialText: widget.title,
        onSave: (text) {
          context.read<EditProfileBloc>().add(
                UpdateTriggered(key: widget.param, value: text),
              );
          widget.updateTitle(text);
        },
        hintText: widget.hintText,
      ),
    );
  }
}
