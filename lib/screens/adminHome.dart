import 'package:flutter/material.dart';
import 'package:project_v3/Database/db_ApproveOrders.dart';
import 'package:project_v3/Database/db_Employee.dart';
import 'package:project_v3/Database/db_leave_request.dart';
import 'package:project_v3/Database/db_report.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/routes.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  bool viewAll1 = false;
  bool viewAll2 = false;
  bool viewAll3 = false;
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    // DatabaseHelper.instance.Temp_Query();
    return Scaffold(
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(
            color: MyColors.scarlet,
            width: MyScreen.getScreenHeight(context) * (4 / 1063.6),
          ),
        ),
        title: Text("Admin Home",
            style: TextStyle(
                color: MyColors.white,
                fontSize: MyScreen.getScreenHeight(context) * (20 / 1063.6))),
        centerTitle: true,
        actions: [
          Material(
            child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                  color: MyColors.richBlackFogra,
                ),
                child: Icon(Icons.sync,
                    color: MyColors.white,
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
      drawer: MyDrawer(),
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
              AnimatedContainer(
                duration: const Duration(milliseconds: 0),
                height: viewAll1
                    ? MyScreen.getScreenHeight(context) * (278 / 1063.6)
                    : MyScreen.getScreenHeight(context) * (159 / 1063.6),
                padding: EdgeInsets.fromLTRB(
                    MyScreen.getScreenWidth(context) * (10 / 490.9),
                    MyScreen.getScreenHeight(context) * (5 / 1063.6),
                    MyScreen.getScreenWidth(context) * (10 / 490.9),
                    MyScreen.getScreenHeight(context) * (5 / 1063.6)),
                //height: MyScreen.getScreenHeight(context) * (139 / 1063.6),
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
                                  fontSize: MyScreen.getScreenHeight(context) *
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
                          width:
                              MyScreen.getScreenWidth(context) * (172 / 490.9),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              viewAll1 = !viewAll1;
                              viewAll2 = false;
                              viewAll3 = false;
                            });
                            //Navigator.pushNamed(context, MyRoutes.MySalesOrder);
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
                      height: MyScreen.getScreenHeight(context) * (3 / 1063.6),
                    ),
                    // White Space
                    SizedBox(
                      height: MyScreen.getScreenHeight(context) * (20 / 1063.6),
                    ),
                    // Main
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: MyScreen.getScreenHeight(context) *
                                  (86 / 1063.6),
                              width: MyScreen.getScreenWidth(context) *
                                  ((440 / 3) / 490.9),
                              child: InkWell(
                                onTap: () async {
                                  var _pendingOrders = Database_ApproveOrders();
                                  if (await _pendingOrders.getProcessingOrders(
                                      MyDrawer.emp.id!, MyDrawer.emp.role!)) {
                                    Navigator.pushNamed(
                                        context, MyRoutes.MyProcessingOrders);
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
                                        Icons.timelapse,
                                        size:
                                            MyScreen.getScreenHeight(context) *
                                                (30 / 1063.6),
                                        color: MyColors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MyScreen.getScreenHeight(context) *
                                              (2 / 1063.6),
                                    ),
                                    Text("Processing Orders",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: MyScreen.getScreenHeight(
                                                  context) *
                                              (12 / 1063.6),
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.black,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: MyScreen.getScreenHeight(context) *
                                  (86 / 1063.6),
                              width: MyScreen.getScreenWidth(context) *
                                  ((440 / 3) / 490.9),
                              child: InkWell(
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
                                        size:
                                            MyScreen.getScreenHeight(context) *
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
                                          fontSize: MyScreen.getScreenHeight(
                                                  context) *
                                              (12 / 1063.6),
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.black,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: MyScreen.getScreenHeight(context) *
                                  (86 / 1063.6),
                              width: MyScreen.getScreenWidth(context) *
                                  ((440 / 3) / 490.9),
                              child: InkWell(
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
                                        size:
                                            MyScreen.getScreenHeight(context) *
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
                                          fontSize: MyScreen.getScreenHeight(
                                                  context) *
                                              (12 / 1063.6),
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.black,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        viewAll1
                            ? SizedBox(
                                height: MyScreen.getScreenHeight(context) *
                                    (30 / 1063.6),
                              )
                            : Container(),
                        viewAll1
                            ? Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: MyScreen.getScreenHeight(context) *
                                        (86 / 1063.6),
                                    width: MyScreen.getScreenWidth(context) *
                                        ((440 / 3) / 490.9),
                                    child: InkWell(
                                      onTap: () async {
                                        var _pendingOrders =
                                            Database_ApproveOrders();
                                        if (await _pendingOrders
                                            .getProcessingOrders(
                                                MyDrawer.emp.id!,
                                                MyDrawer.emp.role!)) {
                                          Navigator.pushNamed(context,
                                              MyRoutes.MyProcessingOrders);
                                        }
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: MyScreen.getScreenWidth(
                                                    context) *
                                                (53 / 490.9),
                                            height: MyScreen.getScreenWidth(
                                                    context) *
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
                                              size: MyScreen.getScreenHeight(
                                                      context) *
                                                  (30 / 1063.6),
                                              color: MyColors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: MyScreen.getScreenHeight(
                                                    context) *
                                                (2 / 1063.6),
                                          ),
                                          Text("Processing Orders",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize:
                                                    MyScreen.getScreenHeight(
                                                            context) *
                                                        (12 / 1063.6),
                                                fontWeight: FontWeight.bold,
                                                color: MyColors.black,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: MyScreen.getScreenHeight(context) *
                                        (86 / 1063.6),
                                    width: MyScreen.getScreenWidth(context) *
                                        ((440 / 3) / 490.9),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: MyScreen.getScreenWidth(
                                                    context) *
                                                (53 / 490.9),
                                            height: MyScreen.getScreenWidth(
                                                    context) *
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
                                              size: MyScreen.getScreenHeight(
                                                      context) *
                                                  (30 / 1063.6),
                                              color: MyColors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: MyScreen.getScreenWidth(
                                                    context) *
                                                (2 / 490.9),
                                          ),
                                          Text("Fulfilled Orders",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize:
                                                    MyScreen.getScreenHeight(
                                                            context) *
                                                        (12 / 1063.6),
                                                fontWeight: FontWeight.bold,
                                                color: MyColors.black,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: MyScreen.getScreenHeight(context) *
                                        (86 / 1063.6),
                                    width: MyScreen.getScreenWidth(context) *
                                        ((440 / 3) / 490.9),
                                    child: InkWell(
                                      onTap: () async {
                                        var _pendingOrders =
                                            Database_ApproveOrders();
                                        if (await _pendingOrders
                                            .getPendingOrders()) {
                                          Navigator.pushNamed(
                                              context, MyRoutes.MyApproveOrder);
                                        }
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: MyScreen.getScreenWidth(
                                                    context) *
                                                (53 / 490.9),
                                            height: MyScreen.getScreenWidth(
                                                    context) *
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
                                              size: MyScreen.getScreenHeight(
                                                      context) *
                                                  (30 / 1063.6),
                                              color: MyColors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: MyScreen.getScreenWidth(
                                                    context) *
                                                (2 / 490.9),
                                          ),
                                          Text("Pending Orders",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize:
                                                    MyScreen.getScreenHeight(
                                                            context) *
                                                        (12 / 1063.6),
                                                fontWeight: FontWeight.bold,
                                                color: MyColors.black,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MyScreen.getScreenHeight(context) * (25 / 1063.6),
              ),
              // Outer Shell
              AnimatedContainer(
                duration: const Duration(milliseconds: 0),
                height: viewAll2
                    ? MyScreen.getScreenHeight(context) * (278 / 1063.6)
                    : MyScreen.getScreenHeight(context) * (159 / 1063.6),
                padding: EdgeInsets.fromLTRB(
                    MyScreen.getScreenWidth(context) * (10 / 490.9),
                    MyScreen.getScreenHeight(context) * (5 / 1063.6),
                    MyScreen.getScreenWidth(context) * (10 / 490.9),
                    MyScreen.getScreenHeight(context) * (5 / 1063.6)),
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
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (22 / 1063.6),
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.black,
                                )),
                          ],
                        ),
                        SizedBox(
                          width:
                              MyScreen.getScreenWidth(context) * (172 / 490.9),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              viewAll2 = !viewAll2;
                              viewAll1 = false;
                              viewAll3 = false;
                            });
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
                      height: MyScreen.getScreenHeight(context) * (3 / 1063.6),
                    ),
                    // White Space
                    SizedBox(
                      height: MyScreen.getScreenHeight(context) * (20 / 1063.6),
                    ),
                    // Main
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: MyScreen.getScreenHeight(context) *
                                  (86 / 1063.6),
                              width: MyScreen.getScreenWidth(context) *
                                  ((440 / 3) / 490.9),
                              child: InkWell(
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
                                        size:
                                            MyScreen.getScreenHeight(context) *
                                                (30 / 1063.6),
                                        color: MyColors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MyScreen.getScreenHeight(context) *
                                              (2 / 1063.6),
                                    ),
                                    Text("Add Employee",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: MyScreen.getScreenHeight(
                                                  context) *
                                              (12 / 1063.6),
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.black,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: MyScreen.getScreenHeight(context) *
                                  (86 / 1063.6),
                              width: MyScreen.getScreenWidth(context) *
                                  ((440 / 3) / 490.9),
                              child: InkWell(
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
                                        size:
                                            MyScreen.getScreenHeight(context) *
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
                                          fontSize: MyScreen.getScreenHeight(
                                                  context) *
                                              (12 / 1063.6),
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.black,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: MyScreen.getScreenHeight(context) *
                                  (86 / 1063.6),
                              width: MyScreen.getScreenWidth(context) *
                                  ((440 / 3) / 490.9),
                              child: InkWell(
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
                                        size:
                                            MyScreen.getScreenHeight(context) *
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
                                          fontSize: MyScreen.getScreenHeight(
                                                  context) *
                                              (12 / 1063.6),
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.black,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        viewAll2
                            ? SizedBox(
                                height: MyScreen.getScreenHeight(context) *
                                    (30 / 1063.6),
                              )
                            : Container(),
                        viewAll2
                            ? Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: MyScreen.getScreenHeight(context) *
                                        (86 / 1063.6),
                                    width: MyScreen.getScreenWidth(context) *
                                        ((440 / 3) / 490.9),
                                    child: InkWell(
                                      onTap: () async {
                                        var _db_employee = Database_signUp();
                                        if (await _db_employee.getAllEmp()) {
                                          //print(Database_signUp.emps);
                                          Navigator.pushNamed(
                                              context,
                                              MyRoutes
                                                  .MyExploreAttendanceScreen);
                                        }
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: MyScreen.getScreenWidth(
                                                    context) *
                                                (53 / 490.9),
                                            height: MyScreen.getScreenWidth(
                                                    context) *
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
                                              Icons.explore_outlined,
                                              size: MyScreen.getScreenHeight(
                                                      context) *
                                                  (30 / 1063.6),
                                              color: MyColors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: MyScreen.getScreenHeight(
                                                    context) *
                                                (2 / 1063.6),
                                          ),
                                          Text("Explore Attendance",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize:
                                                    MyScreen.getScreenHeight(
                                                            context) *
                                                        (12 / 1063.6),
                                                fontWeight: FontWeight.bold,
                                                color: MyColors.black,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: MyScreen.getScreenHeight(context) *
                                        (86 / 1063.6),
                                    width: MyScreen.getScreenWidth(context) *
                                        ((440 / 3) / 490.9),
                                    child: InkWell(
                                      onTap: () async {
                                        if (await Database_leaveRequest()
                                            .getAllRequestForEmp(
                                                MyDrawer.emp.id!)) {
                                          Navigator.pushNamed(context,
                                              MyRoutes.MyLeaveRequestSummary);
                                        }
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: MyScreen.getScreenWidth(
                                                    context) *
                                                (53 / 490.9),
                                            height: MyScreen.getScreenWidth(
                                                    context) *
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
                                              Icons.summarize_outlined,
                                              size: MyScreen.getScreenHeight(
                                                      context) *
                                                  (30 / 1063.6),
                                              color: MyColors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: MyScreen.getScreenWidth(
                                                    context) *
                                                (2 / 490.9),
                                          ),
                                          Text("My Leave Summary",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize:
                                                    MyScreen.getScreenHeight(
                                                            context) *
                                                        (12 / 1063.6),
                                                fontWeight: FontWeight.bold,
                                                color: MyColors.black,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: MyScreen.getScreenHeight(context) *
                                        (86 / 1063.6),
                                    width: MyScreen.getScreenWidth(context) *
                                        ((440 / 3) / 490.9),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                            MyRoutes.MyLeaveRequestForm);
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: MyScreen.getScreenWidth(
                                                    context) *
                                                (53 / 490.9),
                                            height: MyScreen.getScreenWidth(
                                                    context) *
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
                                              Icons.pending_actions_outlined,
                                              size: MyScreen.getScreenHeight(
                                                      context) *
                                                  (30 / 1063.6),
                                              color: MyColors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: MyScreen.getScreenWidth(
                                                    context) *
                                                (2 / 490.9),
                                          ),
                                          Text("Apply for Leave",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize:
                                                    MyScreen.getScreenHeight(
                                                            context) *
                                                        (12 / 1063.6),
                                                fontWeight: FontWeight.bold,
                                                color: MyColors.black,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MyScreen.getScreenHeight(context) * (25 / 1063.6),
              ),
              // Outer Shell
              AnimatedContainer(
                duration: const Duration(milliseconds: 0),
                height: viewAll3
                    ? MyScreen.getScreenHeight(context) * (278 / 1063.6)
                    : MyScreen.getScreenHeight(context) * (159 / 1063.6),
                padding: EdgeInsets.fromLTRB(
                    MyScreen.getScreenWidth(context) * (10 / 490.9),
                    MyScreen.getScreenHeight(context) * (5 / 1063.6),
                    MyScreen.getScreenWidth(context) * (10 / 490.9),
                    MyScreen.getScreenHeight(context) * (5 / 1063.6)),
                //height: MyScreen.getScreenHeight(context) * (139 / 1063.6),
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
                                  fontSize: MyScreen.getScreenHeight(context) *
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
                          width:
                              MyScreen.getScreenWidth(context) * (172 / 490.9),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              viewAll3 = !viewAll3;
                              viewAll2 = false;
                              viewAll1 = false;
                            });
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
                      height: MyScreen.getScreenHeight(context) * (3 / 1063.6),
                    ),
                    // White Space
                    SizedBox(
                      height: MyScreen.getScreenHeight(context) * (20 / 1063.6),
                    ),
                    // Main
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: MyScreen.getScreenHeight(context) *
                                  (86 / 1063.6),
                              width: MyScreen.getScreenWidth(context) *
                                  ((440 / 3) / 490.9),
                              child: InkWell(
                                onTap: () async {
                                  Navigator.pushNamed(
                                      context, MyRoutes.MyAddItemScreen);
                                  // if (await Database_leaveRequest()
                                  //     .getAllRequestForEmp(MyDrawer.emp.id!)) {
                                  //   Navigator.pushNamed(
                                  //       context, MyRoutes.MyLeaveRequestForm);
                                  // }
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
                                        size:
                                            MyScreen.getScreenHeight(context) *
                                                (30 / 1063.6),
                                        color: MyColors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MyScreen.getScreenHeight(context) *
                                              (2 / 1063.6),
                                    ),
                                    Text("Add Item",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: MyScreen.getScreenHeight(
                                                  context) *
                                              (12 / 1063.6),
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.black,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: MyScreen.getScreenHeight(context) *
                                  (86 / 1063.6),
                              width: MyScreen.getScreenWidth(context) *
                                  ((440 / 3) / 490.9),
                              child: InkWell(
                                onTap: () async {
                                  if (await Database_Report()
                                      .getSalesperson_SalesReport()) {
                                    Navigator.pushNamed(
                                        context,
                                        MyRoutes
                                            .MyReportSalesSalespersonWiseScreen1);
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
                                        Icons.show_chart,
                                        size:
                                            MyScreen.getScreenHeight(context) *
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
                                          fontSize: MyScreen.getScreenHeight(
                                                  context) *
                                              (12 / 1063.6),
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.black,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: MyScreen.getScreenHeight(context) *
                                  (86 / 1063.6),
                              width: MyScreen.getScreenWidth(context) *
                                  ((440 / 3) / 490.9),
                              child: InkWell(
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
                                        size:
                                            MyScreen.getScreenHeight(context) *
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
                                          fontSize: MyScreen.getScreenHeight(
                                                  context) *
                                              (12 / 1063.6),
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.black,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        viewAll3
                            ? SizedBox(
                                height: MyScreen.getScreenHeight(context) *
                                    (30 / 1063.6),
                              )
                            : Container(),
                        viewAll3
                            ? Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: MyScreen.getScreenHeight(context) *
                                        (86 / 1063.6),
                                    width: MyScreen.getScreenWidth(context) *
                                        ((440 / 3) / 490.9),
                                    child: InkWell(
                                      onTap: () async {
                                        var _pendingOrders =
                                            Database_ApproveOrders();
                                        if (await _pendingOrders
                                            .getProcessingOrders(
                                                MyDrawer.emp.id!,
                                                MyDrawer.emp.role!)) {
                                          Navigator.pushNamed(context,
                                              MyRoutes.MyProcessingOrders);
                                        }
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: MyScreen.getScreenWidth(
                                                    context) *
                                                (53 / 490.9),
                                            height: MyScreen.getScreenWidth(
                                                    context) *
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
                                              size: MyScreen.getScreenHeight(
                                                      context) *
                                                  (30 / 1063.6),
                                              color: MyColors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: MyScreen.getScreenHeight(
                                                    context) *
                                                (2 / 1063.6),
                                          ),
                                          Text("Processing Orders",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize:
                                                    MyScreen.getScreenHeight(
                                                            context) *
                                                        (12 / 1063.6),
                                                fontWeight: FontWeight.bold,
                                                color: MyColors.black,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: MyScreen.getScreenHeight(context) *
                                        (86 / 1063.6),
                                    width: MyScreen.getScreenWidth(context) *
                                        ((440 / 3) / 490.9),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: MyScreen.getScreenWidth(
                                                    context) *
                                                (53 / 490.9),
                                            height: MyScreen.getScreenWidth(
                                                    context) *
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
                                              size: MyScreen.getScreenHeight(
                                                      context) *
                                                  (30 / 1063.6),
                                              color: MyColors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: MyScreen.getScreenWidth(
                                                    context) *
                                                (2 / 490.9),
                                          ),
                                          Text("Fulfilled Orders",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize:
                                                    MyScreen.getScreenHeight(
                                                            context) *
                                                        (12 / 1063.6),
                                                fontWeight: FontWeight.bold,
                                                color: MyColors.black,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: MyScreen.getScreenHeight(context) *
                                        (86 / 1063.6),
                                    width: MyScreen.getScreenWidth(context) *
                                        ((440 / 3) / 490.9),
                                    child: InkWell(
                                      onTap: () async {
                                        var _pendingOrders =
                                            Database_ApproveOrders();
                                        if (await _pendingOrders
                                            .getPendingOrders()) {
                                          Navigator.pushNamed(
                                              context, MyRoutes.MyApproveOrder);
                                        }
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: MyScreen.getScreenWidth(
                                                    context) *
                                                (53 / 490.9),
                                            height: MyScreen.getScreenWidth(
                                                    context) *
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
                                              size: MyScreen.getScreenHeight(
                                                      context) *
                                                  (30 / 1063.6),
                                              color: MyColors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: MyScreen.getScreenWidth(
                                                    context) *
                                                (2 / 490.9),
                                          ),
                                          Text("Pending Orders",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize:
                                                    MyScreen.getScreenHeight(
                                                            context) *
                                                        (12 / 1063.6),
                                                fontWeight: FontWeight.bold,
                                                color: MyColors.black,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      /*bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),*/
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,*/
    );
  }
}
