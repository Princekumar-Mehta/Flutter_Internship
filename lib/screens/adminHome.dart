import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:project_v3/Database/db_approveOrders.dart';
import 'package:project_v3/Database/db_employee.dart';
import 'package:project_v3/Database/db_item.dart';
import 'package:project_v3/Database/db_leave_request.dart';
import 'package:project_v3/Database/db_report.dart';
import 'package:project_v3/Database/db_scheme.dart';
import 'package:project_v3/Database/db_stock.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/Extras/routes.dart';
import 'package:project_v3/screens/viewEmployeeScreen.dart';

import 'addScheme.dart';
import 'editEmployeeScreen.dart';
import 'exploreAttendance.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  bool viewAll1 = false;
  bool viewAll2 = false;
  bool viewAll3 = false;
  final TextEditingController _textEditingController = TextEditingController();
  bool isChanged = true;
  var itemList = [
    "Processing Orders",
    "Add Employee",
    "Pending Orders",
    "Fulfilled Orders",
    "Leave Request Form",
    "My Leave Request Summary",
    "Leave Requests",
    "Edit Profile",
    "View Employees",
    "Explore Attendance",
    "Add Item",
    "Analytic Report",
    "View Item",
  ];
  @override
  Widget build(BuildContext context) {
    // DatabaseHelper.instance.Temp_Query();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color:
              MyDrawer.emp.darkTheme == 1 ? MyColors.white : MyColors.scarlet,
        ),
        shape: Border(
          bottom: BorderSide(
            color: MyColors.scarlet,
            width: MyScreen.getScreenHeight(context) * (4 / 1063.6),
          ),
        ),
        title: Text("Admin Home",
            style: TextStyle(
                color: MyDrawer.emp.darkTheme == 1
                    ? MyColors.white
                    : MyColors.scarlet,
                fontSize: MyScreen.getScreenHeight(context) * (20 / 1063.6))),
        centerTitle: true,
        actions: [
          Material(
            child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                  color: MyDrawer.emp.darkTheme == 1
                      ? MyColors.richBlackFogra
                      : MyColors.white,
                ),
                child: Icon(Icons.sync,
                    color: MyDrawer.emp.darkTheme == 1
                        ? MyColors.white
                        : MyColors.scarlet,
                    size: MyScreen.getScreenHeight(context) * (30 / 1063.6)),
              ),
              onTap: () async {
                await Database_Stock.addStockForAllItem(1, "Admin");
                // Navigator.pop(context, true);
              },
            ),
          ),
        ],
        backgroundColor: MyDrawer.emp.darkTheme == 1
            ? MyColors.richBlackFogra
            : MyColors.white,
      ),
      drawer: MyDrawer(),
      backgroundColor: MyDrawer.emp.darkTheme == 1
          ? MyColors.richBlackFogra
          : MyColors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: MyScreen.getScreenHeight(context) * (25 / 1063.6),
              ),
              Container(
                width: MyScreen.getScreenWidth(context) * (460 / 490.9),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  color: MyDrawer.emp.darkTheme == 1
                      ? MyColors.white
                      : MyColors.grey,
                ),
                child: TypeAheadField(
                  suggestionsCallback: (pattern) => itemList.where((item) =>
                      item.toLowerCase().contains(pattern.toLowerCase())),
                  textFieldConfiguration: TextFieldConfiguration(
                      scrollPadding: const EdgeInsets.only(
                        bottom: 300,
                      ),
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        hintText: "Quick Search",
                        suffixIcon: Icon(
                          Icons.search,
                          size:
                              MyScreen.getScreenHeight(context) * (30 / 1063.6),
                          color: MyDrawer.emp.darkTheme == 1
                              ? MyColors.scarlet
                              : MyColors.white,
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(10, 13, 0, 0),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: MyDrawer.emp.darkTheme == 1
                                    ? MyColors.richBlackFogra
                                    : MyColors.white)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: MyDrawer.emp.darkTheme == 1
                                    ? MyColors.richBlackFogra
                                    : MyColors.white)),
                      ),
                      style: TextStyle(
                          color: MyDrawer.emp.darkTheme == 1
                              ? MyColors.middleRed
                              : MyColors.scarlet,
                          fontSize: MyScreen.getScreenHeight(context) *
                              (25 / 1063.6))),
                  itemBuilder: (_, String item) => ListTile(
                    title: Text(item),
                  ),
                  onSuggestionSelected: (String val) {
                    _textEditingController.text = val;
                    Future.delayed(Duration(milliseconds: 500), () async {
                      if (val == "Processing Orders") {
                        var _pendingOrders = Database_ApproveOrders();
                        if (await _pendingOrders.getProcessingOrders(
                            MyDrawer.emp.id!, MyDrawer.emp.role!)) {
                          Navigator.pushNamed(
                              context, MyRoutes.MyProcessingOrders);
                        }
                      } else if (val == "Add Employee") {
                        Navigator.pushNamed(context, MyRoutes.MySignUpEmail);
                      } else if (val == "Pending Orders") {
                        var _pendingOrders = Database_ApproveOrders();
                        if (await _pendingOrders.getPendingOrders()) {
                          Navigator.pushNamed(context, MyRoutes.MyApproveOrder);
                        }
                      } else if (val == "Fulfilled Orders") {
                        var _fulfilledOrders = Database_ApproveOrders();
                        if (await _fulfilledOrders.getFulfilledOrders()) {
                          Navigator.pushNamed(
                              context, MyRoutes.MyFulfilledOrders);
                        }
                      } else if (val == "Leave Request Form") {
                        Navigator.pushNamed(
                            context, MyRoutes.MyLeaveRequestForm);
                      } else if (val == "My Leave Request Summary") {
                        if (await Database_leaveRequest()
                            .getAllRequestForEmp(MyDrawer.emp.id!)) {
                          Navigator.pushNamed(
                              context, MyRoutes.MyLeaveRequestSummary);
                        }
                      } else if (val == "Leave Requests") {
                        if (await Database_leaveRequest().getAllRequest()) {
                          Navigator.pushNamed(context, MyRoutes.MyLeaveRequest);
                        }
                      } else if (val == "Edit Profile") {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditEmployeeScreen(
                                      emp: MyDrawer.emp,
                                    )));
                      } else if (val == "View Employees") {
                        var _db_employee = Database_signUp();
                        if (await _db_employee.getAllEmp()) {
                          print(Database_signUp.emps);
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewEmployeeScreen(
                                        emps: Database_signUp.emps,
                                      )));
                        }
                      } else if (val == "Explore Attendance") {
                        if (await Database_signUp().getAllEmp()) {
                          //print(Database_signUp.emps);
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ExploreAttendance(
                                        emps: Database_signUp.emps,
                                      )));
                        }
                      } else if (val == "Add Item") {
                        Navigator.pushNamed(context, MyRoutes.MyAddItemScreen);
                      } else if (val == "Analytic Report") {
                        if (await Database_Report()
                            .getSalesperson_SalesReport()) {
                          Navigator.pushNamed(context, MyRoutes.MyReportHome);
                        }
                      } else if (val == "View Item" || val == "View Items") {
                        if (await Database_Item().get_Items()) {
                          Navigator.pushNamed(context, MyRoutes.MyViewItems);
                        }
                      }
                      _textEditingController.text = "";
                    });
                  },
                  getImmediateSuggestions: true,
                  hideOnEmpty: false,
                  noItemsFoundBuilder: (context) => const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('No item found'),
                  ),
                ),
              ),
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
                  color: MyDrawer.emp.darkTheme == 1
                      ? MyColors.white
                      : MyColors.grey,
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
                            /*setState(() {
                              viewAll1 = !viewAll1;
                              viewAll2 = false;
                              viewAll3 = false;
                            });*/
                          },
                          child: Text("        ",
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
                                        color: MyDrawer.emp.darkTheme == 1
                                            ? MyColors.scarlet
                                            : MyColors.richBlackFogra,
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
                                        color: MyDrawer.emp.darkTheme == 1
                                            ? MyColors.black
                                            : MyColors.scarlet,
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
                                onTap: () async {
                                  var _fulfilledOrders =
                                      Database_ApproveOrders();
                                  if (await _fulfilledOrders
                                      .getFulfilledOrders()) {
                                    Navigator.pushNamed(
                                        context, MyRoutes.MyFulfilledOrders);
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
                                        color: MyDrawer.emp.darkTheme == 1
                                            ? MyColors.scarlet
                                            : MyColors.richBlackFogra,
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
                                        color: MyDrawer.emp.darkTheme == 1
                                            ? MyColors.black
                                            : MyColors.scarlet,
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
                                        color: MyDrawer.emp.darkTheme == 1
                                            ? MyColors.scarlet
                                            : MyColors.richBlackFogra,
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
                                        color: MyDrawer.emp.darkTheme == 1
                                            ? MyColors.black
                                            : MyColors.scarlet,
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
                                    /*child: InkWell(
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
                                              color: MyDrawer.emp.darkTheme == 1
                                                  ? MyColors.scarlet
                                                  : MyColors.richBlackFogra,
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
                                              color: MyDrawer.emp.darkTheme == 1
                                                  ? MyColors.black
                                                  : MyColors.scarlet,
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
                                    ),*/
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: MyScreen.getScreenHeight(context) *
                                        (86 / 1063.6),
                                    width: MyScreen.getScreenWidth(context) *
                                        ((440 / 3) / 490.9),
                                    /*child: InkWell(
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
                                              color: MyDrawer.emp.darkTheme == 1
                                                  ? MyColors.scarlet
                                                  : MyColors.richBlackFogra,
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
                                              color: MyDrawer.emp.darkTheme == 1
                                                  ? MyColors.black
                                                  : MyColors.scarlet,
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
                                    ),*/
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: MyScreen.getScreenHeight(context) *
                                        (86 / 1063.6),
                                    width: MyScreen.getScreenWidth(context) *
                                        ((440 / 3) / 490.9),
                                    /*child: InkWell(
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
                                              color: MyDrawer.emp.darkTheme == 1
                                                  ? MyColors.scarlet
                                                  : MyColors.richBlackFogra,
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
                                              color: MyDrawer.emp.darkTheme == 1
                                                  ? MyColors.black
                                                  : MyColors.scarlet,
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
                                    ),*/
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
                  color: MyDrawer.emp.darkTheme == 1
                      ? MyColors.white
                      : MyColors.grey,
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
                                        color: MyDrawer.emp.darkTheme == 1
                                            ? MyColors.scarlet
                                            : MyColors.richBlackFogra,
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
                                        color: MyDrawer.emp.darkTheme == 1
                                            ? MyColors.black
                                            : MyColors.scarlet,
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
                                        color: MyDrawer.emp.darkTheme == 1
                                            ? MyColors.scarlet
                                            : MyColors.richBlackFogra,
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
                                        color: MyDrawer.emp.darkTheme == 1
                                            ? MyColors.black
                                            : MyColors.scarlet,
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
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ViewEmployeeScreen(
                                                  emps: Database_signUp.emps,
                                                )));
                                    // Navigator.pushNamed(
                                    //     context, MyRoutes.MyEditEmployeeScreen);
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
                                        color: MyDrawer.emp.darkTheme == 1
                                            ? MyColors.scarlet
                                            : MyColors.richBlackFogra,
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
                                        color: MyDrawer.emp.darkTheme == 1
                                            ? MyColors.black
                                            : MyColors.scarlet,
                                      ),
                                    ),
                                    SizedBox(
                                      height: MyScreen.getScreenWidth(context) *
                                          (2 / 490.9),
                                    ),
                                    Text("View Employees",
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
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ExploreAttendance(
                                                        emps: Database_signUp
                                                            .emps,
                                                      )));
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
                                              color: MyDrawer.emp.darkTheme == 1
                                                  ? MyColors.scarlet
                                                  : MyColors.richBlackFogra,
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
                                              color: MyDrawer.emp.darkTheme == 1
                                                  ? MyColors.black
                                                  : MyColors.scarlet,
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
                                              color: MyDrawer.emp.darkTheme == 1
                                                  ? MyColors.scarlet
                                                  : MyColors.richBlackFogra,
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
                                              color: MyDrawer.emp.darkTheme == 1
                                                  ? MyColors.black
                                                  : MyColors.scarlet,
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
                                              color: MyDrawer.emp.darkTheme == 1
                                                  ? MyColors.scarlet
                                                  : MyColors.richBlackFogra,
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
                                              color: MyDrawer.emp.darkTheme == 1
                                                  ? MyColors.black
                                                  : MyColors.scarlet,
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
                    ? MyScreen.getScreenHeight(context) * (397 / 1063.6)
                    : MyScreen.getScreenHeight(context) * (159 / 1063.6),
                padding: EdgeInsets.fromLTRB(
                    MyScreen.getScreenWidth(context) * (10 / 490.9),
                    MyScreen.getScreenHeight(context) * (5 / 1063.6),
                    MyScreen.getScreenWidth(context) * (10 / 490.9),
                    MyScreen.getScreenHeight(context) * (5 / 1063.6)),
                //height: MyScreen.getScreenHeight(context) * (139 / 1063.6),
                width: MyScreen.getScreenWidth(context) * (460 / 490.9),
                decoration: BoxDecoration(
                  color: MyDrawer.emp.darkTheme == 1
                      ? MyColors.white
                      : MyColors.grey,
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
                                        color: MyDrawer.emp.darkTheme == 1
                                            ? MyColors.scarlet
                                            : MyColors.richBlackFogra,
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
                                        color: MyDrawer.emp.darkTheme == 1
                                            ? MyColors.black
                                            : MyColors.scarlet,
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
                                        context, MyRoutes.MyReportHome);
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
                                        color: MyDrawer.emp.darkTheme == 1
                                            ? MyColors.scarlet
                                            : MyColors.richBlackFogra,
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
                                        color: MyDrawer.emp.darkTheme == 1
                                            ? MyColors.black
                                            : MyColors.scarlet,
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
                                onTap: () async {
                                  if (await Database_Item().get_Items()) {
                                    Navigator.pushNamed(
                                        context, MyRoutes.MyViewItems);
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
                                        color: MyDrawer.emp.darkTheme == 1
                                            ? MyColors.scarlet
                                            : MyColors.richBlackFogra,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                MyScreen.getScreenHeight(
                                                        context) *
                                                    (10 / 1063.6))),
                                      ),
                                      child: Icon(
                                        Icons.wysiwyg_outlined,
                                        size:
                                            MyScreen.getScreenHeight(context) *
                                                (30 / 1063.6),
                                        color: MyDrawer.emp.darkTheme == 1
                                            ? MyColors.black
                                            : MyColors.scarlet,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MyScreen.getScreenHeight(context) *
                                              (2 / 1063.6),
                                    ),
                                    Text("View Items",
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
                                        if (await Database_Item()
                                            .get_ItemNames()) {
                                          print(Database_Item.items);
                                          Navigator.pushNamed(
                                              context, MyRoutes.MyAddStock);
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
                                              color: MyDrawer.emp.darkTheme == 1
                                                  ? MyColors.scarlet
                                                  : MyColors.richBlackFogra,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      MyScreen.getScreenHeight(
                                                              context) *
                                                          (10 / 1063.6))),
                                            ),
                                            child: Icon(
                                              Icons.swap_horiz,
                                              size: MyScreen.getScreenHeight(
                                                      context) *
                                                  (30 / 1063.6),
                                              color: MyDrawer.emp.darkTheme == 1
                                                  ? MyColors.black
                                                  : MyColors.scarlet,
                                            ),
                                          ),
                                          SizedBox(
                                            height: MyScreen.getScreenWidth(
                                                    context) *
                                                (2 / 490.9),
                                          ),
                                          Text("Add Stock",
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
                                        if (await Database_Stock
                                            .getStockByEmpId(1)) {
                                          print(Database_Stock
                                              .stockByEmpId.length);
                                          await Navigator.pushNamed(context,
                                              MyRoutes.MyViewInventory);
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
                                              color: MyDrawer.emp.darkTheme == 1
                                                  ? MyColors.scarlet
                                                  : MyColors.richBlackFogra,
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
                                              color: MyDrawer.emp.darkTheme == 1
                                                  ? MyColors.black
                                                  : MyColors.scarlet,
                                            ),
                                          ),
                                          SizedBox(
                                            height: MyScreen.getScreenWidth(
                                                    context) *
                                                (2 / 490.9),
                                          ),
                                          Text("View Inventory",
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
                                        if (await Database_Item()
                                            .get_ItemNames()) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddScheme(
                                                        itemList: Database_Item
                                                            .item_names,
                                                      )));
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
                                              color: MyDrawer.emp.darkTheme == 1
                                                  ? MyColors.scarlet
                                                  : MyColors.richBlackFogra,
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
                                              color: MyDrawer.emp.darkTheme == 1
                                                  ? MyColors.black
                                                  : MyColors.scarlet,
                                            ),
                                          ),
                                          SizedBox(
                                            height: MyScreen.getScreenWidth(
                                                    context) *
                                                (2 / 490.9),
                                          ),
                                          Text("Add Scheme",
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
                                        if (await Database_Scheme()
                                            .currentSchemes()) {
                                          print(Database_Scheme.current_schemes);
                                          Navigator.pushNamed(
                                              context, MyRoutes.MyViewSchemes);
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
                                              color: MyDrawer.emp.darkTheme == 1
                                                  ? MyColors.scarlet
                                                  : MyColors.richBlackFogra,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      MyScreen.getScreenHeight(
                                                              context) *
                                                          (10 / 1063.6))),
                                            ),
                                            child: Icon(
                                              Icons.swap_horiz,
                                              size: MyScreen.getScreenHeight(
                                                      context) *
                                                  (30 / 1063.6),
                                              color: MyDrawer.emp.darkTheme == 1
                                                  ? MyColors.black
                                                  : MyColors.scarlet,
                                            ),
                                          ),
                                          SizedBox(
                                            height: MyScreen.getScreenWidth(
                                                    context) *
                                                (2 / 490.9),
                                          ),
                                          Text("View Schemes",
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
                                    /*child: InkWell(
                                      onTap: () async {
                                        if (await Database_Stock
                                            .getStockByEmpId(1)) {
                                          print(Database_Stock
                                              .stockByEmpId.length);
                                          await Navigator.pushNamed(context,
                                              MyRoutes.MyViewInventory);
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
                                              color: MyDrawer.emp.darkTheme == 1
                                                  ? MyColors.scarlet
                                                  : MyColors.richBlackFogra,
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
                                              color: MyDrawer.emp.darkTheme == 1
                                                  ? MyColors.black
                                                  : MyColors.scarlet,
                                            ),
                                          ),
                                          SizedBox(
                                            height: MyScreen.getScreenWidth(
                                                    context) *
                                                (2 / 490.9),
                                          ),
                                          Text("View Inventory",
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
                                    ),*/
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: MyScreen.getScreenHeight(context) *
                                        (86 / 1063.6),
                                    width: MyScreen.getScreenWidth(context) *
                                        ((440 / 3) / 490.9),
                                    /*child: InkWell(
                                      onTap: () async {
                                        if (await Database_Item()
                                            .get_ItemNames()) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddScheme(
                                                        itemList: Database_Item
                                                            .item_names,
                                                      )));
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
                                              color: MyDrawer.emp.darkTheme == 1
                                                  ? MyColors.scarlet
                                                  : MyColors.richBlackFogra,
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
                                              color: MyDrawer.emp.darkTheme == 1
                                                  ? MyColors.black
                                                  : MyColors.scarlet,
                                            ),
                                          ),
                                          SizedBox(
                                            height: MyScreen.getScreenWidth(
                                                    context) *
                                                (2 / 490.9),
                                          ),
                                          Text("Add Scheme",
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
                                    ),*/
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
