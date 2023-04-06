import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeservices/Users/login/Mobile_Number.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/Utils.dart';
import '../../../utils/routes/route_name.dart';
import '../../Users/View_Modle/Services/Session_Manager.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storge;

import '../view/Proder_Login_screen.dart';

class Prodersignupcontrlle with ChangeNotifier {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref().child("Users");
  bool _loading = false;

  bool get loading => _loading;

  SetLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void signup(
      BuildContext context,
      String Username,
      String Email,
      String Password,
      String ConifirmPassword,
      String Mobile,
      String gender,
      String nic,
      String Address,

      ) async {
    try { if(image != null){
      SetLoading(true);
      await auth
          .createUserWithEmailAndPassword(email: Email, password: Password)
          .then((value) async {
        sessioncontroller().userId = value.user!.uid.toString();
        firebase_storge.Reference refStorge = firebase_storge
            .FirebaseStorage.instance
            .ref('/ ProfileImage' + sessioncontroller().userId.toString());

        firebase_storge.UploadTask uploadTask =
            refStorge.putFile(File(image!.path).absolute);
        await Future.value(uploadTask);
        final NewUrl = await refStorge.getDownloadURL();
        ref.child(value.user!.uid.toString()).set({
          'time': DateTime.now().microsecondsSinceEpoch,
          'uid': value.user!.uid.toString(),
          'email': Email,
          'name': Username,
          'phone': Mobile,
          'onlineStatus': 'noDne',
          'profile': NewUrl.toString(),
          'prouder': 'prouder',
          'address': Address,
          'verification': "notverified",
          'nic': nic,
          'gender': gender,
        }).then((value) {
          Utils.toastMessage("Your Account is Register".toString());

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => ProderLoginScreen()));
          SetLoading(false);
        }).onError((error, stackTrace) {
          auth.currentUser!.delete();
          Utils.toastMessage(error.toString());
          SetLoading(false);
        });
        SetLoading(true);
      }).onError((error, stackTrace) {

        Utils.toastMessage(error.toString());
        SetLoading(false);
      });}else {
      Utils.toastMessage('Image Is Null');
    }
    } catch (e) {
      SetLoading(false);
      Utils.toastMessage(e.toString());
    }
  }

  final Picker = ImagePicker();
  File? _image;

  File? get image => _image;

  Future PickerGalleryImage(BuildContext context) async {
    final pickerFile =
        await Picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickerFile != null) {
      _image = File(pickerFile.path);
      notifyListeners();
    }
  }

  Future PickerCameraImage(BuildContext context) async {
    final pickerFile =
        await Picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickerFile != null) {
      _image = File(pickerFile.path);
      notifyListeners();
    }
  }

  void pickerImage(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Upload Image",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  ListTile(
                    leading: Icon(Icons.camera_alt_outlined),
                    title: const Text('Camera'),
                    onTap: () {
                      PickerCameraImage(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.image),
                    title: const Text('Gallery'),
                    onTap: () {
                      PickerGalleryImage(context);
                    },
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _image = null;
                            },
                            child: Text("Cancle",style: TextStyle(color: Colors.black),)),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Ok",style: TextStyle(color: Colors.black)))
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
