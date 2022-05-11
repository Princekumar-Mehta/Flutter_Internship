import 'package:flutter/material.dart';
import 'package:project_v3/Database/db_stock.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';

import 'editStock.dart';

class ViewInventory extends StatefulWidget {
  const ViewInventory({Key? key}) : super(key: key);

  @override
  _ViewInventoryState createState() => _ViewInventoryState();
}

class _ViewInventoryState extends State<ViewInventory> {
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
        title: Text("View Inventory",
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
                  itemCount: Database_Stock.stockByEmpId.length,
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

  _row(key) {
    return Column(children: [
      Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color:
                  MyDrawer.emp.darkTheme == 1 ? MyColors.white : MyColors.grey,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            width: MyScreen.getScreenWidth(context) * (450 / 490.9),
            height: MyScreen.getScreenHeight(context) * (100 / 1063.6),
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
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (10 / 490.9),
                      ),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (410 / 490.9),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    Database_Stock.stockItemByEmpId[key].code! +
                                        " - " +
                                        Database_Stock
                                            .stockItemByEmpId[key].item_Name! +
                                        " - " +
                                        Database_Stock
                                            .stockItemByEmpId[key].net_Weight!
                                            .toString() +
                                        "g",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MyScreen.getScreenHeight(context) *
                                              (20 / 1063.6),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () async {
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => EditStock(
                                                    stock: Database_Stock
                                                        .stockByEmpId[key],
                                                  )));
                                    },
                                    child: Container(
                                      alignment: AlignmentDirectional.centerEnd,
                                      child: Text(
                                        "Edit",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MyScreen.getScreenHeight(
                                                  context) *
                                              (16 / 1063.6),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
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
                                MyScreen.getScreenWidth(context) * (70 / 490.9),
                            height:
                                MyScreen.getScreenWidth(context) * (40 / 490.9),
                            color: MyDrawer.emp.darkTheme == 1
                                ? MyColors.grey
                                : MyColors.white,
                            child: Text(
                              Database_Stock.stockByEmpId[key].packet
                                  .toString(),
                              style: TextStyle(
                                color: MyColors.scarlet,
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
                            "Packets",
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
                                MyScreen.getScreenWidth(context) * (70 / 490.9),
                            height:
                                MyScreen.getScreenWidth(context) * (40 / 490.9),
                            color: MyDrawer.emp.darkTheme == 1
                                ? MyColors.grey
                                : MyColors.white,
                            child: Text(
                              Database_Stock.stockByEmpId[key].patti.toString(),
                              style: TextStyle(
                                color: MyColors.scarlet,
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
                            "Pattis",
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
                                MyScreen.getScreenWidth(context) * (70 / 490.9),
                            height:
                                MyScreen.getScreenWidth(context) * (40 / 490.9),
                            color: MyDrawer.emp.darkTheme == 1
                                ? MyColors.grey
                                : MyColors.white,
                            child: Text(
                              Database_Stock.stockByEmpId[key].box.toString(),
                              style: TextStyle(
                                color: MyColors.scarlet,
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
                            "Boxes",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (15 / 1063.6),
                            ),
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
/*
Column(children: [
      Text(Database_Stock.stockItemByEmpId[key].item_Name!),
      Text(Database_Stock.stockByEmpId[key].packet.toString()),
      Text(Database_Stock.stockByEmpId[key].patti.toString()),
      Text(Database_Stock.stockByEmpId[key].box.toString()),
    ]);
*/
