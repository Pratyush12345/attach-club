import 'package:attach_club/core/components/button.dart';
import 'package:attach_club/core/components/custom_modal_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showProfileSheetModal(
  BuildContext context,
  void Function() onChangeClick,
  void Function() onDeleteClick,
) {
  showCustomModalBottomSheet(
    context: context,
    sheetHeight: 0.21,
    child: EditImage(
      onChangeClick: onChangeClick,
      onDeleteClick: onDeleteClick,
    ),
  );
}

class EditImage extends StatelessWidget {
  final void Function() onChangeClick;
  final void Function() onDeleteClick;

  const EditImage({
    super.key,
    required this.onChangeClick,
    required this.onDeleteClick,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          CustomButton(
            onPressed: () {
              Navigator.pop(context);
              onChangeClick();
            },
            title: "Change",
            buttonWidth: 0.425581,
          ),
          const SizedBox(
            width: 16,
          ),
          CustomButton(
            onPressed: () {
              onDeleteClick();
              Navigator.pop(context);
            },
            title: "Remove",
            buttonWidth: 0.425581,
            isDark: true,
          ),
        ],
      ),
    );
  }
}
