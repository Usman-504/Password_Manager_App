import 'package:flutter/material.dart';
import 'package:password_manager/core/const_colors.dart';
import 'package:password_manager/ui/screens/login_screen/login_provider.dart';
import 'package:provider/provider.dart';

import '../../../generated/assets.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text_field.dart';
import '../home_screen/home_screen.dart';
import '../signup_screen/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
        // action: SnackBarAction(
        //     label: 'Cancel', textColor: Colors.white, onPressed: () {}),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    print('Rebuild');
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Consumer<LoginProvider>(
        builder: (context, vm, child) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(Assets.loginIcon, color: primaryColor, height: heightX * 0.3,),
                  Text(
                    'Let\'s get you Login!',
                    style: TextStyle(
                        fontSize: heightX * 0.04, fontWeight: FontWeight.bold, color: primaryColor),
                  ),
                  Text(
                    'Enter your information below',
                    style: TextStyle(
                        fontSize: heightX * 0.02, fontWeight: FontWeight.bold, color:  primaryColor),
                  ),
                  SizedBox(
                    height: heightX * 0.02,
                  ),
                  CustomTextField(
                    controller: vm.emailController,
                      hintText: 'Enter Email',
                      maxWidth: widthX * 0.9,
                      maxHeight: heightX * 0.08),
                  CustomTextField(
                    controller: vm.passwordController,
                      hintText: 'Enter Password',
                      maxWidth: widthX * 0.9,
                      maxHeight: heightX * 0.08),
                  SizedBox(
                    height: heightX * 0.04,
                  ),
                  CustomButton(
                      height: heightX * 0.08,
                      width: widthX * 0.9,
                      text: 'Login',
                      borderRadius: 9,
                      loading: vm.isLoading,
                      onPress: () async{
                        try {
                          String? validation = loginProvider.validation();
                          if (validation != null){
                            showSnackBar(validation);
                          }
                          else {
                            String? error = await loginProvider.login();
                            if(error == null){
                              showSnackBar('Login Successfully');
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                       HomeScreen()));
                            }
                            else {
                              showSnackBar(error);
                            }
                          }
                        }
                            catch (e){
                              showSnackBar(
                                  'An unexpected error occurred. Please try again.');
                              debugPrint(e as String?) ;
                            }

                      }
                      ),
                  SizedBox(
                    height: heightX * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          fontSize: heightX * 0.02,
                        ),
                      ),
                      SizedBox(
                        width: widthX * 0.01,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignupScreen()));
                        },
                        child: Text(
                          'SignUp Now',
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: heightX * 0.02,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
