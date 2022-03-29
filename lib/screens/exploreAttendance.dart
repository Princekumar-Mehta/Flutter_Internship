import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_v3/Database/db_employee.dart';
import 'package:project_v3/Database/db_hourly_attendance.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';

import '../Extras/routes.dart';

class ExploreAttendance extends StatefulWidget {
  const ExploreAttendance({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              MyScreen.getScreenWidth(context) * (20 / 490.9),
              MyScreen.getScreenHeight(context) * (0 / 1063.6),
              MyScreen.getScreenWidth(context) * (20 / 490.9),
              MyScreen.getScreenHeight(context) * (20 / 1063.6)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: Database_signUp.emps.length,
                  itemBuilder: (context, index) {
                    //print(Database_signUp.emps[index]);
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
          Database_signUp.emps[key].role! == "Salesperson"
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
                                  File(Database_signUp.emps[key].profile_pic!)),
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
                                      Database_signUp.emps[key].name!,
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
                                      Database_signUp.emps[key].id!.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MyScreen.getScreenHeight(context) *
                                                (16 / 1063.6),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MyScreen.getScreenWidth(context) *
                                          (130 / 490.9),
                                    ),
                                    InkWell(
                                        onTap: () async {
                                          if (await Database_Hourly_Attendance()
                                              .getHourlyAttendance(
                                                  MyDrawer.emp.id!,
                                                  DateTime.now()
                                                      .toString()
                                                      .split(" ")[0])) {
                                            Navigator.pushNamed(
                                                context, MyRoutes.MyMapScreen);
                                          }
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
