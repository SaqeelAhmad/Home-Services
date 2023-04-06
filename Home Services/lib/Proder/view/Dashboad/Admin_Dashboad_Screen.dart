

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:homeservices/Proder/view/Oder_Services.dart';


import '../../../Not_Login.dart';
import '../../../Users/View_Modle/Services/Session_Manager.dart';

import '../../../res/color.dart';
import '../../../utils/Utils.dart';

import '../All_Add_Services_show.dart';
import '../Proder_Home_Screen.dart';

import '../Proder_Profile.dart';



class ProderDashboadScreen extends StatefulWidget {
  const ProderDashboadScreen({Key? key}) : super(key: key);

  @override
  State<ProderDashboadScreen> createState() => _ProderDashboadScreenState();
}

class _ProderDashboadScreenState extends State<ProderDashboadScreen> {
  final auth = FirebaseAuth.instance;


  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    //HomeScreen(),
    proderHomeScreen(),
    AllAddServicesShow(),
    OderServices(),
    proderProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final ref = FirebaseDatabase.instance.ref('Users');



  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height * 1;
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        drawer: Drawer(
          backgroundColor: AppColors.kPrimaryColor1,

            child: SafeArea(
              child: Expanded(
                child: FirebaseAnimatedList(
                  query: ref,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    if (snapshot.child('uid').value.toString() == FirebaseAuth.instance.currentUser!.uid) {
                      return Column(
                        children: [
                          Card(
                            color: AppColors.kPrimaryColor1,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(200),
                                      border: Border.all(
                                          width: 2, color: AppColors.whiteColor)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(200),
                                    child: Image.network(
                                      snapshot.child('profile').value.toString(),
                                      fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return Icon(Icons.error_outline_outlined);
                                      },
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) return child;

                                        return Center(
                                          child: CircularProgressIndicator(
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
                                    ),
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    snapshot.child('name').value.toString(),
                                    style: TextStyle(color: AppColors.whiteColor),
                                  ),
                                  subtitle: Text(
                                      snapshot.child('email').value.toString(),
                                      style:
                                      TextStyle(color: AppColors.whiteColor)),
                                )
                              ],
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            leading: const Icon(Icons.home,color: AppColors.whiteColor,),
                            title: const Text('Home',style: TextStyle(color: AppColors.whiteColor)),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> proderProfile()));
                            },
                            leading: const Icon(Icons.person,color: AppColors.whiteColor,),
                            title: const Text('Profile',style: TextStyle(color: AppColors.whiteColor)),
                          ),

                          ListTile(
                            leading: const Icon(Icons.logout,color: AppColors.whiteColor,),
                            title: const Text('signOut',style: TextStyle(color: AppColors.whiteColor),),
                            onTap: () {
                              auth.signOut().then((value) {
                                sessioncontroller().userId = "";

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NotLogin()));

                                // Navigator.pushNamed(context, RouteName.loginView);

                                Utils.toastMessage("Your account is signOut.");
                              }).onError((error, stackTrace) {
                                Utils.toastMessage(error.toString());
                              });
                            },
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            )),
        appBar: AppBar(
          backgroundColor: AppColors.kPrimaryColor1,
          title: Text('Home Services Provider',style:  Theme.of(context).textTheme.subtitle2!
              .copyWith(fontSize: 18,color: AppColors.whiteColor),),

        ),



        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home,color: AppColors.kPrimaryColor1,),
              label: 'Home',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.notification_important_rounded),
            //   label: 'Your Invest',
            // ),
            BottomNavigationBarItem(icon: Icon(Icons.home_repair_service,color: AppColors.kPrimaryColor1,),
            label:  'View Service'),
            BottomNavigationBarItem(icon: Icon(Icons.cleaning_services_sharp,color: AppColors.kPrimaryColor1),
            label: "Oder Service"),
            BottomNavigationBarItem(
              icon: Icon(Icons.person,color: AppColors.kPrimaryColor1),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.kPrimaryColor1,
          onTap: _onItemTapped,
        ),





      ),
    );
  }
}
