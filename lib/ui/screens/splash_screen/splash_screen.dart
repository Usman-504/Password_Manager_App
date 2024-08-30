import 'dart:async';
import 'package:flutter/material.dart';
import 'package:password_manager/core/const_colors.dart';
import '../../../generated/assets.dart';
import '../auth_check/auth_check.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  @override
  void initState(){
    super.initState();
    Timer(const Duration(seconds: 3), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthCheck()));
    });
  }


  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(
        children: [
          Container(
            height: heightX * 1,
            color: primaryColor,
            child: Center(child: Image.asset(Assets.splashScreenIcon)),
          ),

        ],
      ),
    );
  }
}