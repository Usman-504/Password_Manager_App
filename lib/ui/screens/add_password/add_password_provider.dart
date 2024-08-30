import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class AddPasswordProvider with ChangeNotifier {
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountEmailController = TextEditingController();
  TextEditingController accountPasswordController = TextEditingController();

  User? currentUser = FirebaseAuth.instance.currentUser;
  String _imageUrl = '';
  String get imageUrl => _imageUrl;

  XFile? _file;
  XFile? get file => _file;

  void clearFields() {
    accountNameController.clear();
    accountEmailController.clear();
    accountPasswordController.clear();
    _file = null;
    _imageUrl = '';
    notifyListeners();
  }

  String? validation() {
    if (_file == null) {
      return 'Please Upload Image';
    } else if (accountNameController.text.isEmpty) {
      return 'Please Enter Your Account Name';
    } else if (accountEmailController.text.isEmpty) {
      return 'Please Enter Your Account Email';
    } else if (accountPasswordController.text.isEmpty) {
      return 'Please Enter Your Account Password';
    }
    return null;
  }

  void addData() async {
    if (_file != null && _imageUrl.isEmpty) {
      print('Uploading image...');
      await uploadImage();
    }

    if (_imageUrl.isNotEmpty) {
      await FirebaseFirestore.instance.collection('Passwords').doc().set({
        'Account Name': accountNameController.text.trim(),
        'Account Email': accountEmailController.text.trim(),
        'Account Password': accountPasswordController.text.trim(),
        'user_id': currentUser!.uid,
        'image_url': _imageUrl,
      });
      print('Data saved successfully!');
    } else {
      print('Image URL is empty, not saving data.');
    }
  }

  void pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    _file = await imagePicker.pickImage(source: ImageSource.gallery);
    notifyListeners();
  }

  Future<void> uploadImage() async {
    if (_file != null) {
      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child('images');
      Reference imageToUpload = referenceDirImages.child(uniqueFileName);
      try {
        await imageToUpload.putFile(File(file!.path));
        _imageUrl = await imageToUpload.getDownloadURL();
        print('Image uploaded successfully, URL: $_imageUrl');
        notifyListeners();
      } catch (e) {
        print('Failed to upload image: $e');
      }
    }
  }
}
