import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_v3/Database/db_customer_feedback.dart';
import 'package:project_v3/Database/db_hourly_attendance.dart';
import 'package:project_v3/Database/db_region_salesperson.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/Extras/utility.dart';
import 'package:project_v3/Models/employee.dart';
import 'package:project_v3/Models/region_salesperson.dart';
import 'package:project_v3/screens/editEmployeeScreen.dart';

import '../Extras/routes.dart';
import 'mapScreen.dart';

class ViewEmployeeScreen extends StatefulWidget {
  List<Employee> emps;
  ViewEmployeeScreen({required this.emps});
  @override
  State<ViewEmployeeScreen> createState() => _ViewEmployeeScreenState();
}

class _ViewEmployeeScreenState extends State<ViewEmployeeScreen> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.emps.length);
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
        title: Text("View Employee",
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
                  itemCount: widget.emps.length,
                  itemBuilder: (context, index) {
                    print(widget.emps[index]);
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
              color:
                  MyDrawer.emp.darkTheme == 1 ? MyColors.white : MyColors.grey,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            width: MyScreen.getScreenWidth(context) * (450 / 490.9),
            height: widget.emps[key].role! == "Salesperson"
                ? MyScreen.getScreenHeight(context) * (105 / 1063.6)
                : MyScreen.getScreenHeight(context) * (80 / 1063.6),
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
                        child: Image.file(File(widget.emps[key].profile_pic!)),
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
                                widget.emps[key].id!.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (20 / 1063.6),
                                ),
                              ),
                              Text(
                                ") ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (20 / 1063.6),
                                ),
                              ),
                              Text(
                                widget.emps[key].name!,
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
                                Icons.theater_comedy,
                                size: MyScreen.getScreenHeight(context) *
                                    (25 / 1063.6),
                              ),
                              SizedBox(
                                width: MyScreen.getScreenWidth(context) *
                                    (10 / 490.9),
                              ),
                              Text(
                                widget.emps[key].role!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (15 / 1063.6),
                                ),
                              ),
                              SizedBox(
                                width: MyScreen.getScreenWidth(context) *
                                    (125 / 490.9),
                              ),
                              InkWell(
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MyScreen.getScreenHeight(context) *
                                              (15 / 1063.6),
                                    ),
                                  ),
                                  onTap: () async {
                                    Region_Salesperson region_salesperson;
                                    if (widget.emps[key].role ==
                                        "Salesperson") {
                                      region_salesperson =
                                          await Database_Region_Salesperson()
                                              .getRegionSalesperson(
                                              widget.emps[key].id!);
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditEmployeeScreen(
                                                    emp: widget.emps[key],
                                                    region_salesperson:
                                                        region_salesperson,
                                                  )));
                                    } else {
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditEmployeeScreen(
                                                    emp: widget.emps[key],
                                                  )));
                                    }
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
                  widget.emps[key].role! == "Salesperson"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                                onTap: () async {
                                  await Database_Hourly_Attendance()
                                      .getHourlyAttendance(
                                          widget.emps[key].id!,
                                          DateTime.now()
                                              .toString()
                                              .split(" ")[0]);
                                  if (Database_Hourly_Attendance
                                      .hourly_attendance.isEmpty) {
                                    Utility.showMessage(context,
                                        "Attendance has not been logged for today.\n\nPlease contact Salesperson to know recent updates.");
                                    return;
                                  }
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MapScreen(
                                                hourly_attendance:
                                                    Database_Hourly_Attendance
                                                        .hourly_attendance,
                                              )));
                                },
                                child: Text("View Live Location",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MyScreen.getScreenHeight(context) *
                                              (15 / 1063.6),
                                    ))),
                            InkWell(
                                child: Text(
                                  "View Feedbacks",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MyScreen.getScreenHeight(context) *
                                            (15 / 1063.6),
                                  ),
                                ),
                                onTap: () async {
                                  if (await Database_Customer_Feedback()
                                      .getCustomerFeedbacksBySalespersonCode(
                                          widget.emps[key].id!)) {
                                    Navigator.pushNamed(context,
                                        MyRoutes.MyViewCustomerFeedbackScreen);
                                  }
                                }),
                          ],
                        )
                      : Container(),
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
