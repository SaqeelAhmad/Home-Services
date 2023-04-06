



import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:homeservices/res/Component/Round_Button.dart';
import 'package:homeservices/res/color.dart';

import '../../../utils/Utils.dart';

class OderServies extends StatefulWidget {
  const OderServies({Key? key}) : super(key: key);

  @override
  State<OderServies> createState() => _OderServiesState();
}

class _OderServiesState extends State<OderServies> {
  final ref = FirebaseDatabase.instance.ref().child('Oder');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirebaseAnimatedList(query: ref, itemBuilder: (BuildContext context,
          DataSnapshot snapshot, Animation<double> animation, int index) {
        String Time =DateTime.now().microsecondsSinceEpoch.toString();
        if(snapshot.child('Oder_Uid').value.toString() == FirebaseAuth.instance.currentUser!.uid
            &&
        snapshot.child('Complete').value.toString() == 'Not_Complete'
        //     && snapshot.child('id').value.toString()
        //     .toLowerCase()
        //     .contains(Time.toLowerCase())
        ){

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
                trailing: IconButton(onPressed: () {
                  ref.child(snapshot.child('id').value.toString()).remove().then((value) {
                    Utils.toastMessage('Cancel you Oder of Services');
                  }).onError((error, stackTrace) {
                    Utils.toastMessage(error.toString());
                  });
                }, icon: Icon(Icons.delete),)
              ),
              Text('Price :  '+ snapshot.child('Price').value.toString()),
              Text('Task  :  '+ snapshot.child('Complete').value.toString()),
              Text ('Task Taken Date : '+Utils.getHumanReadableDate(snapshot.child('id').value.toString())),

              SizedBox(height: 10,)
            ],),),
          );
          
        }else{
          return Container();
        }
      },),
    );
  }
}
