



import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeservices/Proder/view/Dashboad/Admin_Dashboad_Screen.dart';
import 'package:homeservices/utils/Utils.dart';
import 'package:image_picker/image_picker.dart';

import '../../Users/View_Modle/Services/Session_Manager.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storge;

class addServicesContrller with ChangeNotifier {



  bool _loading = false;

  bool get loading => _loading;

  SetLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void addServices (
      BuildContext context,
      String typeServices, String nameServices,
      String name,String email,String profile,String uid,
       String Working_Start ,
       String Working_Houer,
      String price,
      String Address,
      ) async {
    SetLoading(true);
    final ref = await  FirebaseDatabase.instance.ref().child('Services');

    final id = DateTime.now().microsecondsSinceEpoch.toString();
    firebase_storge.Reference refStorge = firebase_storge
        .FirebaseStorage.instance
        .ref('/ ImageServices' + id);
if( image != null){
    firebase_storge.UploadTask uploadTask =
    refStorge.putFile(File(image!.path).absolute);
    await Future.value(uploadTask);
    final NewUrl = await refStorge.getDownloadURL();


    ref.child(id).set({
      'User_Name': name,
      'User_Email': email,
      'User_Uid': uid,
      'User_Profile': profile,
      'User_Address': Address,
      'Type_Services': typeServices,
      'Name_Services': nameServices,
      'Image_Serviees': NewUrl.toString(),

      'Working_Start':Working_Start ,
      'Working_Houer':Working_Houer,
      'price': price,
      'time': id.toString(),
      'rate': 0,
      'review': 0,


    }).then((value) {
      SetLoading(false);
      Utils.toastMessage('Your Services is add.');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ProderDashboadScreen()));
    }).onError((error, stackTrace) {
      SetLoading(false);
      Utils.toastMessage(error.toString());
    });
  }else{
  SetLoading(false);
  Utils.toastMessage("Image is null.");

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
                            child: Text("Cencle")),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Ok"))
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