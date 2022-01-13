import "package:flutter/material.dart";
import 'package:catalog_app/models/catalog.dart';
import 'package:catalog_app/utils/routes.dart';
import 'package:catalog_app/widgets/drawer.dart';
import 'package:catalog_app/widgets/item_widget.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState(){
    loadData();
  }
  loadData() async{
    await Future.delayed(Duration(seconds: 2));
    var catalogJson = await rootBundle.loadString("assets/files/catalog.json");
    var decodedData = jsonDecode(catalogJson);
    var productsData = decodedData['products'];
    CatalogModel.items = List.from(productsData)
        .map<Item>((item)=>Item.fromMap(item))
        .toList();
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    final dummyItems= List.generate((50), (index) => CatalogModel.items[0]);
    return Container(
        child: Scaffold(
          appBar: AppBar(
            title:Text("Catalog App"),
          ),
          body:
          Padding(
            padding: const EdgeInsets.all(16.0),
            child:  (CatalogModel.items!= null && CatalogModel.items.isNotEmpty)?
            ListView.builder(
              itemCount: CatalogModel.items.length,
              itemBuilder: (context,index){
                return ItemWidget(item: CatalogModel.items[index],);
              },
            ):
            Center(
                child: CircularProgressIndicator()
            ),
          ),
          drawer : MyDrawer(),
        )
    );
  }
}
