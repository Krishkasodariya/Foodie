// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_if_null_operators

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  // CONTROLLER
  TextEditingController controller;

  // MAXIMUM LINES
  int? maxLines;

  // ENABLED
  bool? enabled;

  // CURSOR
  Color? cursorColor;

  // BACKGROUND
  bool? filled;
  Color? backgroundColor;

  // INPUT TEXT
  Color? inpuTextColor;
  double? inpuTextFontSize;
  FontWeight? inputTextFontWeight;

  // BORDER
  double? borderRadius;
  double? borderWidth;
  Color? borderColor;

  // HINT
  String? hintText;

  // SUFFIX ICON
  Widget? suffixIcon;

  // Color? suffixIconColor;
  // void Function()? suffixButtonCallBack;

  // PREFIX ICON
  Widget? prefixIcon;

  //autofocus
  bool autofocus;

  // Color? prefixIconColor;
  // void Function()? prefixButtonCallBack;

  // CALLBACKS
  void Function(String)? onChanged;
  void Function()? onTap;
  void Function(String)? onFieldSubmitted;

  // VALIDATIOM
  String? Function(String?)? validator;

  CustomTextField({
    Key? key,
    required this.controller,
    this.validator,
    this.maxLines = 1,
    this.onChanged,
    this.filled = true,
    this.enabled = true,
    this.cursorColor = Colors.white,
    this.backgroundColor,
    this.inpuTextColor = const Color(0xffC2C3CB),
    this.inpuTextFontSize = 15,
    this.inputTextFontWeight = FontWeight.w500,
    this.borderRadius = 12,
    this.borderWidth = 1,
    this.borderColor = Colors.transparent,
    this.hintText = "Enter your Caption",
    this.suffixIcon,
    this.autofocus=false,
    // this.suffixIconColor = const Color(0xff246BFD),
    // this.suffixButtonCallBack,
    this.prefixIcon,
    // this.prefixIconColor = const Color(0xff757575),
    // this.prefixButtonCallBack,
    this.onTap,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 1,
      enabled: enabled,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      cursorHeight: 20,
      cursorColor: Colors.black,
      maxLines: maxLines,
      style: TextStyle(
        fontWeight: inputTextFontWeight,
        color: Colors.black,
        fontSize: inpuTextFontSize,
        letterSpacing: 0.5,
      ),
      autofocus: autofocus,
      focusNode: FocusNode(),
      decoration: InputDecoration(
        filled: filled,
        contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        fillColor: backgroundColor ?? Color(0xffF5F5F5),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          borderSide: BorderSide(
            color: borderColor!,
            width: borderWidth!,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          borderSide: BorderSide(
            color: borderColor!,
            width: borderWidth!,
          ),
        ),
        suffixIcon: suffixIcon != null ? suffixIcon : null,
        prefixIcon: prefixIcon != null ? prefixIcon : null,
        hintText: hintText,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black45,
          fontSize: 14,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
