import 'package:flutter/material.dart';
import 'package:project_v3/Database/db_ApproveOrders.dart';
import 'package:project_v3/Database/db_Employee.dart';
import 'package:project_v3/Database/db_leave_request.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/routes.dart';

class adminHome extends StatelessWidget {
  const adminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // DatabaseHelper.instance.Temp_Query();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          shape: Border(
            bottom: BorderSide(
              color: MyColors.scarlet,
              width: MyScreen.getScreenHeight(context) * (4 / 1063.6),
            ),
          ),
          title: Text("Sync Successful",
              style: TextStyle(
                  color: MyColors.scarlet,
                  fontSize: MyScreen.getScreenHeight(context) * (20 / 1063.6))),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.menu,
                color: MyColors.scarlet,
                size: MyScreen.getScreenHeight(context) * (30 / 1063.6)),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          actions: [
            Material(
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    color: MyColors.richBlackFogra,
                  ),
                  child: Icon(Icons.sync,
                      color: MyColors.scarlet,
                      size: MyScreen.getScreenHeight(context) * (30 / 1063.6)),
                ),
                onTap: () {
                  // Navigator.pop(context, true);
                },
              ),
            ),
          ],
          backgroundColor: MyColors.richBlackFogra,
        ),
        backgroundColor: MyColors.richBlackFogra,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: MyScreen.getScreenHeight(context) * (25 / 1063.6),
                ),
                // Outer Shell
                Container(
                  padding: EdgeInsets.fromLTRB(
                      MyScreen.getScreenWidth(context) * (10 / 490.9),
                      MyScreen.getScreenHeight(context) * (5 / 1063.6),
                      MyScreen.getScreenWidth(context) * (10 / 490.9),
                      MyScreen.getScreenHeight(context) * (5 / 1063.6)),
                  height: MyScreen.getScreenHeight(context) * (139 / 1063.6),
                  width: MyScreen.getScreenWidth(context) * (460 / 490.9),
                  decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(
                        MyScreen.getScreenHeight(context) * (15 / 1063.6))),
                  ),
                  child: Column(
                    children: [
                      // Order Summary
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.timeline,
                                textDirection: TextDirection.rtl,
                                size: MyScreen.getScreenHeight(context) *
                                    (30 / 1063.6),
                                color: MyColors.black,
                              ),
                              SizedBox(
                                width: MyScreen.getScreenWidth(context) *
                                    (10 / 490.9),
                              ),
                              Text("Order Summary",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize:
                                        MyScreen.getScreenHeight(context) *
                                            (22 / 1063.6),
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.black,
                                  )),
                              SizedBox(
                                width: MyScreen.getScreenWidth(context) *
                                    (12 / 490.9),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: MyScreen.getScreenWidth(context) *
                                (172 / 490.9),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, MyRoutes.MySalesOrder);
                            },
                            child: Text("View All",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (12 / 1063.6),
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.black,
                                )),
                          ),
                        ],
                      ),
                      // Underline
                      Container(
                        color: MyColors.black,
                        height:
                            MyScreen.getScreenHeight(context) * (3 / 1063.6),
                      ),
                      // White Space
                      SizedBox(
                        height:
                            MyScreen.getScreenHeight(context) * (10 / 1063.6),
                      ),
                      // Main
                      SizedBox(
                        height:
                            MyScreen.getScreenHeight(context) * (86 / 1063.6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: MyScreen.getScreenWidth(context) *
                                        (53 / 490.9),
                                    height: MyScreen.getScreenWidth(context) *
                                        (53 / 490.9),
                                    decoration: BoxDecoration(
                                      color: MyColors.scarlet,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              MyScreen.getScreenHeight(
                                                      context) *
                                                  (10 / 1063.6))),
                                    ),
                                    child: Icon(
                                      Icons.timelapse,
                                      size: MyScreen.getScreenHeight(context) *
                                          (30 / 1063.6),
                                      color: MyColors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: MyScreen.getScreenHeight(context) *
                                        (2 / 1063.6),
                                  ),
                                  Text("Processing Orders",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize:
                                            MyScreen.getScreenHeight(context) *
                                                (12 / 1063.6),
                                        fontWeight: FontWeight.bold,
                                        color: MyColors.black,
                                      )),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: MyScreen.getScreenWidth(context) *
                                        (53 / 490.9),
                                    height: MyScreen.getScreenWidth(context) *
                                        (53 / 490.9),
                                    decoration: BoxDecoration(
                                      color: MyColors.scarlet,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              MyScreen.getScreenHeight(
                                                      context) *
                                                  (10 / 1063.6))),
                                    ),
                                    child: Icon(
                                      Icons.radio_button_checked,
                                      size: MyScreen.getScreenHeight(context) *
                                          (30 / 1063.6),
                                      color: MyColors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: MyScreen.getScreenWidth(context) *
                                        (2 / 490.9),
                                  ),
                                  Text("Fulfilled Orders",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize:
                                            MyScreen.getScreenHeight(context) *
                                                (12 / 1063.6),
                                        fontWeight: FontWeight.bold,
                                        color: MyColors.black,
                                      )),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                var _pendingOrders = Database_ApproveOrders();
                                if (await _pendingOrders.getPendingOrders()) {
                                  Navigator.pushNamed(
                                      context, MyRoutes.MyApproveOrder);
                                }
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: MyScreen.getScreenWidth(context) *
                                        (53 / 490.9),
                                    height: MyScreen.getScreenWidth(context) *
                                        (53 / 490.9),
                                    decoration: BoxDecoration(
                                      color: MyColors.scarlet,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              MyScreen.getScreenHeight(
                                                      context) *
                                                  (10 / 1063.6))),
                                    ),
                                    child: Icon(
                                      Icons.timer,
                                      size: MyScreen.getScreenHeight(context) *
                                          (30 / 1063.6),
                                      color: MyColors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: MyScreen.getScreenWidth(context) *
                                        (2 / 490.9),
                                  ),
                                  Text("Pending Orders",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize:
                                            MyScreen.getScreenHeight(context) *
                                                (12 / 1063.6),
                                        fontWeight: FontWeight.bold,
                                        color: MyColors.black,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MyScreen.getScreenHeight(context) * (25 / 1063.6),
                ),
                // Outer Shell
                Container(
                  padding: EdgeInsets.fromLTRB(
                      MyScreen.getScreenWidth(context) * (10 / 490.9),
                      MyScreen.getScreenHeight(context) * (5 / 1063.6),
                      MyScreen.getScreenWidth(context) * (10 / 490.9),
                      MyScreen.getScreenHeight(context) * (5 / 1063.6)),
                  height: MyScreen.getScreenHeight(context) * (139 / 1063.6),
                  width: MyScreen.getScreenWidth(context) * (460 / 490.9),
                  decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(
                        MyScreen.getScreenHeight(context) * (15 / 1063.6))),
                  ),
                  child: Column(
                    children: [
                      // Employee Master
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.work,
                                textDirection: TextDirection.rtl,
                                size: MyScreen.getScreenHeight(context) *
                                    (30 / 1063.6),
                                color: MyColors.black,
                              ),
                              SizedBox(
                                width: MyScreen.getScreenWidth(context) *
                                    (10 / 490.9),
                              ),
                              Text("Employee Master",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize:
                                        MyScreen.getScreenHeight(context) *
                                            (22 / 1063.6),
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.black,
                                  )),
                            ],
                          ),
                          SizedBox(
                            width: MyScreen.getScreenWidth(context) *
                                (172 / 490.9),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text("View All",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (12 / 1063.6),
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.black,
                                )),
                          ),
                        ],
                      ),
                      // Underline
                      Container(
                        color: MyColors.black,
                        height:
                            MyScreen.getScreenHeight(context) * (3 / 1063.6),
                      ),
                      // White space
                      SizedBox(
                        height:
                            MyScreen.getScreenHeight(context) * (10 / 1063.6),
                      ),
                      // Main
                      SizedBox(
                        height:
                            MyScreen.getScreenHeight(context) * (86 / 1063.6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, MyRoutes.MySignUpEmail);
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: MyScreen.getScreenWidth(context) *
                                        (53 / 490.9),
                                    height: MyScreen.getScreenWidth(context) *
                                        (53 / 490.9),
                                    decoration: BoxDecoration(
                                      color: MyColors.scarlet,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              MyScreen.getScreenHeight(
                                                      context) *
                                                  (10 / 1063.6))),
                                    ),
                                    child: Icon(
                                      Icons.group_add,
                                      size: MyScreen.getScreenHeight(context) *
                                          (30 / 1063.6),
                                      color: MyColors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: MyScreen.getScreenHeight(context) *
                                        (2 / 1063.6),
                                  ),
                                  Text("Add Employee",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize:
                                            MyScreen.getScreenHeight(context) *
                                                (12 / 1063.6),
                                        fontWeight: FontWeight.bold,
                                        color: MyColors.black,
                                      )),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                if (await Database_leaveRequest()
                                    .getAllRequest()) {
                                  Navigator.pushNamed(
                                      context, MyRoutes.MyLeaveRequest);
                                }
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: MyScreen.getScreenWidth(context) *
                                        (53 / 490.9),
                                    height: MyScreen.getScreenWidth(context) *
                                        (53 / 490.9),
                                    decoration: BoxDecoration(
                                      color: MyColors.scarlet,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              MyScreen.getScreenHeight(
                                                      context) *
                                                  (10 / 1063.6))),
                                    ),
                                    child: Icon(
                                      Icons.work_off,
                                      size: MyScreen.getScreenHeight(context) *
                                          (30 / 1063.6),
                                      color: MyColors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: MyScreen.getScreenWidth(context) *
                                        (2 / 490.9),
                                  ),
                                  Text("Leave Requests",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize:
                                            MyScreen.getScreenHeight(context) *
                                                (12 / 1063.6),
                                        fontWeight: FontWeight.bold,
                                        color: MyColors.black,
                                      )),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                var _db_employee = Database_signUp();
                                if (await _db_employee.getAllEmp()) {
                                  print(Database_signUp.emps);
                                  Navigator.pushNamed(
                                      context, MyRoutes.MyEditEmployeeScreen);
                                }
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: MyScreen.getScreenWidth(context) *
                                        (53 / 490.9),
                                    height: MyScreen.getScreenWidth(context) *
                                        (53 / 490.9),
                                    decoration: BoxDecoration(
                                      color: MyColors.scarlet,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              MyScreen.getScreenHeight(
                                                      context) *
                                                  (10 / 1063.6))),
                                    ),
                                    child: Icon(
                                      Icons.edit_location,
                                      size: MyScreen.getScreenHeight(context) *
                                          (30 / 1063.6),
                                      color: MyColors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: MyScreen.getScreenWidth(context) *
                                        (2 / 490.9),
                                  ),
                                  Text("Edit Employee",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize:
                                            MyScreen.getScreenHeight(context) *
                                                (12 / 1063.6),
                                        fontWeight: FontWeight.bold,
                                        color: MyColors.black,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MyScreen.getScreenHeight(context) * (25 / 1063.6),
                ),
                // Outer Shell
                Container(
                  padding: EdgeInsets.fromLTRB(
                      MyScreen.getScreenWidth(context) * (10 / 490.9),
                      MyScreen.getScreenHeight(context) * (5 / 1063.6),
                      MyScreen.getScreenWidth(context) * (10 / 490.9),
                      MyScreen.getScreenHeight(context) * (5 / 1063.6)),
                  height: MyScreen.getScreenHeight(context) * (139 / 1063.6),
                  width: MyScreen.getScreenWidth(context) * (460 / 490.9),
                  decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(
                        MyScreen.getScreenHeight(context) * (15 / 1063.6))),
                  ),
                  child: Column(
                    children: [
                      // Item Master
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.view_carousel,
                                textDirection: TextDirection.rtl,
                                size: MyScreen.getScreenHeight(context) *
                                    (30 / 1063.6),
                                color: MyColors.black,
                              ),
                              SizedBox(
                                width: MyScreen.getScreenWidth(context) *
                                    (10 / 490.9),
                              ),
                              Text("Item Master",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize:
                                        MyScreen.getScreenHeight(context) *
                                            (22 / 1063.6),
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.black,
                                  )),
                              SizedBox(
                                width: MyScreen.getScreenWidth(context) *
                                    (42 / 490.9),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: MyScreen.getScreenWidth(context) *
                                (172 / 490.9),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text("View All",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (12 / 1063.6),
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.black,
                                )),
                          ),
                        ],
                      ),
                      // Underline
                      Container(
                        color: MyColors.black,
                        height:
                            MyScreen.getScreenHeight(context) * (3 / 1063.6),
                      ),
                      // White space
                      SizedBox(
                        height:
                            MyScreen.getScreenHeight(context) * (10 / 1063.6),
                      ),
                      // Main
                      SizedBox(
                        height:
                            MyScreen.getScreenHeight(context) * (86 / 1063.6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, MyRoutes.MyLeaveRequestForm);
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: MyScreen.getScreenWidth(context) *
                                        (53 / 490.9),
                                    height: MyScreen.getScreenWidth(context) *
                                        (53 / 490.9),
                                    decoration: BoxDecoration(
                                      color: MyColors.scarlet,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              MyScreen.getScreenHeight(
                                                      context) *
                                                  (10 / 1063.6))),
                                    ),
                                    child: Icon(
                                      Icons.all_inbox,
                                      size: MyScreen.getScreenHeight(context) *
                                          (30 / 1063.6),
                                      color: MyColors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: MyScreen.getScreenHeight(context) *
                                        (2 / 1063.6),
                                  ),
                                  Text("Add Item",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize:
                                            MyScreen.getScreenHeight(context) *
                                                (12 / 1063.6),
                                        fontWeight: FontWeight.bold,
                                        color: MyColors.black,
                                      )),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: MyScreen.getScreenWidth(context) *
                                        (53 / 490.9),
                                    height: MyScreen.getScreenWidth(context) *
                                        (53 / 490.9),
                                    decoration: BoxDecoration(
                                      color: MyColors.scarlet,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              MyScreen.getScreenHeight(
                                                      context) *
                                                  (10 / 1063.6))),
                                    ),
                                    child: Icon(
                                      Icons.show_chart,
                                      size: MyScreen.getScreenHeight(context) *
                                          (30 / 1063.6),
                                      color: MyColors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: MyScreen.getScreenWidth(context) *
                                        (2 / 490.9),
                                  ),
                                  Text("Analytic Report",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize:
                                            MyScreen.getScreenHeight(context) *
                                                (12 / 1063.6),
                                        fontWeight: FontWeight.bold,
                                        color: MyColors.black,
                                      )),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: MyScreen.getScreenWidth(context) *
                                        (53 / 490.9),
                                    height: MyScreen.getScreenWidth(context) *
                                        (53 / 490.9),
                                    decoration: BoxDecoration(
                                      color: MyColors.scarlet,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              MyScreen.getScreenHeight(
                                                      context) *
                                                  (10 / 1063.6))),
                                    ),
                                    child: Icon(
                                      Icons.swap_horiz,
                                      size: MyScreen.getScreenHeight(context) *
                                          (30 / 1063.6),
                                      color: MyColors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: MyScreen.getScreenWidth(context) *
                                        (2 / 490.9),
                                  ),
                                  Text("Inventory",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize:
                                            MyScreen.getScreenHeight(context) *
                                                (12 / 1063.6),
                                        fontWeight: FontWeight.bold,
                                        color: MyColors.black,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
