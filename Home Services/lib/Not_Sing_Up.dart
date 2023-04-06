import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeservices/res/Component/Round_Button.dart';
import 'package:homeservices/res/color.dart';

import 'Proder/view/Proder_SignUp_Screen.dart';
import 'Users/signup/sign_up_screen.dart';

class NotSignUP extends StatefulWidget {
  const NotSignUP({Key? key}) : super(key: key);

  @override
  State<NotSignUP> createState() => _NotSignUPState();
}

class _NotSignUPState extends State<NotSignUP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(borderRadius: BorderRadius.circular(200),
                      child: Image.asset('assets/images/user.png',width: 150,height: 150),),
                      SizedBox(height: 10,),
                      RoundButton(title: "Users", onPrass: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> SignupScreen()));
                      },color: AppColors.kPrimaryColor,
                      textColor: AppColors.whiteColor,)
                    ],
                  ),
                ),
              ),
            )),
            Expanded(child:Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                child: Container(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(borderRadius: BorderRadius.circular(200),
                        child: Image.asset('assets/images/user.png',width: 150,height: 150,),),
                      SizedBox(height: 10,),
                      RoundButton(title: "Prouder", onPrass: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ProuderSignupScreen()));
                      },color: AppColors.whiteColor,
                        textColor: Colors.black,)
                    ],
                  ),
                ),
              ),
            ) )
          ],
        ),
      ),
    );
  }
}
