import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_v3/Database/db_customer_feedback.dart';
import 'package:project_v3/Database/db_employee.dart';
import 'package:project_v3/Database/db_hourly_attendance.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/screens/editEmployeeScreen.dart';

import '../Extras/routes.dart';

class ViewEmployeeScreen extends StatefulWidget {
  const ViewEmployeeScreen({Key? key}) : super(key: key);

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
                  itemCount: Database_signUp.emps.length,
                  itemBuilder: (context, index) {
                    print(Database_signUp.emps[index]);
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
            height: Database_signUp.emps[key].role! == "Salesperson"
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
                        child: Image.file(
                            File(Database_signUp.emps[key].profile_pic!)),
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
                                Database_signUp.emps[key].id!.toString(),
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
                                Database_signUp.emps[key].name!,
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
                                Database_signUp.emps[key].role!,
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
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditEmployeeScreen(
                                                  emp:
                                                      Database_signUp.emps[key],
                                                )));
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
                  Database_signUp.emps[key].role! == "Salesperson"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                                onTap: () async {
                                  if (await Database_Hourly_Attendance()
                                      .getHourlyAttendance(
                                          Database_signUp.emps[key].id!,
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
                                          Database_signUp.emps[key].id!)) {
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
