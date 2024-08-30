import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginProvider with ChangeNotifier {
  TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

String get emailText => _emailController.text.trim();
String get passwordText => _passwordController.text.trim();

void email (String text){
  _emailController.text = text;
  notifyListeners();
  }

void password (String text){
  _passwordController.text = text;
  notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? validation  (){
    if (emailController.text.isEmpty) {
      return 'Please Enter Your Email';
    }
    else if (passwordController.text.isEmpty) {
      return 'Please Enter Your Password';
    }
    return null;
  }

  Future<String?> login() async {
    try{
      _isLoading = true;
      notifyListeners();
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim()).then((_){
        _isLoading = false;
        notifyListeners();
      }
      );
      return null;
    } on FirebaseException catch (e) {
      _isLoading = false;
      notifyListeners();
      if (e.code == 'invalid-email') {

        return 'The email format is invalid.';
      }
      else if (e.code == 'invalid-credential' || e.code == 'user-not-found' || e.code == 'wrong-password') {

        return 'Email Or Password Is Incorrect.';
      }

      else {

        return'An error occurred';


      }
    }
  }
}