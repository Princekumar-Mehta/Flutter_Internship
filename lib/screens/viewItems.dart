import 'package:flutter/material.dart';
import 'package:project_v3/Database/db_item.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';

import 'EditItem.dart';

class ViewItems extends StatefulWidget {
  @override
  _ViewItemsState createState() => _ViewItemsState();
}

class _ViewItemsState extends State<ViewItems> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: MyDrawer.emp.darkTheme == 1
                  ? MyColors.white
                  : MyColors.scarlet,
              size: MyScreen.getScreenHeight(context) * (30 / 1063.6)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Select Item to Edit",
            style: TextStyle(
                color: MyDrawer.emp.darkTheme == 1
                    ? MyColors.white
                    : MyColors.scarlet,
                fontSize: MyScreen.getScreenHeight(context) * (20 / 1063.6))),
        centerTitle: true,
        shape: Border(
          bottom: BorderSide(
            color: MyColors.scarlet,
            width: MyScreen.getScreenHeight(context) * (4 / 1063.6),
          ),
        ),
        backgroundColor: MyDrawer.emp.darkTheme == 1
            ? MyColors.richBlackFogra
            : MyColors.white,
      ),
      backgroundColor: MyDrawer.emp.darkTheme == 1
          ? MyColors.richBlackFogra
          : MyColors.white,
      body: SingleChildScrollView(
        child: Theme(
          data: ThemeData(
            unselectedWidgetColor: MyDrawer.emp.darkTheme == 1
                ? MyColors.middleRed
                : MyColors.scarlet,
          ),
          child: Column(
            children: [
              Divider(
                color: MyDrawer.emp.darkTheme == 1
                    ? MyColors.pewterBlue
                    : MyColors.black,
                indent: 15,
                endIndent: 15,
                thickness: 1,
              ),
              ListView.builder(
                  padding: const EdgeInsets.all(12),
                  shrinkWrap: true,
                  itemCount: Database_Item.items.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: _row(index),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  _row(int key) {
    return Row(
      children: [
        Container(
          width: 300,
          child: ListTile(
            title: Text(
                Database_Item.items[key].code.toString() +
                    "\t" +
                    Database_Item.items[key].item_Name.toString(),
                style: TextStyle(
                    fontSize: 20,
                    color: MyDrawer.emp.darkTheme == 1
                        ? MyColors.pewterBlue
                        : MyColors.black)),
            onTap: () async {
              print(Database_Item.items[key].item_Name);
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditItem(
                            item: Database_Item.items[key],
                          )));
            },
          ),
        )
      ],
    );
  }
}
