import 'package:flutter/material.dart';
import 'package:password_manager/core/const_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.height,
    required this.width,
    required this.text,
    required this.borderRadius,
    required this.onPress,
    this.loading =false,

  });

  final double height;
  final double width;
  final String text;
  final double borderRadius;
  final VoidCallback onPress;
  final bool? loading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child:  Center(
            child:
            loading!  ?const  CircularProgressIndicator(
              color: Colors.white,
            ) :
            Text(text, style: TextStyle(color: Colors.white, fontSize: height * 0.4, fontWeight: FontWeight.bold)),

          )),
    );
  }
}