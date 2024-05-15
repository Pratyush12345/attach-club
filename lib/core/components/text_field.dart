import 'package:attach_club/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextFieldType type;
  final String? hintText;
  final Widget? suffixIcon;
  final bool isTextArea;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final Widget? prefixWidget;
  final bool disabled;
  final Color? color;
  final TextInputType keyboardType;
  final double height;
  final double fontSize;

  const CustomTextField({
    super.key,
    required this.type,
    required this.controller,
    this.hintText,
    this.suffixIcon,
    this.isTextArea = false,
    this.onChanged,
    this.prefixWidget,
    this.disabled = false,
    this.color,
    this.height = 64,
    this.fontSize = 20,
    this.keyboardType = TextInputType.text,
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
      fontSize: widget.fontSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: 0.8883 * width,
      height: (!widget.isTextArea) ?widget.height:null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: _isFocused ? Colors.white : Colors.transparent,
          width: 1.0,
        ),
        color: widget.color ?? const Color(0xFFFFFFFF).withOpacity(0.08),
      ),
      child: Focus(
        onFocusChange: (hasFocus) {
          setState(() {
            _isFocused = hasFocus;
          });
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: TextField(
              focusNode: _focusNode,
              onChanged: widget.onChanged,
              controller: widget.controller,
              maxLines: (widget.isTextArea) ? 3 : 1,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                prefixIcon: _getPrefixIcon(),
                prefixIconConstraints: _getPrefixConstraints(),
                hintText: _getHintText(),
                hintStyle: textStyle(paragraphTextColor),
                suffixIcon: widget.suffixIcon,
                // isDense: !widget.isTextArea,
                // contentPadding: (!widget.isTextArea)?EdgeInsets.zero:null,
              ),
              style: textStyle(primaryTextColor),
              keyboardType: widget.keyboardType,
              readOnly: widget.disabled,
            ),
          ),
        ),
      ),
    );
  }

  _getPrefixConstraints(){
    if(widget.type == TextFieldType.PhoneNumberField){
      return const BoxConstraints(maxWidth: 73);
    }
    if(widget.prefixWidget != null) {
      return const BoxConstraints(maxWidth: 30);
    }
    return const BoxConstraints(maxWidth: 0);
  }

  Widget? _getPrefixIcon() {
    if (widget.type == TextFieldType.PhoneNumberField) {
      return Row(
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
            style: textStyle(primaryTextColor),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            width: 1,
            color: Colors.white,
            height: 20,
          )
        ],
      );
    } else {
      return Center(
        child: widget.prefixWidget,
      );
    }
  }

  String? _getHintText() {
    if (widget.type == TextFieldType.PhoneNumberField) {
      return "00000 00000";
    } else {
      return widget.hintText;
    }
  }
}

enum TextFieldType {
  PhoneNumberField,
  RegularTextField,
}
