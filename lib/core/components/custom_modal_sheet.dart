import 'package:flutter/material.dart';

void showCustomModalBottomSheet({
  required BuildContext context,
  required Widget child,
  double sheetHeight = 0.5,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return CustomSheet(
        sheetHeight: sheetHeight,
        child: child,
      );
    },
    isScrollControlled: true,
  );
}

class CustomSheet extends StatelessWidget {
  final Widget child;
  final double sheetHeight;

  const CustomSheet({
    super.key,
    required this.child,
    required this.sheetHeight,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        margin: EdgeInsets.zero,
        color: Colors.transparent,
        width: width,
        height: sheetHeight * height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.5),
              ),
              child: SizedBox(
                width: 0.323 * width,
                height: 5,
              ),
            ),
            Expanded(
              child: Card(
                color: const Color(0xFF26293B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.0556 * width),
                  child: child,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
