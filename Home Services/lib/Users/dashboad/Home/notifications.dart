
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../../../res/color.dart';
import '../../../utils/Utils.dart';



class notifications extends StatefulWidget {
  const notifications({Key? key}) : super(key: key);

  @override
  State<notifications> createState() => _notificationsState();
}

class _notificationsState extends State<notifications> {
  final ref = FirebaseDatabase.instance.ref().child('Oder');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kPrimaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(query: ref,
              itemBuilder: (BuildContext context,
                DataSnapshot snapshot, Animation<double> animation, int index) {
              if(snapshot.child('Oder_Uid').value.toString() == FirebaseAuth.instance.currentUser!.uid){
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    elevation: 50,
                    child: Column(children: [
                      ListTile(
                        leading: Container(
                            width: 50,
                            height: 50,
                            child: ClipRRect(borderRadius: BorderRadius.circular(200),
                              child: Image.asset(snapshot.child('Image').value.toString(),fit: BoxFit.cover,),)
                        ),
                        title: Text(snapshot.child('User_Name').value.toString()),
                        subtitle: Text(snapshot.child('Services_Name').value.toString()),
                      ),
                      Text('Price :  '+ snapshot.child('Price').value.toString()),
                      Text('Task  :  '+ snapshot.child('Complete').value.toString()),
                      Text ('Completed Date : '+Utils.getHumanReadableDate(snapshot.child('id').value.toString())),

                      SizedBox(height: 10,)
                    ],),),
                );
              }else{
                return Container();
              }
              },),
          )
        ],
      ),
    );
  }
}
