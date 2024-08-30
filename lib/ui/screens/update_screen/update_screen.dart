import 'dart:io';
import 'package:flutter/material.dart';
import 'package:password_manager/ui/screens/update_screen/update_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/const_colors.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text_field.dart';

class UpdateScreen extends StatefulWidget {
  String? accountName;
  String? accountPassword;
  String? docId;
  String? imageUrl;

  UpdateScreen(
      {required this.accountName,
      required this.docId,
      required this.accountPassword,
      required this.imageUrl,
      super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  late TextEditingController _accountNameController;
  late TextEditingController _accountPasswordController;

  @override
  void initState() {
    super.initState();
    _accountNameController = TextEditingController(text: widget.accountName);
    _accountPasswordController =
        TextEditingController(text: widget.accountPassword);
  }

  @override
  void dispose() {
    _accountNameController.dispose();
    _accountPasswordController.dispose();
    super.dispose();
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
        title: Text(
          widget.accountName.toString(),
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<UpdateProvider>(
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
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: vm.file != null
                              ? FileImage(File(vm.file!.path))
                              : NetworkImage(widget.imageUrl!),
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 2,
                          color: primaryColor,
                        ),
                      ),
                      child: Center(
                        child: vm.file == null && widget.imageUrl == null
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
                      controller: _accountNameController,
                      // vm.accountNameController..text = '${widget.accountName.toString()}',
                      hintText: 'Account Name',
                      maxWidth: widthX * 0.9,
                      maxHeight: heightX * 0.08),
                  CustomTextField(
                      controller: _accountPasswordController,
                      hintText: 'Account Password',
                      maxWidth: widthX * 0.9,
                      maxHeight: heightX * 0.08),
                  CustomButton(
                      height: heightX * 0.08,
                      width: widthX * 0.9,
                      text: 'Update',
                      borderRadius: 9,
                      onPress: () {
                        vm.updateData(widget.docId!, _accountNameController,
                            _accountPasswordController);
                        Navigator.pop(context);
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
