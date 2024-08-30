import 'package:flutter/material.dart';
import 'package:password_manager/core/const_colors.dart';

class CustomTextField extends StatelessWidget {

  final String hintText;
  final double maxWidth;
  final double maxHeight;
  final Widget? prefix;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    required this.hintText,
    required this.maxWidth,
    required this.maxHeight,
    this.controller,
    this.prefix,
    this.keyboardType,
    this.onChanged,
    super.key,
  });



  @override
  Widget build(BuildContext context) {

    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(left: widthX * 0.04, right: widthX * 0.04, bottom: widthX * 0.04),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        keyboardType: keyboardType,
        style:TextStyle(fontSize: heightX * 0.02),
        decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefix,
            constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
            hintStyle: TextStyle(color: Colors.grey, fontSize: heightX * 0.02),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: primaryColor, width: 2)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: primaryColor, width: 2))),
      ),
    );
  }
}