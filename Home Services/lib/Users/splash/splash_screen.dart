import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:homeservices/Users/View_Modle/Services/Session_Manager.dart';

import '../../Not_Login.dart';
import '../../Proder/view/Dashboad/Admin_Dashboad_Screen.dart';
import '../../Proder/view/Proder_Verification_Screen.dart';
import '../../res/color.dart';
import '../../res/fonts.dart';
import '../View_Modle/Services/Splash_Services.dart';
import '../dashboad/Dashboad_Screen.dart';
import '../login/Verificaction_Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String? role ;
  String? vir ;

  @override
   initState() {
    // TODO: implement initState
    super.initState();
     loadData();
    _checkRole();

  }






  final auth = FirebaseAuth.instance.currentUser!.uid;

  Future<void> _checkRole() async {
    if (auth != null) {
      final snap = await FirebaseDatabase.instance.ref()
          .child('Users')
          .child(FirebaseAuth.instance.currentUser!.uid).get();

setState(() {
  role = snap
      .child('prouder')
      .value.toString();


});
setState(() {
  vir= snap.child('verification').value.toString();
});



      if (role == 'users') {
        if(vir == "verification"){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => DashboardScreen()));}

      } else if (role == 'prouder') {
        if (vir == "verification"){
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => ProderDashboadScreen()));
        }else if(vir == "verification")
        {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ProderVerificationScreen()));
        }

      }


      void navigateNext(Widget route)  {
       Timer( Duration(seconds: 5
          //milliseconds: 500
        ), () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => route));
        });
      }
    } else {
      Timer(
          const Duration(seconds: 5),
              () =>
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const NotLogin())));
    }
  }





  


  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {

    })
        .onError((error, stackTrace) {
      print("Error : " + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }
  loadData(){
    getUserCurrentLocation().then((value) async {
      print("My current location.");

      print(value.latitude);
      print(  value.longitude);




    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
          child:      Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(width: 200,
                    child: Image(image: AssetImage('assets/images/splash_3.png'))),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                      child: Text(
                        'Home Services',
                        style: TextStyle(
                            fontFamily: AppFonts.sfProDisplayBold,
                            fontSize: 32,
                            fontWeight: FontWeight.w700),
                      )),
                )
              ],
            )






      ),
    );
  }
}
