import 'package:flutter/material.dart';
import 'package:project_v3/Database/db_leave_request.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/Extras/utility.dart';

import '../Extras/routes.dart';

class myLeaveRequestSummary extends StatefulWidget {
  const myLeaveRequestSummary({Key? key}) : super(key: key);

  @override
  State<myLeaveRequestSummary> createState() => _myLeaveRequestSummaryState();
}

class _myLeaveRequestSummaryState extends State<myLeaveRequestSummary> {
  List<TableRow> tableRows = [];
  @override
  Widget build(BuildContext context) {
    tableRows = [];

    for (int i = -1;
        i < Database_leaveRequest.leaveRequestsForEmp.length;
        i++) {
      if (i == -1) {
        tableRows.add(TableRow(children: [
          Column(children: [
            Text(
              "",
              style: TextStyle(
                color: MyDrawer.emp.darkTheme == 1
                    ? MyColors.white
                    : MyColors.black,
                fontSize: MyScreen.getScreenHeight(context) * (18 / 1063.6),
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
          Column(children: [
            Text(
              "Reason",
              style: TextStyle(
                color: MyDrawer.emp.darkTheme == 1
                    ? MyColors.white
                    : MyColors.black,
                fontSize: MyScreen.getScreenHeight(context) * (18 / 1063.6),
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
          Column(children: [
            Text(
              "From",
              style: TextStyle(
                color: MyDrawer.emp.darkTheme == 1
                    ? MyColors.white
                    : MyColors.black,
                fontSize: MyScreen.getScreenHeight(context) * (18 / 1063.6),
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
          Column(children: [
            Text(
              "To",
              style: TextStyle(
                color: MyDrawer.emp.darkTheme == 1
                    ? MyColors.white
                    : MyColors.black,
                fontSize: MyScreen.getScreenHeight(context) * (18 / 1063.6),
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
          Column(children: [
            Text(
              "Status",
              style: TextStyle(
                color: MyDrawer.emp.darkTheme == 1
                    ? MyColors.white
                    : MyColors.black,
                fontSize: MyScreen.getScreenHeight(context) * (18 / 1063.6),
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        ]));
      } else {
        tableRows.add(_row(i));
      }
    }
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
        title: Text("Leave Request Summary",
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
      body: Center(
        child: Column(
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
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.time_to_leave,
                            size: MyScreen.getScreenHeight(context) *
                                (30 / 1063.6),
                            color: MyColors.black,
                          ),
                          SizedBox(
                            width:
                                MyScreen.getScreenWidth(context) * (10 / 490.9),
                          ),
                          Text("Leave Request Summary",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (22 / 1063.6),
                                fontWeight: FontWeight.bold,
                                color: MyColors.black,
                              )),
                        ],
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
                    height: MyScreen.getScreenHeight(context) * (10 / 1063.6),
                  ),
                  // Main
                  SizedBox(
                    height: MyScreen.getScreenHeight(context) * (86 / 1063.6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                          MyScreen.getScreenHeight(context) *
                                              (10 / 1063.6))),
                                ),
                                child: Center(
                                  child: Text(
                                    (Utility.totalLeaves -
                                            Database_leaveRequest
                                                .totalPendingLeaveRequestsForEmp)
                                        .toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MyScreen.getScreenHeight(context) *
                                              (24 / 1063.6),
                                      color: MyColors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: MyScreen.getScreenHeight(context) *
                                    (2 / 1063.6),
                              ),
                              Text("Leaves Pending",
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                          MyScreen.getScreenHeight(context) *
                                              (10 / 1063.6))),
                                ),
                                child: Center(
                                  child: Text(
                                    Database_leaveRequest
                                        .totalApprovedLeaveRequestsForEmp
                                        .toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MyScreen.getScreenHeight(context) *
                                              (24 / 1063.6),
                                      color: MyColors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: MyScreen.getScreenWidth(context) *
                                    (2 / 490.9),
                              ),
                              Text("Leaves Taken",
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                          MyScreen.getScreenHeight(context) *
                                              (10 / 1063.6))),
                                ),
                                child: Center(
                                  child: Text(
                                    Database_leaveRequest
                                        .totalPendingLeaveRequestsForEmp
                                        .toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MyScreen.getScreenHeight(context) *
                                              (24 / 1063.6),
                                      color: MyColors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: MyScreen.getScreenWidth(context) *
                                    (2 / 490.9),
                              ),
                              Text("Pending Approval",
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
            // Remaining Page
            SizedBox(
              height: MyScreen.getScreenHeight(context) * (25 / 1063.6),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                  MyScreen.getScreenWidth(context) * (10 / 490.9),
                  MyScreen.getScreenHeight(context) * (5 / 1063.6),
                  MyScreen.getScreenWidth(context) * (10 / 490.9),
                  MyScreen.getScreenHeight(context) * (5 / 1063.6)),
              width: MyScreen.getScreenWidth(context) * (480 / 490.9),
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(.5),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(2.5),
                  3: FlexColumnWidth(2.5),
                  4: FlexColumnWidth(2)
                },
                border: TableBorder.all(
                    color: MyDrawer.emp.darkTheme == 1
                        ? MyColors.grey
                        : MyColors.black,
                    style: BorderStyle.solid,
                    width: 1),
                children: tableRows,
              ),
            ),
            SizedBox(
              height: MyScreen.getScreenHeight(context) * (25 / 1063.6),
            ),
            SizedBox(
              width: MyScreen.getScreenWidth(context) * (85 / 294),
              height: MyScreen.getScreenHeight(context) * (60 / 1063.6),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, MyRoutes.MyLeaveRequestForm);
                },
                child: Stack(
                  children: [
                    Opacity(
                      opacity: 0.8,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              MyScreen.getScreenHeight(context) *
                                  (10 / 1063.6)),
                          color: MyDrawer.emp.darkTheme == 1
                              ? MyColors.middleRed
                              : MyColors.scarlet,
                        ),
                      ),
                    ),
                    Center(
                      child: Text("Apply for Leave",
                          style: TextStyle(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.richBlackFogra
                                  : MyColors.white,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (17 / 1063.6),
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _row(int key) {
    return TableRow(children: [
      Column(children: [
        Text(
          (key + 1).toString(),
          style: TextStyle(
            color:
                MyDrawer.emp.darkTheme == 1 ? MyColors.white : MyColors.black,
            fontSize: MyScreen.getScreenHeight(context) * (18 / 1063.6),
            fontWeight: FontWeight.bold,
          ),
        ),
      ]),
      Column(children: [
        Text(
          Database_leaveRequest.leaveRequestsForEmp[key].reason!.toUpperCase(),
          style: TextStyle(
            color:
                MyDrawer.emp.darkTheme == 1 ? MyColors.white : MyColors.black,
            fontSize: MyScreen.getScreenHeight(context) * (18 / 1063.6),
            fontWeight: FontWeight.bold,
          ),
        ),
      ]),
      Column(children: [
        Text(
          Database_leaveRequest.leaveRequestsForEmp[key].fromdate!,
          style: TextStyle(
            color:
                MyDrawer.emp.darkTheme == 1 ? MyColors.white : MyColors.black,
            fontSize: MyScreen.getScreenHeight(context) * (18 / 1063.6),
            fontWeight: FontWeight.bold,
          ),
        ),
      ]),
      Column(children: [
        Text(
          Database_leaveRequest.leaveRequestsForEmp[key].todate!,
          style: TextStyle(
            color:
                MyDrawer.emp.darkTheme == 1 ? MyColors.white : MyColors.black,
            fontSize: MyScreen.getScreenHeight(context) * (18 / 1063.6),
            fontWeight: FontWeight.bold,
          ),
        ),
      ]),
      Column(children: [
        Text(
          Database_leaveRequest.leaveRequestsForEmp[key].status!,
          style: TextStyle(
            color:
                MyDrawer.emp.darkTheme == 1 ? MyColors.white : MyColors.black,
            fontSize: MyScreen.getScreenHeight(context) * (18 / 1063.6),
            fontWeight: FontWeight.bold,
          ),
        ),
      ]),
    ]);
  }
}
