


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/Utils.dart';
import '../dashboad/Dashboad_Screen.dart';

class OderServices  with ChangeNotifier{



  bool _loading = false;

  bool get loading => _loading;

  SetLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final ref = FirebaseDatabase.instance.ref().child('Oder');

   void Oder (BuildContext context, String time, String User_Uid, String Price, String Oder_Uid,
       String Complete,String Address, int Rate ,String Image , String Oder_Name,String User_Name,
       String Services_Name, String Oder_Address,
       ){
    SetLoading(true);
    final id = DateTime.now().microsecondsSinceEpoch;
    ref .child(id.toString()).set({
      'time': time.toString(),
      'id': id.toString(),
      'User_Uid': User_Uid,
      'User_Name': User_Name,
      'Price': Price,
      'Oder_Uid': Oder_Uid,
      'Oder_Name': Oder_Name,
      'Oder_Address': Oder_Address,
      'Rate': Rate,
      'Address': Address,
      "Complete": Complete,
      "Image": Image,
      'Services_Name': Services_Name
    }).then((value) {
Utils.toastMessage("You can Oder Services.");
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> DashboardScreen()));
    }).onError((error, stackTrace) {
      final auth = FirebaseAuth.instance.currentUser!.delete();
Utils.toastMessage("Data is Null".toString());
    });




  }





}