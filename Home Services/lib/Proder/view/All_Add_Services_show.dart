




import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:homeservices/res/Component/Input_Text_Filed.dart';
import 'package:homeservices/res/color.dart';
import 'package:homeservices/utils/Utils.dart';

import '../../res/Component/Row_Component.dart';



class AllAddServicesShow extends StatefulWidget {
  const AllAddServicesShow({Key? key}) : super(key: key);

  @override
  State<AllAddServicesShow> createState() => _AllAddServicesShowState();
}

class _AllAddServicesShowState extends State<AllAddServicesShow> {


  final UpdateController= TextEditingController();
  final UpdateFocusNode= FocusNode();
  late final selectedItem ;
  final ref = FirebaseDatabase.instance.ref().child("Services");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FirebaseAnimatedList(query: ref, itemBuilder: (BuildContext context,
            DataSnapshot snapshot, Animation<double> animation, int index) { 
          if(snapshot.child('User_Uid').value.toString() == FirebaseAuth.instance.currentUser!.uid.toString()){
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(elevation: 50,
              child: Column(children: [
                ListTile(
                  leading: Container(width: 50,
                    height: 50,
                    child: ClipRRect(borderRadius: BorderRadius.circular(200),
                    child: Image.network(snapshot.child('Image_Serviees').value.toString(),fit: BoxFit.cover,),),
                  ),
                  title: Text(snapshot.child("Name_Services").value.toString()),
                  subtitle: Text(snapshot.child("Type_Services").value.toString()),
                  trailing:PopupMenuButton(onSelected: (value){
                    setState(() {
                      print(value);
                      switch (value){
                        case 1: {selectedItem = showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(content:Container(
                                height: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Update price'),
                                    SizedBox(height: 20,),
                                    InputTextField(
                                       Color: AppColors.kPrimaryColor1,
                                        myController: UpdateController,
                                        focusNode: UpdateFocusNode,
                                        onFiledSubmittedValue:(value){},
                                        onValidator: (value){},
                                      KeyBoardType: TextInputType.number,
                                        hint: '',
                                        obscureText: false,
                                      PrefixIcon: 0xe692,

                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                               // _image = null;
                                              },
                                              child: Text("Cencle",style: TextStyle(color: AppColors.alertColor),)),
                                          TextButton(
                                              onPressed: () {
                                                FirebaseDatabase.instance.ref().child('Services').child(snapshot.child('time').value.toString()).update({
                                                  'price': UpdateController.text.toString(),
                                                }).then((value) {
                                                  UpdateController.clear();
                                                  Utils.toastMessage("Update Price");
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: Text("Ok",style: TextStyle(color: AppColors.kPrimaryColor1)))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ));});}
                        break;
                        case 2:{selectedItem = FirebaseDatabase.instance
                            .ref().child('Services').child(snapshot.child('time').value.toString()).remove().then((value) {
                              Utils.toastMessage('Services is delete.');
                        });}
                        break;

                      }

                    });

                  },itemBuilder: (BuildContext bc) {
                    return [
                      PopupMenuItem(
                          value: 1,
                          // ( //popUpDialog(context);
                          //     popUpDialog(context); ),
                          child: Text(
                            "Update",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          )),
                      PopupMenuItem(
                          value: 2,
                          // ( //popUpDialog(context);
                          //     popUpDialog(context); ),
                          child: Text(
                            "Delete",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          )),
                    ];
                  }
                    //itemBuilder: (BuildContext context) {  },
              ),

                ),
                RowCompoent(title: 'Price one day ', Value: snapshot.child('price').value.toString()+" PR"),

              ],),),
            );
            
          }else{return Container();}
        },),
      ),
    );
  }
}
