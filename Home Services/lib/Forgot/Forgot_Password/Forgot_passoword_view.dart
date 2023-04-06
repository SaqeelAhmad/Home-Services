import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../res/Component/Input_Text_Filed.dart';
import '../../res/Component/Round_Button.dart';
import '../../res/color.dart';
import '../Forgot_Contrller.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final EmailContrller = TextEditingController();
  final EmailFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: hight * 0.4,
                  decoration: const BoxDecoration(
                    // gradient: ,
                    gradient: AppColors.kPrimaryGradientColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
                    child: Container(
                      alignment: Alignment.center,
                      // use aligment
                      margin: const EdgeInsets.only(right: 8),
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18.0),
                        child: const Image(
                          width: 96,
                          height: 96,
                          fit: BoxFit.contain,
                          image: AssetImage(
                            'assets/images/logo.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(36.0, 250.0, 36.0, 36.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Card(
                      color: AppColors.whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 8.0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Forgot Password",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(fontSize: 32),
                                ),
                                Text(
                                  "Enter your email address \n to recover your password.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      //color: kTextColorSecondary,
                                      // fontSize: getProportionateScreenWidth(14),
                                      ),
                                ),
                                SizedBox(
                                  //height: getProportionateScreenHeight(4)),

                                  child: Form(
                                    key: _formKey,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          InputTextField(
                                            Color: AppColors.kPrimaryColor,
                                            myController: EmailContrller,
                                            focusNode: EmailFocusNode,
                                            onFiledSubmittedValue: (Value) {
                                              // Utils.fieldFocus(context ,  EmailFocusNode , PasswordFocusNode );
                                            },
                                            onValidator: (value) {
                                              RegExp regex = RegExp(
                                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.'
                                                  r'[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

                                              if (value!.isEmpty) {
                                                return 'Please enter email';
                                              } else {
                                                if (!regex.hasMatch(value)) {
                                                  return 'Enter valid email';
                                                } else {
                                                  return null;
                                                }
                                              }
                                            },
                                            KeyBoardType:
                                                TextInputType.emailAddress,
                                            enable: true,
                                            hint: 'Email',
                                            obscureText: false,
                                            PrefixIcon: 0xe3c3,
                                          ),
                                          SizedBox(
                                            height: hight * .02,
                                          ),
                                          ChangeNotifierProvider(
                                            create: (_) => forgotcontrller(),
                                            child: Consumer<forgotcontrller>(
                                              builder:
                                                  (context, provider, child) {
                                                return RoundButton(
                                                  title: "Send",
                                                  onPrass: () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      provider.forgot(
                                                          context,
                                                          EmailContrller.text
                                                              .toString());
                                                    }
                                                  },
                                                  loading: provider.loading,
                                                  color:
                                                      AppColors.kPrimaryColor,
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
