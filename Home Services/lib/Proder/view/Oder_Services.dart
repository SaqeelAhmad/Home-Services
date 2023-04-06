


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:homeservices/res/Component/Round_Button.dart';

import '../../res/color.dart';



class OderServices extends StatefulWidget {
  const OderServices({Key? key}) : super(key: key);

  @override
  State<OderServices> createState() => _OderServicesState();
}

class _OderServicesState extends State<OderServices> {
  
  final ref = FirebaseDatabase.instance.ref().child('Oder');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FirebaseAnimatedList(query: ref,
          itemBuilder: (BuildContext context, DataSnapshot
          snapshot, Animation<double> animation, int index) {
          if(snapshot.child('User_Uid').value.toString() == FirebaseAuth.instance.currentUser!.uid.toString()){
          return Padding(
            padding: const EdgeInsets.only(right: 15,left: 15,top: 10,bottom: 10
            ),
            child: Card(
              child: Column(
                children: [
                  ListTile(leading: Container(width: 50,height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: Image.asset(snapshot.child('Image').value.toString(),fit: BoxFit.cover,),
                  ),),
                  title: Text(snapshot.child('Oder_Name').value.toString()),
                    subtitle:  Text(snapshot.child('Services_Name').value.toString()),
                  ),
                  Text('Price Of Services : '+ snapshot.child('Price').value.toString()),
                  Text('Address  :   '+snapshot.child('Oder_Address').value.toString()),
                  if (snapshot.child('Complete').value.toString() == 'Not_Complete')
                  RoundButton(title: "Complete", onPrass: () async {
final Complet= await FirebaseDatabase.instance.ref().child('Oder').child(snapshot.child('id').value.toString());
Complet.update({
  'Complete': 'Complete'
}

);
                  },color: AppColors.kPrimaryColor1,)
                  else
                    Column(
                      children: [
                        Text('Service oder is Complete.'),
                      ],
                    ),
                  SizedBox(height: 20,)

                ],
              ),
            ),
          );
          }else{
            return Container();
          }
          },

        ),

      ),
    );
  }
}
