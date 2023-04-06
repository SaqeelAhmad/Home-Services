import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeservices/Not_Login.dart';
import 'package:homeservices/res/Component/Round_Button.dart';

import '../../res/color.dart';
import '../../utils/Utils.dart';
import '../../utils/routes/route_name.dart';
import '../View_Modle/Services/Session_Manager.dart';
import '../login/Mobile_Number.dart';
import '../../Proder/view/Proder_Login_screen.dart';
import 'Home/Completed_Services.dart';
import 'Home/Home_Screen.dart';
import 'Home/Oder_Services.dart';
import 'Home/notifications.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final auth = FirebaseAuth.instance;

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),

    CompletedScrvices(),
    OderServies(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }



  // late String data;
  // DatabaseReference tempvaleur =
  // FirebaseDatabase.instance.ref('Oder');
  // tempvaleur.onValue.listen((DatabaseEvent event) async {
  //
  // print(event.snapshot.value);
  // data = event.snapshot.value.toString() ;
  //
  // }
  // );



  final ref = FirebaseDatabase.instance.ref().child('Users');

  @override
  Widget build(BuildContext context) {


    final hight = MediaQuery.of(context).size.height * 1;
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        drawer: Drawer(
          backgroundColor:AppColors.kPrimaryColor ,
            child: SafeArea(
          child: Expanded(
            child: FirebaseAnimatedList(
              query: ref,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                if (snapshot.child('uid').value.toString() ==
                    auth.currentUser!.uid) {
                  return Column(
                    children: [
                      Card(
                        color: AppColors.kPrimaryColor,
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
                        leading: Icon(Icons.home,color: AppColors.whiteColor,),
                        title: Text('Home',style: TextStyle(color: AppColors.whiteColor)),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.ProifileView);
                        },
                        leading: Icon(Icons.person,color: AppColors.whiteColor,),
                        title: Text('Profile',style: TextStyle(color: AppColors.whiteColor)),
                      ),
                      ListTile(
                        leading: Icon(Icons.logout,color: AppColors.whiteColor,),
                        title: Text('signOut',style: TextStyle(color: AppColors.whiteColor),),
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
          backgroundColor: AppColors.kPrimaryColor,
          title: Text(
            'Home Services',
            style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 18,color: AppColors.whiteColor),
          ),
          actions: <Widget>[

            Stack(
              children: [
                Text('2'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 16, 18, 0),
                  child: IconButton(
                    visualDensity:
                    const VisualDensity(horizontal: -4.0, vertical: -4.0),
                    icon: const Icon(
                      Icons.notifications_active_outlined,
                      color: AppColors.whiteColor,
                    ),
                    onPressed: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context)=> notifications()));
                    },
                  ),
                ),
              ],
            ),

          ],
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.incomplete_circle),
              label: 'Completed',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.on_device_training_sharp),
              label: 'Oder',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.kPrimaryColor,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
