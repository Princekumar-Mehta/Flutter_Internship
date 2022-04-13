import 'package:flutter/material.dart';
import 'package:project_v3/Database/db_item.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';

import 'editItem.dart';

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
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            MyScreen.getScreenWidth(context) * (20 / 490.9),
            MyScreen.getScreenHeight(context) * (20 / 1063.6),
            MyScreen.getScreenWidth(context) * (20 / 490.9),
            MyScreen.getScreenHeight(context) * (20 / 1063.6)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: Database_Item.items.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: _row(index),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  _row(int key) {
    return Column(children: [
      Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color:
                  MyDrawer.emp.darkTheme == 1 ? MyColors.white : MyColors.grey,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            width: MyScreen.getScreenWidth(context) * (450 / 490.9),
            height: MyScreen.getScreenHeight(context) * (130 / 1063.6),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  MyScreen.getScreenWidth(context) * (10.0 / 490.9),
                  MyScreen.getScreenHeight(context) * (0 / 1063.6),
                  MyScreen.getScreenWidth(context) * (10.0 / 490.9),
                  MyScreen.getScreenHeight(context) * (0 / 1063.6)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                Database_Item.items[key].code.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (20 / 1063.6),
                                ),
                              ),
                              Text(
                                " : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (20 / 1063.6),
                                ),
                              ),
                              Text(
                                Database_Item.items[key].item_Name.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (20 / 1063.6),
                                ),
                              ),
                              Text(
                                " - ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (20 / 1063.6),
                                ),
                              ),
                              Text(
                                Database_Item.items[key].net_Weight.toString() +
                                    "g",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (20 / 1063.6),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MyScreen.getScreenHeight(context) *
                                (8 / 1063.6),
                          ),
                          Row(
                            children: [
                              Text(
                                "Price: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (17 / 1063.6),
                                ),
                              ),
                              Text(
                                "\u{20B9} ${Database_Item.items[key].price.toString()}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (16 / 1063.6),
                                ),
                              ),
                              SizedBox(
                                width: MyScreen.getScreenWidth(context) *
                                    (280 / 490.9),
                              ),
                              InkWell(
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MyScreen.getScreenHeight(context) *
                                              (16 / 1063.6),
                                    ),
                                  ),
                                  onTap: () async {
                                    print(Database_Item.items[key].item_Name);
                                    //Navigator.pop(context);
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditItem(
                                                  item:
                                                      Database_Item.items[key],
                                                )));
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  /*Container(
                    color: MyColors.black,
                    height: MyScreen.getScreenHeight(context) * (2 / 1063.6),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width:
                                MyScreen.getScreenWidth(context) * (80 / 490.9),
                            height:
                                MyScreen.getScreenWidth(context) * (40 / 490.9),
                            color: MyColors.richBlackFogra,
                            child: Text(
                              Database_Item.items[key].price.toString(),
                              style: TextStyle(
                                color: MyColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6),
                              ),
                            ),
                          ),
                          SizedBox(
                            width:
                                MyScreen.getScreenWidth(context) * (10 / 490.9),
                          ),
                          Text(
                            "Packet",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (15 / 1063.6),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width:
                                MyScreen.getScreenWidth(context) * (80 / 490.9),
                            height:
                                MyScreen.getScreenWidth(context) * (40 / 490.9),
                            color: MyColors.richBlackFogra,
                            child: Text(
                              Database_Item.items[key].price.toString(),
                              style: TextStyle(
                                color: MyColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6),
                              ),
                            ),
                          ),
                          SizedBox(
                            width:
                                MyScreen.getScreenWidth(context) * (10 / 490.9),
                          ),
                          Text(
                            "Patti",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (15 / 1063.6),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width:
                                MyScreen.getScreenWidth(context) * (80 / 490.9),
                            height:
                                MyScreen.getScreenWidth(context) * (40 / 490.9),
                            color: MyColors.richBlackFogra,
                            child: Text(
                              Database_Item.items[key].price.toString(),
                              style: TextStyle(
                                color: MyColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6),
                              ),
                            ),
                          ),
                          SizedBox(
                            width:
                                MyScreen.getScreenWidth(context) * (10 / 490.9),
                          ),
                          Text(
                            "Box",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (15 / 1063.6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),*/
                  Container(
                    color: MyColors.black,
                    height: MyScreen.getScreenHeight(context) * (2 / 1063.6),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Database_Item.items[key].pur_Item.toString() ==
                                      "true" &&
                                  Database_Item.items[key].sell_Item
                                          .toString() ==
                                      "true"
                              ? Row(
                                  children: [
                                    Icon(
                                      Icons.check_box_outlined,
                                      size: MyScreen.getScreenHeight(context) *
                                          (25 / 1063.6),
                                    ),
                                    SizedBox(
                                      width: MyScreen.getScreenWidth(context) *
                                          (10 / 490.9),
                                    ),
                                    Text(
                                      "Available for Purchase",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MyScreen.getScreenHeight(context) *
                                                (16 / 1063.6),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MyScreen.getScreenWidth(context) *
                                          (40 / 490.9),
                                    ),
                                    Icon(
                                      Icons.check_box_outlined,
                                      size: MyScreen.getScreenHeight(context) *
                                          (25 / 1063.6),
                                    ),
                                    SizedBox(
                                      width: MyScreen.getScreenWidth(context) *
                                          (10 / 490.9),
                                    ),
                                    Text(
                                      "Available for Sales",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MyScreen.getScreenHeight(context) *
                                                (16 / 1063.6),
                                      ),
                                    ),
                                  ],
                                )
                              : Database_Item.items[key].pur_Item.toString() ==
                                      "true"
                                  ? Row(
                                      children: [
                                        Icon(
                                          Icons.check_box_outlined,
                                          size: MyScreen.getScreenHeight(
                                                  context) *
                                              (25 / 1063.6),
                                        ),
                                        SizedBox(
                                          width:
                                              MyScreen.getScreenWidth(context) *
                                                  (10 / 490.9),
                                        ),
                                        Text(
                                          "Available for Purchase",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: MyScreen.getScreenHeight(
                                                    context) *
                                                (16 / 1063.6),
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              MyScreen.getScreenWidth(context) *
                                                  (40 / 490.9),
                                        ),
                                        Icon(
                                          Icons
                                              .check_box_outline_blank_outlined,
                                          size: MyScreen.getScreenHeight(
                                                  context) *
                                              (25 / 1063.6),
                                        ),
                                        SizedBox(
                                          width:
                                              MyScreen.getScreenWidth(context) *
                                                  (10 / 490.9),
                                        ),
                                        Text(
                                          "Available for Sales",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: MyScreen.getScreenHeight(
                                                    context) *
                                                (16 / 1063.6),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Database_Item.items[key].sell_Item
                                              .toString() ==
                                          "true"
                                      ? Row(
                                          children: [
                                            Icon(
                                              Icons
                                                  .check_box_outline_blank_outlined,
                                              size: MyScreen.getScreenHeight(
                                                      context) *
                                                  (25 / 1063.6),
                                            ),
                                            SizedBox(
                                              width: MyScreen.getScreenWidth(
                                                      context) *
                                                  (10 / 490.9),
                                            ),
                                            Text(
                                              "Available for Purchase",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    MyScreen.getScreenHeight(
                                                            context) *
                                                        (16 / 1063.6),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MyScreen.getScreenWidth(
                                                      context) *
                                                  (40 / 490.9),
                                            ),
                                            Icon(
                                              Icons.check_box_outlined,
                                              size: MyScreen.getScreenHeight(
                                                      context) *
                                                  (25 / 1063.6),
                                            ),
                                            SizedBox(
                                              width: MyScreen.getScreenWidth(
                                                      context) *
                                                  (10 / 490.9),
                                            ),
                                            Text(
                                              "Available for Sales",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    MyScreen.getScreenHeight(
                                                            context) *
                                                        (16 / 1063.6),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Icon(
                                              Icons
                                                  .check_box_outline_blank_outlined,
                                              size: MyScreen.getScreenHeight(
                                                      context) *
                                                  (25 / 1063.6),
                                            ),
                                            SizedBox(
                                              width: MyScreen.getScreenWidth(
                                                      context) *
                                                  (10 / 490.9),
                                            ),
                                            Text(
                                              "Available for Purchase",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    MyScreen.getScreenHeight(
                                                            context) *
                                                        (16 / 1063.6),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MyScreen.getScreenWidth(
                                                      context) *
                                                  (40 / 490.9),
                                            ),
                                            Icon(
                                              Icons
                                                  .check_box_outline_blank_outlined,
                                              size: MyScreen.getScreenHeight(
                                                      context) *
                                                  (25 / 1063.6),
                                            ),
                                            SizedBox(
                                              width: MyScreen.getScreenWidth(
                                                      context) *
                                                  (10 / 490.9),
                                            ),
                                            Text(
                                              "Available for Sales",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    MyScreen.getScreenHeight(
                                                            context) *
                                                        (16 / 1063.6),
                                              ),
                                            ),
                                          ],
                                        ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        height: MyScreen.getScreenHeight(context) * (20 / 1063.6),
      ),
    ]);
  }
}
