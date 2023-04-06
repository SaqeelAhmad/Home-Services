import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:homeservices/res/Component/Round_Button.dart';
import 'package:provider/provider.dart';

import '../../../res/Component/Input_Text_Filed.dart';
import '../../../res/color.dart';
import '../../View_Modle/Services_Oder_Tab_Contrller.dart';

class ServicesItemTab extends StatefulWidget {
  String NameServices;
  String TypeServices;
  String Imageof;

  ServicesItemTab({
    Key? key,
    required this.Imageof,
    required this.NameServices,
    required this.TypeServices,
  }) : super(key: key);

  @override
  State<ServicesItemTab> createState() => _ServicesItemTabState();
}

class _ServicesItemTabState extends State<ServicesItemTab> {
  late String Name;
  late String Oder_Address;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gitin();
  }

  Future<void> gitin() async {
    final re = await FirebaseDatabase.instance
        .ref()
        .child('Users')
        .child(FirebaseAuth.instance.currentUser!.uid.toString())
        .get();
    Name = re.child('name').value.toString();
    Oder_Address = re.child('address').value.toString();
    print(Name);
  }

  @override
  Widget build(BuildContext context) {
    // List<String> matchQuery = [];
    // for (var fruit in searchTerms) {
    //   if (fruit.toLowerCase().contains(query.toLowerCase())) {
    //     matchQuery.add(fruit);
    //   }
    // }

    final ref = FirebaseDatabase.instance.ref().child('Services');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kPrimaryColor,
        title: Text(
          widget.NameServices,
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: AppColors.whiteColor),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
              query: ref,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
 int UserRate = snapshot.child('rate').value as int;
 int UserReview = snapshot.child('review').value as int;
 double tole = ( UserRate / ( UserReview * 5.0)) * 5.0;





                if (snapshot.child("Type_Services").value ==
                        widget.TypeServices &&
                    snapshot.child('Name_Services').value.toString() ==
                        widget.NameServices) {
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: Container(
                            child: ClipRRect(
                              child: Image.asset(widget.Imageof.toString()),
                            ),
                          ),
                          subtitle: Text(
                              snapshot.child('Name_Services').value.toString()),
                          title: Text(
                              snapshot.child('User_Name').value.toString()),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Text(
                            'Address  : ' +
                                snapshot.child('User_Address').value.toString(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Text('Price  : ' +
                              snapshot.child('price').value.toString()),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      if(tole != null )
                      Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text('Rate  : '+tole.toString()),
                      )else Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Text('Rate  :  0.0'),
                        ),
                        SizedBox(height: 10,)
                        ,
                      SizedBox(height: 10,),

                      if (snapshot.child('review').value != 0)
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: RatingBar.builder(
                            itemSize: 20.0,
                            initialRating: tole, ///
                            minRating: tole,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,size: 14,
                              color: AppColors.kPrimaryColor,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                        )else
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: RatingBar.builder(
                            itemSize: 20,
                            initialRating: 0, ///
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: AppColors.kPrimaryColor,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                        )
                        ,
                        SizedBox(height: 10,),
                        ChangeNotifierProvider(
                            create: (_) => OderServices(),
                            child: Consumer<OderServices>(
                                builder: (context, provider, child) {
                              return RoundButton(
                                title: 'Order',
                                onPrass: () {
                                  provider.Oder(
                                      context,
                                      snapshot.child('time').value.toString(),
                                      snapshot
                                          .child('User_Uid')
                                          .value
                                          .toString(),
                                      snapshot.child('price').value.toString(),
                                      FirebaseAuth.instance.currentUser!.uid
                                          .toString(),
                                      'Not_Complete',
                                      snapshot
                                          .child("User_Address")
                                          .value
                                          .toString(),
                                      0,
                                      widget.Imageof.toString(),
                                      Name.toString(),
                                      snapshot
                                          .child('User_Name')
                                          .value
                                          .toString(),
                                      widget.NameServices,
                                      Oder_Address);
                                },
                                color: AppColors.kPrimaryColor,
                                loading: provider.loading,
                              );
                            })),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
