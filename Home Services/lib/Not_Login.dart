import 'package:flutter/material.dart';
import 'package:homeservices/res/Component/Round_Button.dart';
import 'package:homeservices/res/color.dart';
import 'package:homeservices/utils/routes/route_name.dart';

import 'Not_Sing_Up.dart';
import 'Users/login/login.dart';
import 'Users/signup/sign_up_screen.dart';

class NotLogin extends StatefulWidget {
  const NotLogin({Key? key}) : super(key: key);

  @override
  State<NotLogin> createState() => _NotLoginState();
}

class _NotLoginState extends State<NotLogin> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "heading": "Choose from our best Services",
      "text": "Pick your desired Services with in clicks.",
      "image": "assets/images/splash_1.png"
    },
    {
      "heading": "Find nearby handy services",
      "text":
          "Choose anything from daily essential to handy services \nand get your work done",
      "image": "assets/images/splash_2.png"
    },
    {
      "heading": "Fast Service",
      "text": "Fast service to your home, office and\nany where you are.",
      "image": "assets/images/splash_3.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"]!,
                  text: splashData[index]['text']!,
                  heading: splashData[index]['heading']!,
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(
                      flex: 3,
                    ),
                    RoundButton(
                      title: "Login",
                      onPrass: () {
                        //Navigator.pushNamed(context, RouteName.UserLoginView);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserLogin()));
                      },
                      color: AppColors.kPrimaryColor,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    RoundButton(
                      title: 'Create Account',
                      onPrass: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_)=> NotSignUP()
                        ));
                      },
                      color: AppColors.whiteColor,
                      textColor: Colors.black,
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: AppColors.kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 8,
      width: 8,
      //width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index
            ? AppColors.kPrimaryColor
            : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    required this.heading,
    required this.text,
    required this.image,
  }) : super(key: key);
  final String text, heading, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Image.asset(
          image,
          // height: getProportionateScreenHeight(265),
          // width: getProportionateScreenWidth(235),
        ),
        Spacer(),
        Text(
          heading,
          style: TextStyle(
            fontSize: 24,
            // color: AppColors.kTextColor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              // color:AppColors. kTextColorSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Spacer(flex: 2),
      ],
    );
  }
}
