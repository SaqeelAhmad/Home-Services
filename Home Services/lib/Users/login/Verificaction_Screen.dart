import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

import 'package:flutter/material.dart';


import 'package:provider/provider.dart';

import '../../res/Component/Round_Button.dart';
import '../../res/color.dart';
import '../../utils/Utils.dart';
import '../View_Modle/Login/Login_Mobile_Contrller.dart';
import '../View_Modle/Services/Session_Manager.dart';
import '../dashboad/Dashboad_Screen.dart';

class VerificactionScreen extends StatefulWidget {
  final String VerificactionId;
  final String MobileNumber;

  VerificactionScreen(
      {Key? key, required this.VerificactionId, required this.MobileNumber})
      : super(key: key);

  @override
  State<VerificactionScreen> createState() => _VerificactionScreenState();
}

class _VerificactionScreenState extends State<VerificactionScreen> {
  final _Auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Users');

  String VerificationCode = '';
  bool loading = false;

  final _formKey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
          child: ChangeNotifierProvider(
              create: (_) => loginmobileContrller(),
              child: Consumer<loginmobileContrller>(
                  builder: (context, provider, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: hight * .1,
                    ),
                    Text(
                      "Verification Code",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Text(
                      "Please enter the OTP Sent on You \n ${widget.MobileNumber}",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(
                      height: hight * .01,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(

                        children: [
                          SizedBox(height: hight*.1,),
                          // OtpTextField(
                          //   numberOfFields: 6,
                          //  // borderColor: Color(0xFF512DA8),
                          //   borderColor: AppColors.primaryColor,
                          //   //set to true to show as box or false to show as dash
                          //   showFieldAsBox: true,
                          //   //runs when a code is typed in
                          //   onCodeChanged: (code) {
                          //     //handle validation or checks here
                          //   },
                          //   //runs when every textfield is filled
                          //   onSubmit: (verificationCode) {
                          //     VerificationCode = verificationCode;
                          //     // showDialog(
                          //     //     context: context,
                          //     //     builder: (context){
                          //     //       return AlertDialog(
                          //     //         title: Text("Verification Code"),
                          //     //         content: Text('Code entered is $verificationCode'),
                          //     //       );
                          //     //     }
                          //     // );
                          //   }, // end onSubmit
                          // ),
                          SizedBox(height: hight* .03,),
                          RoundButton(
                              title: "Verified",
                              onPrass: () async {
                                provider.Otp(context, widget.VerificactionId,
                                    VerificationCode, widget.MobileNumber);
                              },
                              loading: provider.loading)
                        ],
                      ),
                    ),
                  ],
                );
              })),
        ),
      ),
    );
  }
}
