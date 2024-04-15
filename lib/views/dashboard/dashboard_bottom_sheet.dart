import 'package:attach_club/core/components/custom_modal_sheet.dart';
import 'package:attach_club/core/components/heading.dart';
import 'package:flutter/material.dart';

import '../../core/components/button.dart';
import '../../core/components/label.dart';
import '../../core/components/text_field.dart';

showDashboardBottomSheet(BuildContext context) {
  showCustomModalBottomSheet(
      context: context,
      child: const DashboardBottomSheet(),
      sheetHeight: 0.3519313305);
}

class DashboardBottomSheet extends StatefulWidget {
  const DashboardBottomSheet({super.key});

  @override
  State<DashboardBottomSheet> createState() => _DashboardBottomSheetState();
}

class _DashboardBottomSheetState extends State<DashboardBottomSheet> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 0.03111587983 * height),
          const Heading(
            title: "Whatsapp Number",
          ),
          const SizedBox(height: 8),
          const Label(title: "Please enter receiver's WhatsApp number"),
          SizedBox(height: 0.0364806867 * height),
          CustomTextField(
            type: TextFieldType.RegularTextField,
            controller: controller,
            hintText: "00000 00000",
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 0.03004291845 * height),
          CustomButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            title: "Send",
          ),
        ],
      ),
    );
  }
}
