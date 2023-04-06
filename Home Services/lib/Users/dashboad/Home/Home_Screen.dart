import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:homeservices/res/Component/Input_Text_Filed.dart';
import 'package:homeservices/res/color.dart';

import 'Row_Card.dart';
import 'Services_Item_Tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
  String? Search;
  final serchFocusNode = FocusNode();

  final ref = FirebaseDatabase.instance.ref().child('Users');
  final ref1 = FirebaseDatabase.instance.ref().child('Services');
 // List<String>
 var searchTerms = [
   {"Name_Services": 'Ac & Ventilation', 'Image': 'assets/images/AC.png','Type_Services':'Mitenance'},
   {"Name_Services":'Plumbing','Image':'assets/images/Plumbing.png','Type_Services':'Mitenance'},
   {"Name_Services":'Electrical','Image':'assets/images/Electrical.png','Type_Services':'Mitenance'},
   {'Name_Services':'Cleaning','Image':'assets/images/Cleaning.png','Type_Services':'Cleaning'},
   {'Name_Services':'Car Wash','Image':'assets/images/Car_Wash.png','Type_Services':'Cleaning'},
   {'Name_Services':' Laundry','Image':'assets/images/Laundry.jpg','Type_Services':'Cleaning'},
   {'Name_Services': 'Painting','Image':'assets/images/Painting.png','Type_Services':'Home Improvement'},
   {'Name_Services':'Flooring','Image':'assets/images/Flooring.png','Type_Services':'Home Improvement'},
   {'Name_Services':'Carpentry','Image':'assets/images/Carpentry.png','Type_Services':'Home Improvement'},
   { 'Name_Services':'Cameras','Image':'assets/images/CCTV.png','Type_Services':'Security & CCTV'},
   {'Name_Services':'Locksmith','Image':'assets/images/Locksmith.png','Type_Services':'Security & CCTV'},
   {'Name_Services': 'Fire Safety','Image':'assets/images/Fire_Safety.png','Type_Services':'Security & CCTV'},
   {'Name_Services': 'Pet Products','Image':'assets/images/Pet_Products.png','Type_Services':'Other'},
   {'Name_Services':'Groceries','Image':'assets/images/Groceries.png','Type_Services':'Other'},
   {'Name_Services':'Car Maintenance','Image':'assets/images/Car_Maintenance.png','Type_Services':'Other'}
  ];

  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height * 1;
    return SafeArea(
        child: Column(
      children: [
        Padding(
          padding:
          const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: InputTextField(
value: (value){
  setState(() {

  });
},
            PrefixIcon: 0xf2bc,
            Color: AppColors.kPrimaryColor,
            myController: searchController,
            focusNode: serchFocusNode,
            onFiledSubmittedValue: (value) {},
            onValidator: (value) {},
            KeyBoardType: TextInputType.name,
            hint: 'I need ...',
            obscureText: false,
            Suffix: InkWell(
                onTap: () {
                  searchController.clear();
                },
                child: Icon(
                  Icons.clear,
                  color: AppColors.kPrimaryColor,
                )),
          ),
        ),
         if(searchController.text.isEmpty)
           Container(
           )else
         Expanded(
           child: ListView.builder(
               itemCount: searchTerms.length,
               itemBuilder: (BuildContext context, int index){
                // return Text(searchTerms[index].toString());
                 final ItemName = searchTerms[index]['Name_Services'].toString();

                 if(ItemName.toString()
                     .toLowerCase()
                     .contains(searchController.text.toLowerCase())){
                   return Padding(
                     padding: const EdgeInsets.only(left: 10,right: 10),
                     child: InkWell(
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>ServicesItemTab(
                           Imageof: searchTerms[index]['Image'].toString(),
                           NameServices: ItemName,
                           TypeServices: searchTerms[index]['Type_Services'].toString(),) ));
                       },
                       child: Card(

                         elevation: 100,
                         child: ListTile(
                           leading: Container(width: 50,height: 50,child:
                             ClipRRect(borderRadius: BorderRadius.circular(200),
                             child: Image.asset(searchTerms[index]['Image'].toString(),fit: BoxFit.cover,),),),
                           title: Text(ItemName),
                           subtitle:Text(searchTerms[index]['Type_Services'].toString()) ,
                         ),
                       ),
                     ),
                   );

                 }else {
                   return Container();
                 }

               }

           ),
         ),
if (searchController.text.isEmpty)
        Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: Container(
                        child: Row(
                          children: [
                            Text(
                              "Maintenance",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: AppColors.kPrimaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    RowCard(
                      title1: 'Ac & Ventilation',
                      title2: 'Plumbing',
                      tiltle3: 'Electrical',
                      image1: 'assets/images/AC.png',
                      image2: 'assets/images/Plumbing.png',
                      image3: 'assets/images/Electrical.png',
                      onTab1: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServicesItemTab(
                                      Imageof: 'assets/images/AC.png',
                                      NameServices: 'AC & Ventilation',
                                      TypeServices: 'Maintenance',

                                    )));
                      },
                      onTab2: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServicesItemTab(
                                      Imageof: 'assets/images/Plumbing.png',
                                      NameServices: 'Plumbing',
                                      TypeServices: 'Maintenance',
                                    )));
                      },
                      onTab3: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServicesItemTab(
                                      Imageof: 'assets/images/Electrical.png',
                                      NameServices: 'Electrical',
                                      TypeServices: 'Maintenance',
                                    )));
                      },
                    ),

