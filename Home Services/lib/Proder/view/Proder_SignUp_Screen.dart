import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../../Users/View_Modle/SignUp/SignUp_Contrller.dart';
import '../../Users/signup/sign_up_screen.dart';
import '../../res/Component/Input_Text_Filed.dart';
import '../../res/Component/Round_Button.dart';
import '../../res/color.dart';
import '../../utils/Utils.dart';
import '../../utils/routes/route_name.dart';
import '../View_Modle/Proder_SignUp_Cntrller.dart';
import 'Proder_Login_screen.dart';

enum Gender { Male, Female }

class ProuderSignupScreen extends StatefulWidget {
  const ProuderSignupScreen({Key? key}) : super(key: key);

  @override
  State<ProuderSignupScreen> createState() => _ProuderSignupScreenState();
}

class _ProuderSignupScreenState extends State<ProuderSignupScreen> {
  final UserContrller = TextEditingController();
  final UserFocusNode = FocusNode();
  final EmailContrller = TextEditingController();
  final EmailFocusNode = FocusNode();
  final PasswordContrller = TextEditingController();
  final PasswordFocusNode = FocusNode();
  final ConfirmContrller = TextEditingController();
  final ConfirmFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  final MobileContrller = TextEditingController();
  final MobileFocusNode = FocusNode();
  final nicContrller = TextEditingController();
  final nicFocusNode = FocusNode();
  final AddressContrller = TextEditingController();
  final AddressFocusNode = FocusNode();

  String MobileNumber = '';
  Gender _selectedGender = Gender.Male;
  String? gender = 'Male';

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
    nicContrller.dispose();
    nicFocusNode.dispose();
    AddressContrller.dispose();
    AddressFocusNode.dispose();
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
                        gradient: AppColors.kPrimaryGradientColor1,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(75, 60, 8, 75),
                          child: Text(
                            'Home Services Provider',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                    color: AppColors.whiteColor, fontSize: 32),
                          )),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(36.0, 110.0, 36.0, 36.0),
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
                                    create: (_) => Prodersignupcontrlle(),
                                    child: Consumer<Prodersignupcontrlle>(
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
                                                          BorderRadius.circular(
                                                              200),
                                                      child: provider.image ==
                                                              null
                                                          ? Image.asset(
                                                              'assets/images/cleaner_2.png',
                                                              width: 120,
                                                              height: 120,
                                                              fit: BoxFit.cover,
                                                            )
                                                          : Image.file(
                                                              File(provider
                                                                      .image!
                                                                      .path)
                                                                  .absolute,
                                                              width: 120,
                                                              height: 120,
                                                              fit: BoxFit.cover,
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
                                                                .kPrimaryColor1,
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
                                                      AppColors.kPrimaryColor1,
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
                                                      AppColors.kPrimaryColor1,
                                                  myController: EmailContrller,
                                                  focusNode: EmailFocusNode,
                                                  onFiledSubmittedValue:
                                                      (Value) {
                                                    Utils.fieldFocus(
                                                        context,
                                                        EmailFocusNode,
                                                        nicFocusNode);
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
                                                      AppColors.kPrimaryColor1,
                                                  myController: nicContrller,
                                                  focusNode: nicFocusNode,
                                                  onFiledSubmittedValue:
                                                      (Value) {
                                                    Utils.fieldFocus(
                                                        context,
                                                        nicFocusNode,
                                                        AddressFocusNode);
                                                  },
                                                  onValidator: (val) =>
                                                      val.length <= 12
                                                          ? 'Nic too short.'
                                                          : null,
                                                  KeyBoardType:
                                                      TextInputType.number,
                                                  enable: true,
                                                  hint: 'nic',
                                                  obscureText: false,
                                                  PrefixIcon: 0xe13f,
                                                ),
                                                InputTextField(
                                                  Color:
                                                      AppColors.kPrimaryColor1,
                                                  myController:
                                                      AddressContrller,
                                                  focusNode: AddressFocusNode,
                                                  onFiledSubmittedValue:
                                                      (Value) {
                                                    Utils.fieldFocus(
                                                        context,
                                                        AddressFocusNode,
                                                        MobileFocusNode);
                                                  },
                                                  onValidator: (val) =>
                                                      val.isEmpty == null
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
                                                      AppColors.kPrimaryColor1,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Phone Number',
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Colors.black45),
                                                    ),
                                                  ),
                                                  initialCountryCode: 'PK',
                                                  onChanged: (phone) {
                                                    setState(() {
                                                      MobileNumber =
                                                          phone.completeNumber;
                                                    });
                                                  },
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          "Gender",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15,
                                                            color:
                                                                Colors.black54,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Row(
                                                                children: [
                                                                  Radio(
                                                                    activeColor:
                                                                        AppColors
                                                                            .kPrimaryColor1,
                                                                    value: Gender
                                                                        .Male,
                                                                    groupValue:
                                                                        _selectedGender,
                                                                    onChanged:
                                                                        (Gender?
                                                                            value) {
                                                                      setState(
                                                                          () {
                                                                        _selectedGender =
                                                                            value!;
                                                                        gender = value
                                                                            .name
                                                                            .toString();
                                                                        print(
                                                                            gender);
                                                                      });
                                                                    },
                                                                  ),
                                                                  const Text(
                                                                      "Male")
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Row(
                                                                children: [
                                                                  Radio(
                                                                    activeColor:
                                                                        AppColors
                                                                            .kPrimaryColor1,
                                                                    value: Gender
                                                                        .Female,
                                                                    groupValue:
                                                                        _selectedGender,
                                                                    onChanged:
                                                                        (Gender?
                                                                            value) {
                                                                      setState(
                                                                          () {
                                                                        _selectedGender =
                                                                            value!;
                                                                        gender = value
                                                                            .name
                                                                            .toString();
                                                                        print(
                                                                            gender);
                                                                      });
                                                                    },
                                                                  ),
                                                                  const Text(
                                                                      "Female")
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                InputTextField(
                                                    Color: AppColors
                                                        .kPrimaryColor1,
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
                                                            : Icons.visibility,
                                                        color: AppColors
                                                            .kPrimaryColor1, //kTextColorSecondary,
                                                      ),
                                                    )),
                                                InputTextField(
                                                  Color:
                                                      AppColors.kPrimaryColor1,
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
                                                          PasswordContrller.text
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
                                                        PasswordContrller.text
                                                            .toString(),
                                                        ConfirmContrller.text
                                                            .toString(),
                                                        MobileNumber.toString(),
                                                        gender.toString(),
                                                        nicContrller.text
                                                            .toString(),
                                                        AddressContrller.text
                                                            .toString(),
                                                      );
                                                    }
                                                  },
                                                  loading: provider.loading,
                                                  color:
                                                      AppColors.kPrimaryColor1,
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
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProderLoginScreen()));
                  },
                  TextColor: Colors.black,
                  Textcolors: AppColors.kPrimaryColor1,
                ),
                SizedBox(height: hight * .04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
