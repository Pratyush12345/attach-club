import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButton extends StatelessWidget {
  static const textStyle = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  final void Function() onPressed;
  final String title;
  final String? assetName;
  final bool disabled;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.assetName,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.red; // Border color for disabled state
            }
            return null; // No border color for other states
          },
        ),
        side: MaterialStateProperty.resolveWith<BorderSide>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return const BorderSide(color: Colors.white, width: 1); // Border width for disabled state
            }
            return BorderSide.none; // No border for other states
          },
        ),
        fixedSize: MaterialStateProperty.resolveWith(
          (states) => Size(0.8883 * width, 64),
        ),
        shape: MaterialStateProperty.resolveWith(
          (states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith(
          (states){
            if(states.contains(MaterialState.disabled)){
              return Colors.transparent;
            }else {
              return const Color(0xFF2D4CF9);
            }
          },
        ),
      ),
      // style: ElevatedButton.styleFrom(
      //     fixedSize: Size(0.8883 * width, 64),
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(8),
      //     ),
      //     backgroundColor: const Color(0xFF2D4CF9),
      // ),
      onPressed: (disabled) ? null : onPressed,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: textStyle,
          ),
          if (assetName != null)
            Padding(
              padding: EdgeInsets.only(left: 0.02 * width),
              child: SvgPicture.asset(
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  assetName ?? "assets/svg/arrow_right.svg",
                  semanticsLabel: 'Acme Logo'),
            )
        ],
      ),
    );
  }
}
