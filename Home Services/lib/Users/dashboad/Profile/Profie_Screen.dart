import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';


import '../../../res/Component/Row_Component.dart';
import '../../../res/color.dart';
import '../../../utils/Utils.dart';
import '../../View_Modle/Services/Session_Manager.dart';
import '../../signup/sign_up_screen.dart';
import '../Dashboad_Screen.dart';









class ProifileScreen extends StatelessWidget {
   ProifileScreen({Key? key}) : super(key: key);
  final ref = FirebaseDatabase.instance.ref().child('Users');
  final auth= FirebaseAuth.instance.currentUser!.uid.toString();

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
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(8.0, 48, 8, 8),
                          child: Text(
                            "PROFILE",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 48),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20.0, 120.0, 20.0, 20.0),
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
                              child: Column(
                                 // shrinkWrap: true,
                                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Text(
                                      "Your Account Datils",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.kTextColorSecondary,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      "",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.kTextColorSecondary,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      height: hight * .004,),
                                      Expanded(
                                        child: FirebaseAnimatedList(
                                          query: ref,
                                          itemBuilder: (BuildContext context, DataSnapshot snapshot,
                                              Animation<double> animation, int index) {
                                            if (snapshot.child('uid').value.toString() == auth){
                                              return Container(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width: 150,
                                                      height: 150,
                                                      decoration: BoxDecoration(
                                                        color: AppColors.kPrimaryColor,
                                                          borderRadius: BorderRadius.circular(200),
                                                          border: Border.all(width: 2)
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(200),
                                                        child: Image.network(snapshot.child('profile').value.toString(),fit: BoxFit.cover,
                                                          errorBuilder:
                                                              (BuildContext context,
                                                              Object exception,
                                                              StackTrace? stackTrace) {
                                                            return Icon(Icons
                                                                .error_outline_outlined);
                                                          },
                                                          loadingBuilder:
                                                              (BuildContext context,
                                                              Widget child,
                                                              ImageChunkEvent?
                                                              loadingProgress) {
                                                            if (loadingProgress == null)
                                                              return child;
                                                            return Center(
                                                              child:
                                                              CircularProgressIndicator(
                                                                color: AppColors.whiteColor,
                                                                value: loadingProgress
                                                                    .expectedTotalBytes !=
                                                                    null
                                                                    ? loadingProgress
                                                                    .cumulativeBytesLoaded /
                                                                    loadingProgress
                                                                        .expectedTotalBytes!
                                                                    : null,
                                                              ),
                                                            );
                                                          },
                                                        ),),),
                                                    SizedBox(height: hight*.02,),
                                                    RowCompoent(title: "UserName", Value:snapshot.child('name').value.toString(),),
                                                    RowCompoent(title: "Email", Value:snapshot.child('email').value.toString(),),
                                                    RowCompoent(title: "Phone", Value:snapshot.child('phone').value.toString(),),
                                                    RowCompoent(title: "Make Account Date",
                                                      Value: Utils.getHumanReadableDate(snapshot.child('time').value.toString()),),




                                                  ],
                                                ),
                                              );

                                         }else{

                                              return Container(
                                              );
                                            }

                                          },

                                        ),
                                      ),





                                  ]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: hight * .01),
                  NovccountText(
                    a: "",
                    b: " Back",
                    press: () {
                     Navigator.pushReplacement(context,
                         MaterialPageRoute(builder: (context)=>DashboardScreen()));

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





