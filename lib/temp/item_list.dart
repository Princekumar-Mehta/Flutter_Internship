import 'package:flutter/material.dart';

class item_list extends StatefulWidget {
  const item_list({Key? key}) : super(key: key);

  @override
  _item_listState createState() => _item_listState();
}

class _item_listState extends State<item_list> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        body:Container(
          constraints: BoxConstraints(
            maxHeight: 100,
            maxWidth: 100,
          ),
          child:GridView.count(
            padding:EdgeInsets.all(0),
            crossAxisCount:2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 8,
            children:List.generate(10, (index){
              return Text("hello $index");
            }),
          ),
        ),
      ),
    );
  }
}