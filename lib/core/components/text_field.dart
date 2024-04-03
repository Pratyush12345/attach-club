import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextFieldType type;
  final double width;

  const CustomTextField({
    super.key,
    required this.type,
    required this.width,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  TextStyle textStyle(Color color) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.w400,
      fontSize: 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == TextFieldType.PhoneNumberField) {
      return Container(
        width: 0.8883 * widget.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _isFocused ? Colors.white : Colors.transparent,
              width: 1.0,
            ),
            color: const Color(0xFFFFFFFF).withOpacity(0.08)),
        child: Focus(
          onFocusChange: (hasFocus) {
            setState(() {
              _isFocused = hasFocus;
            });
          },
          child: TextField(
            cursorColor: Colors.white,
            decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 13.0),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 9.0),
                        child: Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "91",
                        style: textStyle(Colors.white),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: 1,
                        color: Colors.white,
                        height: 20,
                      )
                    ],
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(maxWidth: 90),
                hintText: "00000 00000",
                hintStyle: textStyle(Colors.white.withOpacity(0.5))),
            style: textStyle(Colors.white),
            keyboardType: TextInputType.number,
          ),
        ),
      );
    } else {
      return const TextField();
    }
  }
}

enum TextFieldType {
  PhoneNumberField,
  RegularTextField,
}
