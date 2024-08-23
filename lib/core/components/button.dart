import 'package:attach_club/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButton extends StatelessWidget {

  final bool isDark;
  final void Function() onPressed;
  final String title;
  final String? assetName;
  final bool disabled;
  final double? buttonWidth;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? doubleSize;
  final ButtonType buttonType;
  final Color? color;
  final Color? textColor;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.assetName,
    this.disabled = false,
    this.isDark = false,
    this.buttonWidth,
    this.prefixIcon,
    this.suffixIcon,
    this.doubleSize,
    this.buttonType = ButtonType.LargeButton,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: textColor ?? primaryTextColor,
      fontSize: 18,
      fontWeight: FontWeight.w400,
    );
    final width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      style: ButtonStyle(
        side: MaterialStateProperty.resolveWith<BorderSide>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled) || isDark) {
              return const BorderSide(
                  color: Colors.white,
                  width: 1); // Border width for disabled state
            }
            return BorderSide.none; // No border for other states
          },
        ),
        fixedSize: MaterialStateProperty.resolveWith(
          (states) => Size(
            (buttonWidth ?? 0.8883) * width,
            (buttonType == ButtonType.LargeButton) ? 64 : 48,
          ),
        ),
        shape: MaterialStateProperty.resolveWith(
          (states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.disabled) || isDark) {
              return Colors.transparent;
            } else if(color!=null){
              return color;
            }else{
              return const Color(0xFF2D4CF9);
            }
          },
        ),
      ),
      onPressed: (disabled) ? null : onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          prefixIcon ?? const SizedBox(),
          Text(
            title,
            style: textStyle,
          ),
          if (assetName != null)
            Padding(
              padding: EdgeInsets.only(left: 1.8),
              child: SvgPicture.asset(
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                assetName ?? "assets/svg/arrow_right.svg",
                semanticsLabel: 'Acme Logo',
                width: doubleSize,
                height: doubleSize,
              ),
            ),
          SizedBox(width: 2.0,),  
         suffixIcon ?? const SizedBox(),   
        ],
      ),
    );
  }
}

enum ButtonType {
  LargeButton,
  ShortButton,
}
