import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:homeservices/Users/View_Modle/Services/Session_Manager.dart';
import 'package:homeservices/res/Component/Input_Text_Filed.dart';
import 'package:homeservices/res/Component/Round_Button.dart';
import 'package:provider/provider.dart';

import '../../res/color.dart';
import '../View_Modle/Add_Services_Contrller.dart';

class AddSerivesScreen extends StatefulWidget {
  const AddSerivesScreen({Key? key}) : super(key: key);

  @override
  State<AddSerivesScreen> createState() => _AddSerivesScreenState();
}

class _AddSerivesScreenState extends State<AddSerivesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseData(context);
  }
  String? name, email, profile, uid,address;

  Future<void> firebaseData(BuildContext context)   async {
    final ref = await FirebaseDatabase.instance
        .ref()
        .child('Users')
        .child(FirebaseAuth.instance.currentUser!.uid.toString())
        .get();
    setState(() {
      name = ref.child('name').value.toString();
      email = ref.child('email').value.toString();
      uid = ref.child('uid').value.toString();
      profile = ref.child('profile').value.toString();
      address = ref.child('address').value.toString();
      print(uid);
    });
  }

  List<DropdownMenuItem<String>> get dropdownItemsName {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("AC & Ventilation"), value: "AC & Ventilation"),
      DropdownMenuItem(child: Text("Plumbing"), value: "Plumbing"),
      DropdownMenuItem(child: Text("Electrical"), value: "Electrical"),
      DropdownMenuItem(child: Text("Cleaning"), value: "Cleaning"),
      DropdownMenuItem(child: Text("Car Wash"), value: "Car Wash"),
      DropdownMenuItem(child: Text("Lsundry"), value: "Laundry"),
      DropdownMenuItem(child: Text("Painting"), value: "Painting"),
      DropdownMenuItem(child: Text("Flooring"), value: "Flooring"),
      DropdownMenuItem(child: Text("Carpentry"), value: "Carpentery"),
      DropdownMenuItem(child: Text("Cameras"), value: "Cameras"),
      DropdownMenuItem(child: Text("Locksmith"), value: "Locksmith"),
      DropdownMenuItem(child: Text("Fire Safety"), value: "Fire Safety"),
      DropdownMenuItem(child: Text("Pet Products"), value: "Pet Products"),
      DropdownMenuItem(child: Text("Grocerices"), value: "Grocerices"),
      DropdownMenuItem(child: Text("Car Maintenance"), value: "Car Maintenance"),

    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Maintenance"), value: "Maintenance"),
      DropdownMenuItem(child: Text("Cleaning"), value: "Cleaning"),
      DropdownMenuItem(child: Text("Mome Improvement"), value: "Mome Improvement"),
      DropdownMenuItem(child: Text("Security & CCTY"), value: "Security & CCTY"),
      DropdownMenuItem(child: Text("Other"), value: "Other"),
    ];
    return menuItems;
  }
  List<DropdownMenuItem<String>> get AM {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("AM"), value: "AM"),
      DropdownMenuItem(child: Text("PM"), value: "PM"),

    ];
    return menuItems;
  }
  List<DropdownMenuItem<String>> get WorkHour {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("1:00"), value: "1:00"),
      DropdownMenuItem(child: Text("2:00"), value: "2:00"),
      DropdownMenuItem(child: Text("3:00"), value: "3:00"),
      DropdownMenuItem(child: Text("4:00"), value: "4:00"),
      DropdownMenuItem(child: Text("5:00"), value: "5:00"),
      DropdownMenuItem(child: Text("7:00"), value: "7:00"),
      DropdownMenuItem(child: Text("8:00"), value: "8:00"),
      DropdownMenuItem(child: Text("9:00"), value: "9:00"),
      DropdownMenuItem(child: Text("10:00"), value: "10:00"),
      DropdownMenuItem(child: Text("11:00"), value: "11:00"),
      DropdownMenuItem(child: Text("12:00"), value: "12:00"),



    ];
    return menuItems;
  }
  String? selectedValueHour;
   String ? selectedValueAM;
  String? selectedValueName;
  String? selectedValueType;
  final PriceController= TextEditingController();
 final pricefocusNode = FocusNode();
  int Conter = 1;
  int? NewConter = 0 ;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => addServicesContrller(),
        child:
            Consumer<addServicesContrller>(builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.kPrimaryColor1,
              title: Text(
                'Add Services',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontSize: 18, color: AppColors.whiteColor),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Type of Services',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontSize: 18, color: AppColors.kPrimaryColor1),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: AppColors.kPrimaryColor1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: DropdownButton(
                          value: selectedValueType,
                          items: dropdownItems,
                          onChanged: (Object? newValue) {
                            setState(() {
                              selectedValueType = newValue! as String?;
                            });
                          },
                        ),
                      ),
                    ),


                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Name of Services',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontSize: 18, color: AppColors.kPrimaryColor1),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                               color: AppColors.kPrimaryColor1)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: DropdownButton(
                          value: //selectedValue1 == null ? "Select of Services Name":
                              selectedValueName,
                          items: dropdownItemsName,
                          onChanged: (Object? newValue) {
                            setState(() {
                              selectedValueName = newValue! as String?;
                            });
                          },
                        ),
                      ),
                    ),

                    SizedBox(height: 20,),
                    Text('Start Wroking time daily',style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: AppColors.kPrimaryColor1,fontSize: 18
                    ),),
                    SizedBox(height: 5,),
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border:
                        Border.all(color: AppColors.kPrimaryColor1, ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            DropdownButton(
                              value: selectedValueHour,
                              items: WorkHour,
                              onChanged: (Object? newValue) {
                                setState(() {
                                  selectedValueHour = newValue! as String?;
                                });
                              },
                            ),
                            DropdownButton(
                              value: selectedValueAM,
                              items: AM,
                              onChanged: (Object? newValue) {
                                setState(() {
                                  selectedValueAM = newValue! as String?;
                                });
                              },
                            ),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    InputTextField(
                        PrefixIcon: 0xf2cb,

                        Color: AppColors.kPrimaryColor1,
                        myController: PriceController,
                        focusNode: pricefocusNode,
                        onFiledSubmittedValue:(value){},
                        onValidator: (value){},
                        KeyBoardType: TextInputType.number,
                        hint: 'Prise of Daily Services',
                        obscureText: false
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.kPrimaryColor1)
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(Conter.toString()+ "  Hour",style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: AppColors.kPrimaryColor1,
                            ),),
                          ),
                          Expanded(child: Container()),
                          IconButton(onPressed: (){
                            if(NewConter! <= 20){
                            setState(() {
                              NewConter = Conter++;
                            });}

                          }, icon: Icon(Icons.add,color: AppColors.kPrimaryColor1,)),
                          IconButton(onPressed: () {
                            if(Conter >= 1){
                              setState(() {
                                NewConter = Conter--;
                              });

                            }
                          }, icon: Icon(Icons.remove_outlined,color: AppColors.kPrimaryColor1,),)
                        ],
                      ),
                    ),
                    Text(
                      "Image of Services",
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: AppColors.kPrimaryColor1, fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () {
                        provider.pickerImage(context);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 3, color: AppColors.kPrimaryColor1),
                            borderRadius: BorderRadius.circular(42)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: provider.image == null
                              ? Icon(
                                  Icons.error_outline_rounded,
                                  size: 100,
                                  color: AppColors.kPrimaryColor1,
                                )
                              : Image.file(
                                  File(provider.image!.path).absolute,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RoundButton(
                      title: "Add Services",
                      onPrass: () {
                        provider.addServices(
                            context,
                            selectedValueType.toString(),
                            selectedValueName.toString(),
                            name.toString(),
                            email.toString(),
                            profile.toString(),
                            uid.toString(),
                            selectedValueHour.toString()+ " "+ selectedValueAM.toString(),
                        NewConter.toString()+ '  Hour',
                        PriceController.text.toString()+ " PR",
                          address.toString(),
                        );
                      },
                      loading: provider.loading,
                      color: AppColors.kPrimaryColor1,
                    )
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
