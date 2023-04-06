import 'package:flutter/material.dart';

import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:provider/provider.dart';

import '../../res/Component/Round_Button.dart';
import '../../utils/Utils.dart';
import '../../utils/routes/route_name.dart';
import '../View_Modle/Login/Login_Mobile_Contrller.dart';
import 'Verificaction_Screen.dart';

class MobileNumber extends StatefulWidget {
  const MobileNumber({Key? key}) : super(key: key);

  @override
  State<MobileNumber> createState() => _MobileNumberState();
}

class _MobileNumberState extends State<MobileNumber> {
  String MobileNumber = '';

  bool loading = false;

  final _Auth = FirebaseAuth.instance;

  final MobileContrller = TextEditingController();
  final MobileFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


    final hight = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: hight * .01,
                ),
                Text(
                  "Welcome to Pocked Earring",
                  textAlign:  TextAlign.center,
                  style: Theme.of(context).textTheme.headline3,
                ),
                Text(
                  "Enter your Phone Number \n to connect to your account.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  height: hight * .01,
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: hight * .1),
                    child: Column(
                      children: [

                        SizedBox(
                          height: hight * .01,
                        ),
                    Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
                          child: IntlPhoneField(
                            // style: TextStyle(color: primary),
                            // cursorColor: primary,
                            decoration: const InputDecoration(
                              labelText: 'Phone Number',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black45),
                              ),
                            ),
                            initialCountryCode: 'PK',
                            onChanged: (phone) {
                              setState(() {
                                MobileNumber = phone.completeNumber;
                              });
                            },
                          ),
                        ),

                        SizedBox(
                          height: hight * .03,
                        ),
                        ChangeNotifierProvider(
                          create: (_) => loginmobileContrller(),
                          child: Consumer<loginmobileContrller>(
                            builder: (context, provider, child) {
                              return RoundButton(
                                title: "Login",
                                onPrass: () {
                                  if (_formKey.currentState!.validate()) {
                                    provider.loginmobile(context,MobileNumber);
                                  }
                                },
                                loading: provider.loading,
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: hight * .01,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RouteName.loginView);
                          },
                          child: Text.rich(TextSpan(
                              text: "Login with admin?",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(fontSize: 14),
                              children: [
                                TextSpan(
                                  text: 'admin?',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(
                                      fontSize: 14,
                                      decoration: TextDecoration.underline),
                                )
                              ])),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );


    // return Scaffold(
    //   body: Padding(
    //     padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
    //     child: IntlPhoneField(
    //       // style: TextStyle(color: primary),
    //       // cursorColor: primary,
    //       decoration: const InputDecoration(
    //         labelText: 'Phone Number',
    //         border: OutlineInputBorder(
    //           borderSide: BorderSide(color: Colors.black45),
    //         ),
    //       ),
    //       initialCountryCode: 'PK',
    //       onChanged: (phone) {
    //         setState(() {
    //           MobileNumber = phone.completeNumber;
    //         });
    //       },
    //     ),
    //   ),
    // );
  }


}
