


import 'package:flutter/material.dart';
import 'package:homeservices/Proder/view/Oder_Services.dart';


import '../../res/color.dart';
import 'Add_Services_Screen.dart';
import 'All_Add_Services_show.dart';
import 'Proder_Profile.dart';

class proderHomeScreen extends StatefulWidget {
  const proderHomeScreen({Key? key}) : super(key: key);

  @override
  State<proderHomeScreen> createState() => _proderHomeScreenState();
}

class _proderHomeScreenState extends State<proderHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(children: [

          Container(child: Row(children: [
           Cardindata(image: 'assets/images/add_service.png', ontab: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=> AddSerivesScreen()));
           }, title: 'Add Services'),
            Cardindata(image: 'assets/images/splash_3.png', ontab: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> AllAddServicesShow()));
            }, title: 'View Services')

          ],),),

          Container(child: Row(children: [
            Cardindata(image: 'assets/images/bell.png', ontab: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=> OderServices()));
            }, title: 'notifications'),
            Cardindata(image: 'assets/images/user.png', ontab: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> proderProfile()));
            }, title: 'Profile'),

          ],),),
        ],),
      ),
    );
  }
}



class Cardindata extends StatelessWidget {
  const Cardindata({Key? key,
    required this.image,required this.ontab,required this.title
  }) : super(key: key);
 final String title ;
 final VoidCallback ontab;
 final String image ;
  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Container(
      width: width*0.5,
      height: hight*0.4,
      child: Padding(padding: EdgeInsets.only(left: 3,right: 3,bottom: 15,top: 15),
          child:InkWell(
            onTap: ontab,
            child: Card(

            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(image),
                  SizedBox(height: 10,),
                  Text(title,style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontSize: 22
                  ),)
                ],

              ),
            ),),
          ),),
    );
  }
}