// 222
                  SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: Container(
                        child: Row(
                          children: [
                            Text(
                              "Cleaning",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: AppColors.kPrimaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    RowCard(
                      title1: 'Cleaning',
                      title2: 'Car Wash',
                      tiltle3: 'Laundry',
                      image1: 'assets/images/Cleaning.png',
                      image2: 'assets/images/Car_Wash.png',
                      image3: 'assets/images/Laundry.jpg',
                      onTab1: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServicesItemTab(
                                      Imageof: 'assets/images/Cleaning.png',
                                      NameServices: 'Cleaning',
                                      TypeServices: 'Cleaning',
                                    )));
                      },
                      onTab2: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServicesItemTab(
                                      Imageof: 'assets/images/Car_Wash.png',
                                      NameServices: 'Car Wash',
                                      TypeServices: 'Cleaning',
                                    )));
                      },
                      onTab3: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServicesItemTab(
                                      Imageof: 'assets/images/Laundry.jpg',
                                      NameServices: 'Laundry',
                                      TypeServices: 'Cleaning',
                                    )));
                      },
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: Container(
                        child: Row(
                          children: [
                            Text(
                              "Home Improvement",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: AppColors.kPrimaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    RowCard(
                      title1: 'Painting',
                      title2: 'Flooring',
                      tiltle3: 'Carpentry',
                      image1: 'assets/images/Painting.png',
                      image2: 'assets/images/Flooring.png',
                      image3: 'assets/images/Carpentry.png',
                      onTab1: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServicesItemTab(
                                      Imageof: 'assets/images/Painting.png',
                                      NameServices: 'Painting',
                                      TypeServices: 'Home Improvement',
                                    )));
                      },
                      onTab2: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServicesItemTab(
                                      Imageof: 'assets/images/Flooring.png',
                                      NameServices: 'Flooring',
                                      TypeServices: 'Home Improvement',
                                    )));
                      },
                      onTab3: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServicesItemTab(
                                      Imageof: 'assets/images/Carpentry.png',
                                      NameServices: 'Carpentry',
                                      TypeServices: 'Home Improvement',
                                    )));
                      },
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: Container(
                        child: Row(
                          children: [
                            Text(
                              "Security & CCTV",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: AppColors.kPrimaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    RowCard(
                      title1: 'Cameras',
                      title2: 'Locksmith',
                      tiltle3: 'Fire Safety',
                      image1: 'assets/images/CCTV.png',
                      image2: 'assets/images/Locksmith.png',
                      image3: 'assets/images/Fire_Safety.png',
                      onTab1: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServicesItemTab(
                                      Imageof: 'assets/images/CCTV.png',
                                      NameServices: 'Cameras',
                                      TypeServices: 'Home Improvement',
                                    )));
                      },
                      onTab2: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServicesItemTab(
                                      Imageof: 'assets/images/Locksmith.png',
                                      NameServices: 'Locksmith',
                                      TypeServices: 'Home Improvement',
                                    )));
                      },
                      onTab3: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServicesItemTab(
                                      Imageof: 'assets/images/Fire_Safety.png',
                                      NameServices: 'Fire Safety',
                                      TypeServices: 'Home Improvement',
                                    )));
                      },
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: Container(
                        child: Row(
                          children: [
                            Text(
                              "Other Products & Services",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: AppColors.kPrimaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    RowCard(
                      title1: 'Pet Products',
                      title2: 'Groceries',
                      tiltle3: 'Car Maintenance',
                      image1: 'assets/images/Pet_Products.png',
                      image2: 'assets/images/Groceries.png',
                      image3: 'assets/images/Car_Maintenance.png',
                      onTab1: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServicesItemTab(
                                      Imageof: 'assets/images/Pet_Products.png',
                                      NameServices: 'Pet Products',
                                      TypeServices: 'Other',
                                    )));
                      },
                      onTab2: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServicesItemTab(
                                      Imageof: 'assets/images/Groceries.png',
                                      NameServices: 'Groceries',
                                      TypeServices: 'Other',
                                    )));
                      },
                      onTab3: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServicesItemTab(
                                      Imageof: 'assets/images/Car_Maintenance.png',
                                      NameServices: 'Car Maintenance',
                                      TypeServices: 'Other',
                                    )));
                      },
                    ),
                  ],
                ),
              ),
            ),
      ],
    ));
  }
}
