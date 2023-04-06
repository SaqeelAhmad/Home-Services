import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:homeservices/res/Component/Round_Button.dart';

import '../../../res/color.dart';
import '../../../utils/Utils.dart';

class CompletedScrvices extends StatefulWidget {
  const CompletedScrvices({Key? key}) : super(key: key);

  @override
  State<CompletedScrvices> createState() => _CompletedScrvicesState();
}

class _CompletedScrvicesState extends State<CompletedScrvices> {
  final ref = FirebaseDatabase.instance.ref().child('Oder');
  final ser = FirebaseDatabase.instance.ref().child('Services');
  var NewRate;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirebaseAnimatedList(
        query: ref,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
         double initialRating =double.parse( snapshot.child('Rate').value.toString());


          if (snapshot.child('Oder_Uid').value.toString() ==
                  FirebaseAuth.instance.currentUser!.uid &&
              snapshot.child('Complete').value.toString() == 'Complete') {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 50,
                child: Column(
                  children: [
                    ListTile(
                      leading: Container(
                          width: 50,
                          height: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: Image.asset(
                              snapshot.child('Image').value.toString(),
                              fit: BoxFit.cover,
                            ),
                          )),
                      title: Text(snapshot.child('User_Name').value.toString()),
                      subtitle: Text(
                          snapshot.child('Services_Name').value.toString()),
                    ),
                    Text(
                        'Price :  ' + snapshot.child('Price').value.toString()),
                    Text('Task  :  ' +
                        snapshot.child('Complete').value.toString()),
                    Text('Completed Date : ' +
                        Utils.getHumanReadableDate(
                            snapshot.child('id').value.toString())),
                    SizedBox(
                      height: 10,
                    ),
                   // if (snapshot.child('Rate').value == 0)
                      RatingBar.builder(
                        initialRating: initialRating,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: AppColors.kPrimaryColor,
                        ),
                        onRatingUpdate: (rating) {
                          NewRate = rating;
                          setState(() {


                          });


                        },
                      ),
                    if (snapshot.child('Rate').value == 0)
                    RoundButton(title: 'Rate', onPrass: () async {
                      if(NewRate != 0 ){
                      final data = await FirebaseDatabase.instance
                          .ref('Services')
                          .child(snapshot
                          .child('time')
                          .value
                          .toString())
                          .get();


                      var UserRate = double.parse(data
                          .child('rate')
                          .value
                          .toString());
                      var UserReView = int.parse(data
                          .child('review')
                          .value
                          .toString());
                      double finleRate = UserRate + NewRate;
                      int finlRaView = UserReView + 1;
                      print(UserRate);
                      print(UserReView);

                      ser.child(snapshot
                          .child('time')
                          .value
                          .toString()).update({
                        'rate': finleRate,
                        'review': finlRaView,
                      }).then((value) {
                        Utils.toastMessage("Update Rate");
                        ref
                            .child(snapshot
                            .child('id')
                            .value
                            .toString())
                            .update({
                          'Rate': NewRate,
                        }).then((value) async {
                          Utils.toastMessage('Rate Update');
                        }).onError((error, stackTrace) {
                          Utils.toastMessage(error.toString());
                        });
                      });
                    }else{
                        Utils.toastMessage('Rate Star is null.');
                      }
                    },color: AppColors.kPrimaryColor,),

                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
