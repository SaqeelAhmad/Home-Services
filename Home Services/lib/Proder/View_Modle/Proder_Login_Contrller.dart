import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/Utils.dart';
import '../../../utils/routes/route_name.dart';
import '../../Users/View_Modle/Services/Session_Manager.dart';
import '../view/Dashboad/Admin_Dashboad_Screen.dart';
import '../view/Proder_Verification_Screen.dart';


class Proderlogincontrller with ChangeNotifier {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref().child('Users').child(sessioncontroller().userId.toString());






 

  bool _loading = false;

  bool get loading => _loading;

  SetLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void login(
      BuildContext context,
      String Email,
      String Password,
      ) async {
    try {
      SetLoading(true);

      await auth
          .signInWithEmailAndPassword(email: Email, password: Password)
          .then((value) async {


        SetLoading(false);


        final snap = await FirebaseDatabase.instance.ref()
            .child('Users')
            .child(FirebaseAuth.instance.currentUser!.uid).get();
       String role = snap.child('prouder')
            .value.toString();

       String  vir= snap.child('verification').value.toString();
       if(role == 'prouder'){
         if(vir == 'verification'){
           sessioncontroller().userId = value.user!.uid;
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ProderDashboadScreen()));

         }else if(vir == 'notverified'){
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ProderVerificationScreen()));
         }


       }else {
         auth.signOut();
         sessioncontroller().userId = '';
         Utils.toastMessage("You email or Password is wrong but does not login.");
       }


      }).onError((error, stackTrace) {
        Utils.toastMessage(error.toString());
        SetLoading(false);
      });
    } catch (e) {
      SetLoading(false);
      Utils.toastMessage(e.toString());
    }
  }
}
