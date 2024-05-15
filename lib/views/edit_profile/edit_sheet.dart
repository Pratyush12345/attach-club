import 'package:attach_club/core/components/button.dart';
import 'package:attach_club/core/components/text_field.dart';
import 'package:flutter/material.dart';

class EditSheet extends StatefulWidget {
  final String initialText;
  final String hintText;
  final void Function(String) onSave;

  const EditSheet({
    super.key,
    required this.initialText,
    required this.hintText,
    required this.onSave,
  });

  @override
  State<EditSheet> createState() => _EditSheetState();
}

class _EditSheetState extends State<EditSheet> {
  final bottomSheetController = TextEditingController();

  @override
  void dispose() {
    bottomSheetController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    bottomSheetController.text = widget.initialText;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomTextField(
            type: TextFieldType.RegularTextField,
            controller: bottomSheetController,
            hintText: widget.hintText,
          ),
          CustomButton(
            onPressed: (){
              widget.onSave(bottomSheetController.text);
              Navigator.pop(context);
            },
            title: "Save",
          ),
        ],
      ),
    );
  }
}
