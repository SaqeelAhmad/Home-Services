import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeservices/Users/login/Mobile_Number.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../../res/Component/Input_Text_Filed.dart';
import '../../res/Component/Round_Button.dart';
import '../../res/color.dart';
import '../../utils/Utils.dart';
import '../../utils/routes/route_name.dart';
import '../View_Modle/SignUp/SignUp_Contrller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final UserContrller = TextEditingController();
  final UserFocusNode = FocusNode();
  final EmailContrller = TextEditingController();
  final EmailFocusNode = FocusNode();
  final PasswordContrller = TextEditingController();
  final PasswordFocusNode = FocusNode();
  final ConfirmContrller = TextEditingController();
  final ConfirmFocusNode = FocusNode();
  final AddressContrller= TextEditingController();
  final AddressFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  final MobileContrller = TextEditingController();
  final MobileFocusNode = FocusNode();
  String MobileNumber = '';

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    UserContrller.dispose();
    UserFocusNode.dispose();
    EmailContrller.dispose();
    PasswordContrller.dispose();
    EmailFocusNode.dispose();
    PasswordFocusNode.dispose();
    ConfirmContrller.dispose();
    ConfirmFocusNode.dispose();
    MobileContrller.dispose();
    MobileFocusNode.dispose();
    AddressFocusNode.dispose();
    AddressContrller.dispose();
  }

  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: hight * 0.4,
                        decoration: const BoxDecoration(
                          gradient: AppColors.kPrimaryGradientColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child:  Padding(
                          padding: EdgeInsets.fromLTRB(75, 80, 8, 75),
                          child: Text('Home Services',style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: AppColors.whiteColor,fontSize: 32
                          ),)
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(36.0, 120.0, 36.0, 36.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: hight * 0.7,
                          child: Card(
                            color: AppColors.whiteColor, //kSecondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 8.0,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ListView(
                                  shrinkWrap: true,
                                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Text(
                                      "Create a New Account",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.kTextColorSecondary,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      "Sign Up to create a new account.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.kTextColorSecondary,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      height: hight * .04,
                                    ),
                                    ChangeNotifierProvider(
                                      create: (_) => signupcontrlle(),
                                      child: Consumer<signupcontrlle>(
                                        builder: (context, provider, child) {
                                          return SingleChildScrollView(
                                            child: Form(
                                              key: _formKey,
                                              child: Column(
                                                children: [
                                                  Stack(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(200),
                                                        child: provider.image ==
                                                                null
                                                            ? Image.asset(
                                                                'assets/images/cleaner_2.png',
                                                                width: 120,
                                                                height: 120,
                                                                fit: BoxFit
                                                                    .cover,
                                                              )
                                                            : Image.file(
                                                                File(provider
                                                                        .image!
                                                                        .path)
                                                                    .absolute,
                                                                width: 120,
                                                                height: 120,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          provider.pickerImage(
                                                              context);
                                                        },
                                                        child: Container(
                                                          width: 40,
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .kPrimaryColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          200),
                                                              border: Border.all(
                                                                  width: 2,
                                                                  color: AppColors
                                                                      .whiteColor)),
                                                          child: Center(
                                                              child: Icon(
                                                            Icons
                                                                .add_a_photo_outlined,
                                                            color: AppColors
                                                                .whiteColor,
                                                          )),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: hight * .03,
                                                  ),
                                                  InputTextField(
                                                    Color:
                                                        AppColors.kPrimaryColor,
                                                    myController: UserContrller,
                                                    focusNode: UserFocusNode,
                                                    onFiledSubmittedValue:
                                                        (Value) {
                                                      Utils.fieldFocus(
                                                          context,
                                                          UserFocusNode,
                                                          EmailFocusNode);
                                                    },
                                                    onValidator: (val) => val
                                                                .isEmpty ==
                                                            null
                                                        ? 'Username too short.'
                                                        : null,
                                                    KeyBoardType:
                                                        TextInputType.name,
                                                    enable: true,
                                                    hint: 'Username',
                                                    obscureText: false,
                                                    PrefixIcon: 0xe3c3,
                                                  ),
                                                  InputTextField(
                                                    Color:
                                                        AppColors.kPrimaryColor,
                                                    myController:
                                                        EmailContrller,
                                                    focusNode: EmailFocusNode,
                                                    onFiledSubmittedValue:
                                                        (Value) {
                                                      Utils.fieldFocus(
                                                          context,
                                                          EmailFocusNode,
                                                          AddressFocusNode);
                                                    },
                                                    onValidator: (value) {
                                                      RegExp regex = RegExp(
                                                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.'
                                                          r'[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

                                                      if (value!.isEmpty) {
                                                        return 'Please enter email';
                                                      } else {
                                                        if (!regex
                                                            .hasMatch(value)) {
                                                          return 'Enter valid email';
                                                        } else {
                                                          return null;
                                                        }
                                                      }
                                                    },
                                                    KeyBoardType: TextInputType
                                                        .emailAddress,
                                                    enable: true,
                                                    hint: 'Email',
                                                    obscureText: false,
                                                    PrefixIcon: 0xe3c3,
                                                  ),
                                                  InputTextField(
                                                    Color:
                                                    AppColors.kPrimaryColor,
                                                    myController: AddressContrller,
                                                    focusNode: AddressFocusNode,
                                                    onFiledSubmittedValue:
                                                        (Value) {
                                                      Utils.fieldFocus(
                                                          context,
                                                          AddressFocusNode,
                                                          MobileFocusNode);
                                                    },
                                                    onValidator: (val) => val
                                                        .isEmpty ==
                                                        null
                                                        ? 'Address too short.'
                                                        : null,
                                                    KeyBoardType:
                                                    TextInputType.name,
                                                    enable: true,
                                                    hint: 'Address',
                                                    obscureText: false,
                                                    PrefixIcon: 0xe3ab,
                                                  ),
                                                  IntlPhoneField(
                                                    focusNode: MobileFocusNode,
                                                    style: TextStyle(
                                                        color: CupertinoColors
                                                            .black),
                                                    cursorColor:
                                                        AppColors.kPrimaryColor,
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText: 'Phone Number',
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black45),
                                                      ),
                                                    ),
                                                    initialCountryCode: 'PK',
                                                    onChanged: (phone) {
                                                      setState(() {
                                                        MobileNumber = phone
                                                            .completeNumber;
                                                      });
                                                    },
                                                  ),
                                                  InputTextField(
                                                      Color: AppColors
                                                          .kPrimaryColor,
                                                      myController:
                                                          PasswordContrller,
                                                      focusNode:
                                                          PasswordFocusNode,
                                                      onFiledSubmittedValue:
                                                          (Value) {
                                                        Utils.fieldFocus(
                                                            context,
                                                            PasswordFocusNode,
                                                            ConfirmFocusNode);
                                                      },
                                                      onValidator: (val) => val
                                                                  .length <
                                                              6
                                                          ? 'Password too short.'
                                                          : null,
                                                      KeyBoardType:
                                                          TextInputType.text,
                                                      enable: true,
                                                      hint: 'Password',
                                                      obscureText: _obscureText,
                                                      PrefixIcon: 0xe3b1,
                                                      Suffix: GestureDetector(
                                                        onTap: _toggle,
                                                        child: Icon(
                                                          _obscureText
                                                              ? Icons
                                                                  .visibility_off
                                                              : Icons
                                                                  .visibility,
                                                          color: AppColors
                                                              .kPrimaryColor, //kTextColorSecondary,
                                                        ),
                                                      )),
                                                  InputTextField(
                                                    Color:
                                                        AppColors.kPrimaryColor,
                                                    myController:
                                                        ConfirmContrller,
                                                    focusNode: ConfirmFocusNode,
                                                    onFiledSubmittedValue:
                                                        (Value) {},
                                                    onValidator: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'Please enter password';
                                                      } else {
                                                        if (value !=
                                                            PasswordContrller
                                                                .text
                                                                .toString()) {
                                                          return 'Enter valid password';
                                                        } else {
                                                          return null;
                                                        }
                                                      }
                                                    },
                                                    KeyBoardType:
                                                        TextInputType.text,
                                                    enable: true,
                                                    hint: 'Confirm Password',
                                                    obscureText: _obscureText,
                                                    PrefixIcon: 0xe3b1,
                                                  ),
                                                  SizedBox(
                                                    height: hight * .02,
                                                  ),
                                                  RoundButton(
                                                    title: "Signup",
                                                    onPrass: () {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        provider.signup(
                                                            context,
                                                            UserContrller.text
                                                                .toString(),
                                                            EmailContrller.text
                                                                .toString(),
                                                            PasswordContrller
                                                                .text
                                                                .toString(),
                                                            ConfirmContrller
                                                                .text
                                                                .toString(),
                                                            MobileNumber
                                                                .toString(),
                                                            "",
                                                           "true" ,
                                                            "",
                                                            "",
                                                          AddressContrller.text.toString()
                                                        );
                                                      }
                                                    },
                                                    loading: provider.loading,
                                                    color:
                                                        AppColors.kPrimaryColor,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: hight * .01),
                  NovccountText(
                    a: "Already have an account?",
                    b: " Sign In",
                    press: () {
                      // Navigator.of(context).pushNamedAndRemoveUntil(
                      //     SignInScreen.routeName, (route) => false);
                      Navigator.pushNamed(context, RouteName.loginView);
                    },
                    TextColor: Colors.black,
                  ),
                  SizedBox(height: hight * .04),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



class NovccountText extends StatelessWidget {
  String a, b;
  VoidCallback press;
  final TextColor;

  final Textcolors;


  NovccountText(
      {Key? key,
      required this.a,
      required this.b,
      required this.press,
      this.TextColor = AppColors.whiteColor,
      this.Textcolors = AppColors.kPrimaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(),
        ),
        Text(
          a,
          style:
              Theme.of(context).textTheme.subtitle1!.copyWith(color: TextColor),
        ),
        TextButton(
          onPressed: press,
          child: Text(
            b,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Textcolors),
          ),
        ),
        Expanded(child: Container())
      ],
    );
  }
}
