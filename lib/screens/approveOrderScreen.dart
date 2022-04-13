import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_v3/Database/db_approveOrders.dart';
import 'package:project_v3/Email/send_email.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/screens/viewOrderScreen.dart';

import '../Extras/routes.dart';

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
        shape: Border(
          bottom: BorderSide(
            color: MyColors.scarlet,
            width: MyScreen.getScreenHeight(context) * (4 / 1063.6),
          ),
        ),
        title: Text("Approve Orders",
            style: TextStyle(
                color: MyDrawer.emp.darkTheme == 1
                    ? MyColors.white
                    : MyColors.scarlet,
                fontSize: MyScreen.getScreenHeight(context) * (20 / 1063.6))),
        centerTitle: true,
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
                  itemCount: Database_ApproveOrders.pendingOrders.length,
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
              borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                                  onTap: () async {
                                    final file = File(Database_ApproveOrders
                                        .pendingOrders[key].file_Address);
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                viewOrder(file: file)));
                                  }),
                            ],
                          ),
                        ],
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
                                MyScreen.getScreenWidth(context) * (80 / 490.9),
                            height:
                                MyScreen.getScreenWidth(context) * (40 / 490.9),
                            color: MyColors.richBlackFogra,
                            child: Text(
                              Database_ApproveOrders.customers[key].crd_Amt!
                                  .toString(),
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
                              Database_ApproveOrders.customers[key].crd_Day!
                                  .toString(),
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
                        onTap: () async {
                          if (await Database_ApproveOrders()
                              .CancelFinalOrder(key)) {
                            Send_Mail.send_mail(
                                Database_ApproveOrders.customers[key].email!,
                                "Order Cancelled",
                                "Your Order is Cancelled");
                            Navigator.pop(context);
                            var _pendingOrders = Database_ApproveOrders();
                            if (await _pendingOrders.getPendingOrders()) {
                              Navigator.pushNamed(
                                  context, MyRoutes.MyApproveOrder);
                            }
                          }
                        },
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
                        onTap: () async {
                          if (await Database_ApproveOrders()
                              .ApproveFinalOrder(key)) {
                            Send_Mail.send_mail(
                                Database_ApproveOrders.customers[key].email!,
                                "Order Confirmed",
                                "Your Order is now under processing");
                            Navigator.pop(context);
                            var _pendingOrders = Database_ApproveOrders();
                            if (await _pendingOrders.getPendingOrders()) {
                              Navigator.pushNamed(
                                  context, MyRoutes.MyApproveOrder);
                            }
                          }
                        },
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
                    color: MyColors.black,
                    height: MyScreen.getScreenHeight(context) * (2 / 1063.6),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text(
                            Database_ApproveOrders.pendingOrders[key].total
                                .toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (13 / 1063.6),
                            ),
                          ),
                          Text(
                            " Total",
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
                        Database_ApproveOrders.pendingOrders[key].order_by_date,
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
