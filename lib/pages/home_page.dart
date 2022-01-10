import "package:flutter/material.dart";
import 'package:flutter_app_crash_course_2/models/catalog.dart';
import 'package:flutter_app_crash_course_2/utils/routes.dart';
import 'package:flutter_app_crash_course_2/widgets/drawer.dart';
import 'package:flutter_app_crash_course_2/widgets/item_widget.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final dummyItems= List.generate((50), (index) => CatalogModel.items[0]);
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title:Text("Catalog App"),
        ),
        body: ListView.builder(
          itemCount: dummyItems.length,
          itemBuilder: (context,index){
            return ItemWidget(item: dummyItems[index],);
          },
        ),
        drawer : MyDrawer(),
      )
    );
  }
}
