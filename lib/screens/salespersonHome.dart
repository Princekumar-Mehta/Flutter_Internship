import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:project_v3/Database/db_approveOrders.dart';
import 'package:project_v3/Database/db_customer.dart';
import 'package:project_v3/Database/db_customer_branch.dart';
import 'package:project_v3/Database/db_customer_feedback.dart';
import 'package:project_v3/Database/db_hourly_attendance.dart';
import 'package:project_v3/Database/db_item.dart';
import 'package:project_v3/Database/db_leave_request.dart';
import 'package:project_v3/Database/db_region_salesperson.dart';
import 'package:project_v3/Database/db_route.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/Extras/routes.dart';
import 'package:project_v3/Extras/utility.dart';
import 'package:project_v3/screens/viewTodaysRoute.dart';

import 'editEmployeeScreen.dart';

class SalespersonHome extends StatefulWidget {
  const SalespersonHome({Key? key}) : super(key: key);

  @override
  State<SalespersonHome> createState() => _SalespersonHomeState();
}

class _SalespersonHomeState extends State<SalespersonHome> {
  bool viewAll1 = false;
  bool viewAll2 = false;
  final TextEditingController _textEditingController = TextEditingController();
  bool isChanged = true;
  var itemList = [
    "My Orders",
    "Edit Profile",
    "Salesperson Attendance",
    "Leave Request Form",
    "My Leave Request Summary",
    "Add Order",
    "Add New Order",
    "Edit Employee",
    "Add Customer",
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
        title: Text("Salesperson Home",
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
                      if (val == "My Orders") {
                        var _pendingOrders = Database_ApproveOrders();
                        if (await _pendingOrders.getProcessingOrders(
                            MyDrawer.emp.id!, MyDrawer.emp.role!)) {
                          Navigator.pushNamed(
                              context, MyRoutes.MyProcessingOrders);
                        }
                      } else if (val == "Edit Profile" ||
                          val == "Edit Employee") {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditEmployeeScreen(
                                      emp: MyDrawer.emp,
                                    )));
                      } else if (val == "Salesperson Attendance") {
                        if (await Database_Hourly_Attendance()
                            .getHourlyAttendance(MyDrawer.emp.id!,
                                DateTime.now().toString().split(" ")[0])) {
                          Navigator.pushNamed(
                              context, MyRoutes.MySalespersonAttendance);
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
                      } else if (val == "Add New Order" || val == "Add Order") {
                        String sub_Area = await Database_Region_Salesperson()
                            .getRegionSalesperson(MyDrawer.emp.id!);
                        if (await Database_customer().insertData() &&
                            await Database_customer()
                                .get_customerIdsBySubArea(sub_Area) &&
                            await Database_customerBranch().insertData() &&
                            await Database_Item().get_ItemNames()) {
                          Navigator.pushNamed(context, MyRoutes.MySalesOrder);
                        }
                      }
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
                              // textDirection: TextDirection.rtl,
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
                              viewAll1 = !viewAll1;
                              viewAll2 = false;
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
                    // White space
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
                                        Icons.time_to_leave,
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
                                    Text("Request Leave",
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
                                      .getAllRequestForEmp(MyDrawer.emp.id!)) {
                                    Navigator.pushNamed(context,
                                        MyRoutes.MyLeaveRequestSummary);
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
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditEmployeeScreen(
                                                emp: MyDrawer.emp,
                                              )));
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
                                        await Navigator.pushNamed(context,
                                            MyRoutes.MyAddCustomerScreen);
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
                                              Icons.add,
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
                                          Text("Add Customer",
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
                                        if (await Database_customer
                                            .getAllCustomers()) {
                                          Navigator.pushNamed(context,
                                              MyRoutes.MyViewCustomerScreen);
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
                                              Icons.wysiwyg_outlined,
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
                                          Text("View Customers",
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
                                        final df = DateFormat('dd-MM-yyyy');
                                        var date =
                                            (df.format(new DateTime.now()));
                                        if (await Database_Customer_Feedback()
                                            .getRemainingBranchesCustomerFeedbacks(
                                          MyDrawer.emp.id!,
                                          int.parse(date.split('-')[1]),
                                          int.parse(date.split('-')[2]),
                                        )) {
                                          Navigator.pushNamed(
                                              context,
                                              MyRoutes
                                                  .MyCustomerFeedbackScreen);
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
                                              Icons.thumbs_up_down_outlined,
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
                                          Text("Customer Feedback",
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
                              // textDirection: TextDirection.RTL,
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
                              viewAll1 = false;
                              viewAll2 = !viewAll2;
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
                                  if (await Database_Hourly_Attendance()
                                      .getHourlyAttendance(
                                          MyDrawer.emp.id!,
                                          DateTime.now()
                                              .toString()
                                              .split(" ")[0])) {
                                    Navigator.pushNamed(context,
                                        MyRoutes.MySalespersonAttendance);
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
                                        Icons.my_location_rounded,
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
                                    Text("Attendance Log",
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
                                    Text("My Orders",
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
                                  String sub_Area =
                                      await Database_Region_Salesperson()
                                          .getRegionSalesperson(
                                              MyDrawer.emp.id!);
                                  if (await Database_customer().insertData() &&
                                      await Database_customer()
                                          .get_customerIdsBySubArea(sub_Area) &&
                                      await Database_customerBranch()
                                          .insertData() &&
                                      await Database_Item().get_ItemNames()) {
                                    Navigator.pushNamed(
                                        context, MyRoutes.MySalesOrder);
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
                                        Icons.shopping_basket,
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
                                    Text("Add New Order",
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
                                        String sub_Area =
                                            await Database_Region_Salesperson()
                                                .getRegionSalesperson(
                                                    MyDrawer.emp.id!);
                                        if (await Database_Route()
                                            .get_AllcustomerBranchesBySubArea(
                                                sub_Area)) {
                                          await Navigator.pushNamed(context,
                                              MyRoutes.MySetRouteMapScreen);
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
                                              Icons.map,
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
                                          Text("Route Plan",
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
                                        var date = DateTime.now();
                                        print(DateFormat("EEEE").format(date));
                                        await Database_Route()
                                            .getRoutesBySalespersonIdDay(
                                                MyDrawer.emp.id!,
                                                DateFormat("EEEE")
                                                    .format(date));
                                        if (Database_Route
                                            .routeBranches.isEmpty) {
                                          Utility.showMessage(context,
                                              "No Route planned for Today.\n\nPlease plan route for the day to view route.");
                                          return;
                                        }
                                        await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewTodaysRoute(
                                                        routeBranches:
                                                            Database_Route
                                                                .routeBranches)));
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
                                          Text("View Route",
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
            ],
          ),
        ),
      ),
    );
  }
}
