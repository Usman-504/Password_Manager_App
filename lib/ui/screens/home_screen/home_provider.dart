import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../login_screen/login_screen.dart';

class HomeProvider with ChangeNotifier{

  void logout(BuildContext context){

    FirebaseAuth.instance.signOut().then((_){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> const LoginScreen()), (Route<dynamic> route) => false,);
    });
    notifyListeners();
  }

  void deletePassword (String docId) async {

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('Passwords')
        .doc(docId)
        .get();
    if (doc.exists) {
      String path = doc.get('image_path');

      if(path.isNotEmpty){
        await FirebaseStorage.instance.ref(path).delete();
      }
      await FirebaseFirestore.instance
          .collection('Passwords')
          .doc(docId)
          .delete();
    }

  }

}