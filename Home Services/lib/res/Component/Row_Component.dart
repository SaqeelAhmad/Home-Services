import 'package:flutter/material.dart';







class RowCompoent extends StatelessWidget {
  String title;
  String Value;
  final Icon;
  RowCompoent({Key? key, required this.title,required this.Value,this.Icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon,
        title: Text(title,style: Theme.of(context).textTheme.subtitle2,),
        trailing: Text(Value,style: Theme.of(context).textTheme.subtitle1,),
      ),

    );
  }
}