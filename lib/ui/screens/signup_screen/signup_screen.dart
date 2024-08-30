import 'package:flutter/material.dart';
import 'package:password_manager/ui/components/custom_button.dart';
import 'package:password_manager/ui/screens/home_screen/home_screen.dart';
import 'package:password_manager/ui/screens/signup_screen/signup_provider.dart';
import 'package:provider/provider.dart';
import '../../../core/const_colors.dart';
import '../../../generated/assets.dart';
import '../../components/custom_text_field.dart';
import '../login_screen/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
    // final signupProvider = Provider.of<SignupProvider>(context);
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Consumer<SignupProvider>(
        builder: (context, vm, child) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.signupIcon,
                    color: primaryColor,
                    height: heightX * 0.2,
                  ),
                  SizedBox(
                    height: heightX * 0.03,
                  ),
                  Text(
                    'Welcome! Signup now',
                    style: TextStyle(
                        fontSize: heightX * 0.04,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                  ),
                  Text(
                    'Enter your information below',
                    style: TextStyle(
                        fontSize: heightX * 0.02,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                  ),
                  SizedBox(
                    height: heightX * 0.02,
                  ),
                  CustomTextField(
                    keyboardType: TextInputType.name,
                      controller: vm.nameController,
                      hintText: 'Enter Name',
                      maxWidth: widthX * 0.9,
                      maxHeight: heightX * 0.08),
                  CustomTextField(
                    keyboardType: TextInputType.emailAddress,
                      controller: vm.emailController,
                      hintText: 'Enter Email',
                      maxWidth: widthX * 0.9,
                      maxHeight: heightX * 0.08),
                  CustomTextField(
                    keyboardType: TextInputType.number,
                      controller: vm.phoneNoController,
                      hintText: 'Enter Phone No',
                      maxWidth: widthX * 0.9,
                      maxHeight: heightX * 0.08),
                  CustomTextField(
                    keyboardType: TextInputType.text,
                      controller: vm.passwordController,
                      hintText: 'Enter Password',
                      maxWidth: widthX * 0.9,
                      maxHeight: heightX * 0.08),
                  SizedBox(
                    height: heightX * 0.02,
                  ),
                  CustomButton(
                      height: heightX * 0.08,
                      width: widthX * 0.9,
                      text: 'Sign Up',
                      borderRadius: 9,
                      onPress: () async {
                        try {
                          String? validation = vm.validation();
                          if(validation != null){
                            showSnackBar(validation);
                          }

                          else {
                            String? error = await vm.signUp();
                            if (error == null) {
                              showSnackBar('Account Created Successfully');
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                         LoginScreen()));
                            }
                            else {
                              showSnackBar(error);
                            }
                          }
                        } catch (e) {
                          showSnackBar(
                              'An unexpected error occurred. Please try again.');

                          //debugPrint(e as String?) ;
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
                        'Already have an account?',
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
                                  builder: (context) => const LoginScreen()));
                        },
                        child: Text(
                          'Login Now',
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
