import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../../utils/Utils.dart';
import '../../../utils/routes/route_name.dart';


class forgotcontrller with ChangeNotifier {
  final auth = FirebaseAuth.instance;

  bool _loading = false;

  bool get loading => _loading;

  SetLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void forgot(
    BuildContext context,
    String Email,
  ) async {
    try {
      SetLoading(true);

      await auth.sendPasswordResetEmail(email: Email).then((value) {
        SetLoading(false);
        Navigator.pushNamed(context, RouteName.loginView);
        Utils.toastMessage("Pleas check your email to recover your password.");
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
