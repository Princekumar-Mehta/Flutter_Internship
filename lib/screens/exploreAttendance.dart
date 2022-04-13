import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_v3/Database/db_hourly_attendance.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/Extras/utility.dart';
import 'package:project_v3/Models/employee.dart';

import 'mapScreen.dart';

class ExploreAttendance extends StatefulWidget {
  List<Employee> emps;
  ExploreAttendance({required this.emps});

  @override
  State<ExploreAttendance> createState() => _ExploreAttendanceState();
}

class _ExploreAttendanceState extends State<ExploreAttendance> {
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
        title: Text("Explore Attendance",
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
            MyScreen.getScreenHeight(context) * (0 / 1063.6),
            MyScreen.getScreenWidth(context) * (20 / 490.9),
            MyScreen.getScreenHeight(context) * (20 / 1063.6)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.emps.length,
                  itemBuilder: (context, index) {
                    //print(widget.emps[index]);
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
          widget.emps[key].role! == "Salesperson"
              ? Container(
                  decoration: BoxDecoration(
                    color: MyDrawer.emp.darkTheme == 1
                        ? MyColors.white
                        : MyColors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  width: MyScreen.getScreenWidth(context) * (450 / 490.9),
                  height: MyScreen.getScreenHeight(context) * (80 / 1063.6),
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
                              width: MyScreen.getScreenWidth(context) *
                                  (50 / 490.9),
                              height: MyScreen.getScreenWidth(context) *
                                  (50 / 490.9),
                              color: MyColors.richBlackFogra,
                              child: Image.file(
                                  File(widget.emps[key].profile_pic!)),
                            ),
                            SizedBox(
                              width: MyScreen.getScreenWidth(context) *
                                  (10 / 490.9),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      widget.emps[key].name!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MyScreen.getScreenHeight(context) *
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
                                      "Employee ID: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MyScreen.getScreenHeight(context) *
                                                (16 / 1063.6),
                                      ),
                                    ),
                                    Text(
                                      widget.emps[key].id!.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MyScreen.getScreenHeight(context) *
                                                (16 / 1063.6),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MyScreen.getScreenWidth(context) *
                                          (100 / 490.9),
                                    ),
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
                                                "Employee has not logged attendance for today.\n\nPlease try again after some time or contact employee for updates.");
                                            return;
                                          }
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MapScreen(
                                                        hourly_attendance:
                                                            Database_Hourly_Attendance
                                                                .hourly_attendance,
                                                      )));
                                        },
                                        child: Text("View Live Location",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  MyScreen.getScreenHeight(
                                                          context) *
                                                      (16 / 1063.6),
                                            ))),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  color: MyDrawer.emp.darkTheme == 1
                      ? MyColors.white
                      : MyColors.grey,
                ),
        ],
      ),
      SizedBox(
        height: MyScreen.getScreenHeight(context) * (20 / 1063.6),
      ),
    ]);
  }
}
