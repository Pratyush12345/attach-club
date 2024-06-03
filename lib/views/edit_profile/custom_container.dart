import 'package:attach_club/core/components/custom_modal_sheet.dart';
import 'package:attach_club/models/globalVariable.dart';
import 'package:attach_club/views/edit_profile/edit_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/edit_profile/edit_profile_bloc.dart';

class CustomContainer extends StatefulWidget {
  final String title;
  final String hintText;
  final bool disabled;
  final String param;
  final void Function(String) updateTitle;

  const CustomContainer({
    super.key,
    required this.title,
    required this.hintText,
    this.disabled = false,
    required this.param,
    required this.updateTitle,
  });

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (!widget.disabled)?_openModal:null,
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
              ],
            ),
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

  _openModal() {
    showCustomModalBottomSheet(
      context: context,
      sheetHeight: 0.22,
      child: EditSheet(
        initialText: widget.title,
        onSave: (text) {
<<<<<<< HEAD
          print("text-------$text");
          context.read<EditProfileBloc>().add(UpdateTriggered());
          GlobalVariable.isAnyChangeInProfile = true;
=======
          context.read<EditProfileBloc>().add(UpdateTriggered(
            key: widget.param,
            value: text
          ));
          widget.updateTitle(text);
>>>>>>> e63b041be862c79e2f4418d19f3c3ce12e9b8208
        },
        hintText: widget.hintText,
      ),
    );
  }
}
