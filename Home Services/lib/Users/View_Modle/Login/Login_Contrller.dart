import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/Utils.dart';
import '../../../utils/routes/route_name.dart';
import '../../dashboad/Dashboad_Screen.dart';
import '../Services/Session_Manager.dart';

class logincontrller with ChangeNotifier {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance
      .ref()
      .child('Users')
      .child(sessioncontroller().userId.toString());

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
        //Navigator.pushNamed(context, RouteName.DashboardView);
        final snap = await FirebaseDatabase.instance
            .ref()
            .child('Users')
            .child(FirebaseAuth.instance.currentUser!.uid)
            .get();
        String? role;
        role = snap.child('prouder').value.toString();

        if (role == "prouder") {
          auth.signOut();
          sessioncontroller().userId = '';
          Utils.toastMessage(
              'You email or Password is wrong but does not login.');
        } else if (role == 'users') {
          sessioncontroller().userId = value.user!.uid.toString();
          print(value.user!.uid.toString());
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => DashboardScreen()));
          Utils.toastMessage("You Accoiunt is Login.");
        }

        SetLoading(false);
      }).onError((error, stackTrace) {

        Utils.toastMessage(
            "You email or Password is wrong but does not login.".toString());
        SetLoading(false);
      });
    } catch (e) {
      SetLoading(false);
      Utils.toastMessage(e.toString());
    }
  }
}
