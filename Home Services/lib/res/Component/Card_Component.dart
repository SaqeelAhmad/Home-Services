import 'package:flutter/material.dart';


import 'Round_Button.dart';
import 'Row_Component.dart';




class CardComponent extends StatelessWidget {
  final Buy;
  int plain, invest, retundaily, vaili,total ;
  CardComponent({Key? key,
    required this.plain,
    required this.invest,
    required this.retundaily,
    required this.vaili,
    required this.Buy,
    required this.total}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;

    return Card(
      elevation: 50,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        child: Column(
          children: [
            RowWidget( title:'Plain', value: plain.toString(), ),
            RowWidget(title: 'Invest', value: "${invest.toString()}\$",),
            RowWidget(title: 'Daily Profit', value: '${retundaily}\$',),
            RowWidget(title: 'Valida', value: '${vaili} \  day',),
            Divider(
              height: 20,
              thickness: 2,
              indent: 20,
              endIndent: 0,
              color: Colors.black,

            ),
            RowWidget(title: "Total profit  ", value: "${total}\$"),
            SizedBox(height: height*.02,),
            Container(
              width: 100,
              child: RoundButton(title: 'Buy Now',
                onPrass: Buy,),
            )




          ],
        ),
      ),

    );
  }
}



class RowWidget extends StatelessWidget {
  String title;
    String  value;
   RowWidget({Key? key, required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    return Container(
      child: Row(
        children: [
          Expanded(child: Container()),
          Text(title,style: Theme.of(context).textTheme.bodyText1,),
          SizedBox(width: width*.2,),
          Text(value.toString(),style: Theme.of(context).textTheme.bodyText2,),
          Expanded(child: Container()),
        ],
      ),

    );
  }
}

