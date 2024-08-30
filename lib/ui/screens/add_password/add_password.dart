import 'dart:io';
import 'package:flutter/material.dart';
import 'package:password_manager/ui/components/custom_text_field.dart';
import 'package:password_manager/ui/components/snackBar.dart';
import 'package:password_manager/ui/screens/add_password/add_password_provider.dart';
import 'package:provider/provider.dart';
import '../../../core/const_colors.dart';
import '../../components/custom_button.dart';
import '../home_screen/home_screen.dart';

class AddPassword extends StatefulWidget {
  const AddPassword({super.key});

  @override
  State<AddPassword> createState() => _AddPasswordState();
}

class _AddPasswordState extends State<AddPassword> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() => context.read<AddPasswordProvider>().clearFields());
  }

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    print('Rebuild');
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text(
          ' Add Password',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<AddPasswordProvider>(
        builder: (context, vm, child) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      vm.pickImage();
                    },
                    child: Container(
                      height: heightX * 0.3,
                      width: widthX * 0.9,
                      decoration: BoxDecoration(
                        image: vm.file != null
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(File(vm.file!.path)))
                            : null,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 2,
                          color: primaryColor,
                        ),
                      ),
                      child: Center(
                        child: vm.file == null
                            ? const Text(
                                'Upload Image',
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              )
                            : null,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: heightX * 0.03,
                  ),
                  CustomTextField(
                      controller: vm.accountNameController,
                      hintText: 'Account Name',
                      maxWidth: widthX * 0.9,
                      maxHeight: heightX * 0.08),
                  CustomTextField(
                      controller: vm.accountEmailController,
                      hintText: 'Account Email',
                      maxWidth: widthX * 0.9,
                      maxHeight: heightX * 0.08),
                  CustomTextField(
                      controller: vm.accountPasswordController,
                      hintText: 'Account Password',
                      maxWidth: widthX * 0.9,
                      maxHeight: heightX * 0.08),
                  CustomButton(
                      height: heightX * 0.08,
                      width: widthX * 0.9,
                      text: 'Add',
                      borderRadius: 9,
                      onPress: () async {
                        try {
                          String? validation = vm.validation();
                          if (validation != null) {
                            BottomSnackbar().showSnackBar(context, validation);
                          } else {
                            vm.addData();
                            BottomSnackbar()
                                .showSnackBar(context, 'Entry Adding...');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          }
                        } catch (e) {
                          print(e);
                        }
                      }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
