import 'package:flutter/material.dart';
import 'package:project_v3/Database/db_ApproveOrders.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';

class ApproveOrder extends StatefulWidget {
  const ApproveOrder({Key? key}) : super(key: key);

  @override
  State<ApproveOrder> createState() => _ApproveOrderState();
}

class _ApproveOrderState extends State<ApproveOrder> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(
            color: MyColors.scarlet,
            width: MyScreen.getScreenHeight(context) * (4 / 1063.6),
          ),
        ),
        title: Text("Approve Orders",
            style: TextStyle(
                color: MyColors.white,
                fontSize: MyScreen.getScreenHeight(context) * (20 / 1063.6))),
        centerTitle: true,
        /*leading: IconButton(
            icon: Icon(Icons.menu,
                color: MyColors.scarlet,
                size: MyScreen.getScreenHeight(context) * (30 / 1063.6)),
            onPressed: () {},
          ),*/
        backgroundColor: MyColors.richBlackFogra,
      ),
      drawer: MyDrawer(),
      backgroundColor: MyColors.richBlackFogra,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              MyScreen.getScreenWidth(context) * (20 / 490.9),
              MyScreen.getScreenHeight(context) * (20 / 1063.6),
              MyScreen.getScreenWidth(context) * (20 / 490.9),
              MyScreen.getScreenHeight(context) * (20 / 1063.6)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: Database_ApproveOrders.pendingOrders.length,
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
    return Column(children: [
      Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: MyColors.grey,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            width: MyScreen.getScreenWidth(context) * (450 / 490.9),
            height: MyScreen.getScreenHeight(context) * (160 / 1063.6),
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
                      Container(
                        width: MyScreen.getScreenWidth(context) * (50 / 490.9),
                        height: MyScreen.getScreenWidth(context) * (50 / 490.9),
                        color: MyColors.richBlackFogra,
                        child: Icon(
                          Icons.person,
                          color: MyColors.white,
                          size:
                              MyScreen.getScreenHeight(context) * (35 / 1063.6),
                        ),
                      ),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (10 / 490.9),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                Database_ApproveOrders
                                    .shipping_Branches[key].branch_Name!,
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
                              Icon(
                                Icons.location_on,
                                size: MyScreen.getScreenHeight(context) *
                                    (18 / 1063.6),
                              ),
                              Text(
                                Database_ApproveOrders
                                        .shipping_Branches[key].city! +
                                    "," +
                                    Database_ApproveOrders
                                        .shipping_Branches[key].state!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (13 / 1063.6),
                                ),
                              ),
                              SizedBox(
                                width: MyScreen.getScreenWidth(context) *
                                    (125 / 490.9),
                              ),
                              InkWell(
                                child: Text(
                                  "View Order",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MyScreen.getScreenHeight(context) *
                                            (13 / 1063.6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    color: MyColors.richBlackFogra,
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
                              "2000",
                              style: TextStyle(
                                color: MyColors.red,
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
                            "Total\nPending",
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
                                MyScreen.getScreenWidth(context) * (40 / 490.9),
                            height:
                                MyScreen.getScreenWidth(context) * (40 / 490.9),
                            color: MyColors.richBlackFogra,
                            child: Text(
                              "10",
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
                            "Credit\nDays",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (15 / 1063.6),
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        child: Container(
                          width:
                              MyScreen.getScreenWidth(context) * (40 / 490.9),
                          height:
                              MyScreen.getScreenWidth(context) * (40 / 490.9),
                          color: MyColors.pewterBlue,
                          child: Icon(
                            Icons.cancel,
                            color: MyColors.richBlackFogra,
                            size: MyScreen.getScreenHeight(context) *
                                (30 / 1063.6),
                          ),
                        ),
                      ),
                      InkWell(
                        child: Container(
                          width:
                              MyScreen.getScreenWidth(context) * (40 / 490.9),
                          height:
                              MyScreen.getScreenWidth(context) * (40 / 490.9),
                          color: MyColors.scarlet,
                          child: Icon(
                            Icons.check,
                            color: MyColors.richBlackFogra,
                            size: MyScreen.getScreenHeight(context) *
                                (30 / 1063.6),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: MyColors.richBlackFogra,
                    height: MyScreen.getScreenHeight(context) * (2 / 1063.6),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text(
                            "XXXX.XX",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (13 / 1063.6),
                            ),
                          ),
                          Text(
                            " Total Pending",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (13 / 1063.6),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (130 / 490.9),
                      ),
                      Text(
                        "Deliver By: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:
                              MyScreen.getScreenHeight(context) * (13 / 1063.6),
                        ),
                      ),
                      Text(
                        "DD/MM/YYYY",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:
                              MyScreen.getScreenHeight(context) * (13 / 1063.6),
                        ),
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
