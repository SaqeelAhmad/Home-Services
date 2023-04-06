import 'dart:async';
import 'dart:io';



import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/Utils.dart';

import '../../dashboad/Dashboad_Screen.dart';
import '../../login/Verificaction_Screen.dart';
import '../Services/Session_Manager.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storge;

class loginmobileContrller with ChangeNotifier {
  final ref = FirebaseDatabase.instance.ref('Users');
  firebase_storge.FirebaseStorage storage =
      firebase_storge.FirebaseStorage.instance;
  bool _loading = false;
  final _Auth = FirebaseAuth.instance;

  bool get loading => _loading;

  SetLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void loginmobile(BuildContext, String MobileNumber) async {
    try {
      _Auth.verifyPhoneNumber(
        phoneNumber: MobileNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
        verificationFailed: (FirebaseAuthException error) {
          Utils.toastMessage(error.toString());
          SetLoading(false);
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          SetLoading(false);

          Navigator.push(
              BuildContext,
              MaterialPageRoute(
                  builder: (context) =>
                      VerificactionScreen(VerificactionId: verificationId, MobileNumber: MobileNumber, )));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      ).then((value) {
        Utils.toastMessage('Send OTP');
      }).onError((error, stackTrace) {
        Utils.toastMessage(error.toString());
      });
    } catch (e) {
      Utils.toastMessage(e.toString());
    }
  }

  void Otp(
      BuildContext context, String VerificactionId, String VerificationCode,String MobileNumber) async {
    final crendital = PhoneAuthProvider.credential(
        verificationId: VerificactionId, smsCode: VerificationCode);
    SetLoading(true);
    try {
      await _Auth.signInWithCredential(crendital).then((value) async {
        sessioncontroller().userId = _Auth.currentUser!.uid.toString();
        sessioncontroller().userId=value.user!.uid.toString();
        print(value.user!.uid.toString());
        print(sessioncontroller().userId);
        Utils.toastMessage("Your Account is login.");
        final time = DateTime.now().microsecondsSinceEpoch;
        ref.child(sessioncontroller().userId.toString()).set({
          'name': '',
          'time' : time.toString(),
          'email': '',
          'uid': sessioncontroller().userId.toString(),
          'phone': '',
          "Profile": '',
          "Admin": "false",
          'onlineStatus': 'noDne',

        }).then((value) {
          //Navigator.pushReplacement(context , MaterialPageRoute(builder: (context)=> AddAccount(Mobile: MobileNumber,)));
        });






      }).onError((error, stackTrace) {
        Utils.toastMessage(error.toString());


      });
    } catch (error) {
      Utils.toastMessage(error.toString());
    }
  }



  Future<void> Account(
      BuildContext context, String UsersName, String Mobile, String Email) async {

    firebase_storge.Reference refStorge = firebase_storge
        .FirebaseStorage.instance
        .ref('/ ProfileImage' + sessioncontroller().userId.toString());

    firebase_storge.UploadTask uploadTask =
        refStorge.putFile(File(image!.path).absolute);
    await Future.value(uploadTask);
    final NewUrl = await refStorge.getDownloadURL();

    ref.child(sessioncontroller().userId.toString()).update({
      'name': UsersName.toString(),
      'email': Email.toString(),
      'phone': Mobile.toString(),
      "Profile": NewUrl.toString(),


    }).then((value) {
      Utils.toastMessage("Your Account is Set");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> DashboardScreen()));
    }).onError((error, stackTrace) {
      Utils.toastMessage(error.toString());
    });
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
                   Text("Upload Image",style: Theme.of(context).textTheme.subtitle1,),
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
                   TextButton(onPressed: (){
                     Navigator.pop(context);
                       _image = null;

                   }, child: Text("Cencle")),
                   TextButton(onPressed: (){
                     Navigator.pop(context);
                   }, child: Text("Ok"))
                 ],),)
                ],
              ),
            ),
          );
        });
  }


  }





