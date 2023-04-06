




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeservices/Proder/view/Proder_Login_screen.dart';
import 'package:provider/provider.dart';

import '../../res/Component/Input_Text_Filed.dart';
import '../../res/Component/Round_Button.dart';
import '../../res/color.dart';
import '../../utils/Utils.dart';
import '../../utils/routes/route_name.dart';
import '../View_Modle/Login/Login_Contrller.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({Key? key}) : super(key: key);

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final EmailContrller = TextEditingController();
  final EmailFocusNode = FocusNode();
  final PasswordContrller = TextEditingController();
  final PasswordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    EmailContrller.dispose();
    PasswordContrller.dispose();
    EmailFocusNode.dispose();
    PasswordFocusNode.dispose();
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
                    gradient:  AppColors.kPrimaryGradientColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
                    child: Container(
                      alignment: Alignment.center, // use aligment
                      margin: const EdgeInsets.only(right: 8),
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18.0),
                        child: const Image(
                          width: 180,
                          height: 180,
                          fit: BoxFit.contain,
                          image: AssetImage(
                            'assets/images/splash_3.png',
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
                      elevation: 9.0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Welcome Back",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize:32 ),
                                ),
                                Text(
                                  "Signing in as Users.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    //color: kTextColorSecondary,
                                    // fontSize: getProportionateScreenWidth(14),
                                  ),
                                ),
                                SizedBox(
                                  //height: getProportionateScreenHeight(4)),

                                    child:  Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          SizedBox(height: 10,),
                                          InputTextField(
                                            Color: AppColors.kPrimaryColor,
                                            myController: EmailContrller,
                                            focusNode: EmailFocusNode,
                                            onFiledSubmittedValue: (Value) {
                                              Utils.fieldFocus(
                                                  context, EmailFocusNode, PasswordFocusNode);
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
                                            KeyBoardType: TextInputType.emailAddress,
                                            enable: true,
                                            hint: 'Email',
                                            obscureText: false,
                                            PrefixIcon: 0xe3c3,
                                          ),

                                          InputTextField(
                                            Color: AppColors.kPrimaryColor,
                                            myController: PasswordContrller,
                                            focusNode: PasswordFocusNode,
                                            onFiledSubmittedValue: (newValue) {},
                                            onValidator: (val) =>
                                            val.length < 6 ? 'Password too short.' : null,
                                            KeyBoardType: TextInputType.emailAddress,
                                            enable: true,
                                            hint: 'Password',
                                            obscureText: _obscureText,
                                            PrefixIcon: 0xe3b1,
                                              Suffix:  GestureDetector(
                                                onTap: _toggle,
                                                child: Icon(
                                                  _obscureText ? Icons.visibility_off : Icons.visibility,
                                                  color: AppColors.kPrimaryColor,//kTextColorSecondary,
                                                ),
                                              )
                                          ),
                                          // Checkbox(
                                          //   value: this._obscured,
                                          //   onChanged: (_obscured) {
                                          //     setState(() {
                                          //       this._obscured = _obscured!;
                                          //     });
                                          //   },
                                          // ),
                                          Container(
                                            child: Row(
                                              children: [


                                                const Expanded(child: SizedBox()),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                        context, RouteName.ForgotView);
                                                  },
                                                  child: Text.rich(TextSpan(
                                                      text: "Forgot Password",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2!
                                                          .copyWith(
                                                          fontSize: 14,
                                                          decoration:
                                                          TextDecoration.underline))),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: hight * .03,
                                          ),
                                          ChangeNotifierProvider(
                                            create: (_) => logincontrller(),
                                            child: Consumer<logincontrller>(
                                              builder: (context, provider, child) {
                                                return RoundButton(
                                                  color: AppColors.kPrimaryColor,
                                                  title: "Login",
                                                  onPrass: () {
                                                    if (_formKey.currentState!.validate()) {
                                                      provider.login(
                                                        context,
                                                        EmailContrller.text.toString(),
                                                        PasswordContrller.text.toString(),
                                                      );
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

                                        ],
                                      ),
                                    )



                                ),
                              ]),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
               // Navigator.pushNamed(context, RouteName.SignupView);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ProderLoginScreen()));
              },
              child: Text.rich(TextSpan(
                  text: "Provider",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 18),
                  children: [
                    TextSpan(
                      text: 'Sign in',

                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          color: AppColors.kPrimaryColor),
                    )
                  ])),
            ),
            SizedBox(height: hight*.1),


            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RouteName.SignupView);
              },
              child: Text.rich(TextSpan(
                  text: "Don't have an account?",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 18),
                  children: [
                    TextSpan(
                      text: 'Sign Up',
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          color: AppColors.kPrimaryColor),
                    )
                  ])),
            )

          ],
        ),
      ),
    );
  }
}
