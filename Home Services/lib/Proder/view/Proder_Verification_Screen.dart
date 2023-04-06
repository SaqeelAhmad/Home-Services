import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../../Users/View_Modle/Services/Session_Manager.dart';
import '../../Users/signup/sign_up_screen.dart';
import '../../res/Component/Row_Component.dart';
import '../../res/color.dart';
import '../../utils/Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';




class ProderVerificationScreen extends StatefulWidget {
  const ProderVerificationScreen({Key? key}) : super(key: key);

  @override
  State<ProderVerificationScreen> createState() => _ProderVerificationScreenState();
}

class _ProderVerificationScreenState extends State<ProderVerificationScreen> {

  final ref = FirebaseDatabase.instance.ref().child('Users');

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
                          gradient: AppColors.kPrimaryGradientColor1,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(8.0, 48, 8, 8),
                          child: Text(
                            "Verification",
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
                                      "Your Account Details",
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
                                          if (snapshot.child('uid').value.toString() == FirebaseAuth.instance.currentUser!.uid
                                          ){
                                            return Container(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: 150,
                                                    height: 150,
                                                    decoration: BoxDecoration(
                                                        color: AppColors.kPrimaryColor1,
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
                                                   Card(child: Container(
                                                       width : double.infinity,child: Center(child: Padding(
                                                         padding: const EdgeInsets.only(top: 10,bottom: 10),
                                                         child: Text ('This Account is not verified\n please wait from verification.',
                                                         style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 18),),
                                                       ))),)




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

                ],
              ),
            ),
          ),
        ),
      ),
    );




  }

}
