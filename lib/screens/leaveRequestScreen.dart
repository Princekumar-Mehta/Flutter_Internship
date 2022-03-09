import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_v3/Database/db_leave_request.dart';
import 'package:project_v3/Email/send_email.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/Extras/utility.dart';

import '../routes.dart';

class LeaveRequest extends StatefulWidget {
  const LeaveRequest({Key? key}) : super(key: key);

  @override
  State<LeaveRequest> createState() => _LeaveRequestState();
}

class _LeaveRequestState extends State<LeaveRequest> {
  Future<void> showMessage(
    BuildContext context,
    String message,
  ) async {
    showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Alert'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('Okay'),
            onPressed: () async {
              Navigator.pop(c, false);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(
            color: MyColors.scarlet,
            width: MyScreen.getScreenHeight(context) * (4 / 1063.6),
          ),
        ),
        title: Text("Leave Requests",
            style: TextStyle(
                color: MyColors.white,
                fontSize: MyScreen.getScreenHeight(context) * (20 / 1063.6))),
        centerTitle: true,
        backgroundColor: MyColors.richBlackFogra,
      ),
      drawer: MyDrawer(),
      backgroundColor: MyColors.richBlackFogra,
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
                  itemCount: Database_leaveRequest.leaveRequests.length,
                  itemBuilder: (context, index) {
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

  pendingLeaves(totalLeaves) {
    int difference = 30 - int.parse(totalLeaves.toString());
    return difference;
  }

  _row(int key) {
    var lastToDate = Utility.formatDate(
        Database_leaveRequest.lastApprovedLeaveRequests[key] == ""
            ? DateTime.now().add(const Duration(days: 2)).toString()
            : Database_leaveRequest.lastApprovedLeaveRequests[key]);
    // var calculatedAgo = calculateAgo(lastToDate);
    var toDate =
        Utility.formatDate(Database_leaveRequest.leaveRequests[key].todate!);
    var fromDate =
        Utility.formatDate(Database_leaveRequest.leaveRequests[key].fromdate!);
    var daysRequested = Utility.calculateDifferenceDays(fromDate, toDate);
    var totalLeaves = Database_leaveRequest.totalApprovedLeaveRequests[key];
    var remLeaves = pendingLeaves(totalLeaves);
    print(remLeaves);
    return Column(
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: MyColors.grey,
                borderRadius: BorderRadius.all(Radius.circular(10)),
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
                          width:
                              MyScreen.getScreenWidth(context) * (50 / 490.9),
                          height:
                              MyScreen.getScreenWidth(context) * (50 / 490.9),
                          color: MyColors.richBlackFogra,
                          child: Image.file(File(Database_leaveRequest
                              .empleave[key].profile_pic!)),
                        ),
                        SizedBox(
                          width:
                              MyScreen.getScreenWidth(context) * (10 / 490.9),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  Database_leaveRequest.empleave[key].name!,
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
                                Icon(
                                  Icons.badge,
                                  size: MyScreen.getScreenHeight(context) *
                                      (22 / 1063.6),
                                ),
                                SizedBox(
                                  width: MyScreen.getScreenWidth(context) *
                                      (5 / 490.9),
                                ),
                                Container(
                                  height: MyScreen.getScreenHeight(context) *
                                      (29 / 1063.6),
                                  alignment: Alignment.center,
                                  child: Text(
                                    Database_leaveRequest.empleave[key].role!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MyScreen.getScreenHeight(context) *
                                              (16 / 1063.6),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: MyScreen.getScreenWidth(context) *
                                      (25 / 490.9),
                                ),
                                Container(
                                  height: MyScreen.getScreenHeight(context) *
                                      (29 / 1063.6),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Last Leave: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MyScreen.getScreenHeight(context) *
                                              (16 / 1063.6),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: MyScreen.getScreenHeight(context) *
                                      (29 / 1063.6),
                                  alignment: Alignment.center,
                                  child: Text(
                                    Database_leaveRequest
                                        .lastApprovedLeaveRequests[key],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MyScreen.getScreenHeight(context) *
                                              (16 / 1063.6),
                                    ),
                                  ),
                                ),
                                // Container(
                                //   height: MyScreen.getScreenHeight(context) *
                                //       (29 / 1063.6),
                                //   alignment: Alignment.center,
                                //   child: Text(
                                //     (calculatedAgo['difference'] == -1)
                                //         ? " Not Taken"
                                //         : (int.parse(calculatedAgo[
                                //                     'weekorday']) ==
                                //                 0
                                //             ? " days ago"
                                //             : " weeks ago"),
                                //     style: TextStyle(
                                //       fontWeight: FontWeight.bold,
                                //       fontSize:
                                //           MyScreen.getScreenHeight(context) *
                                //               (16 / 1063.6),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      color: MyColors.richBlackFogra,
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
                              width: MyScreen.getScreenWidth(context) *
                                  (40 / 490.9),
                              height: MyScreen.getScreenWidth(context) *
                                  (40 / 490.9),
                              color: MyColors.richBlackFogra,
                              child: Text(
                                remLeaves.toString(),
                                style: TextStyle(
                                  color: MyColors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (20 / 1063.6),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MyScreen.getScreenWidth(context) *
                                  (10 / 490.9),
                            ),
                            Text(
                              "Pending\nLeaves",
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
                              width: MyScreen.getScreenWidth(context) *
                                  (40 / 490.9),
                              height: MyScreen.getScreenWidth(context) *
                                  (40 / 490.9),
                              color: MyColors.richBlackFogra,
                              child: Text(
                                totalLeaves.toString(),
                                style: TextStyle(
                                  color: MyColors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (20 / 1063.6),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MyScreen.getScreenWidth(context) *
                                  (10 / 490.9),
                            ),
                            Text(
                              "Leaves\nTaken",
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
                            if (await Database_leaveRequest()
                                .CancelLeaveRequest(key)) {
                              Send_Mail.send_mail(
                                  Database_leaveRequest.empleave[key].email!,
                                  "Leave Cancelled",
                                  "Your Leave has been cancelled.");
                              setState(() {});
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
                            if (await Database_leaveRequest()
                                .ApproveLeaveRequest(key)) {
                              Send_Mail.send_mail(
                                  Database_leaveRequest.empleave[key].email!,
                                  "Leave Confirmed",
                                  "Your Leave has been approved.");

                              if (await Database_leaveRequest()
                                  .getAllRequest()) {
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                    context, MyRoutes.MyLeaveRequest);
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
                      color: MyColors.richBlackFogra,
                      height: MyScreen.getScreenHeight(context) * (2 / 1063.6),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Text(
                              ((int.parse(daysRequested['weekorday'])) == 0)
                                  ? daysRequested['difference'].toString()
                                  : ((int.parse(daysRequested['weekorday']) > 4)
                                      ? daysRequested['months']
                                      : daysRequested['weekorday']),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (13 / 1063.6),
                              ),
                            ),
                            Text(
                              (int.parse(daysRequested['weekorday']) == 0)
                                  ? " days requested"
                                  : (((int.parse(daysRequested['weekorday']) >
                                          4)
                                      ? " months requested"
                                      : " weeks requested")),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (13 / 1063.6),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width:
                              MyScreen.getScreenWidth(context) * (200 / 490.9),
                        ),
                        InkWell(
                          child: Text(
                            "View Request",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (13 / 1063.6),
                            ),
                          ),
                          onTap: () {
                            showMessage(
                                context,
                                "From: " +
                                    Database_leaveRequest
                                        .leaveRequests[key].fromdate!
                                        .split(" ")[0] +
                                    "\nTo: " +
                                    Database_leaveRequest
                                        .leaveRequests[key].todate!
                                        .split(" ")[0] +
                                    "\nReason: " +
                                    Database_leaveRequest
                                        .leaveRequests[key].reason!
                                        .toUpperCase() +
                                    "\nReason Description: " +
                                    Database_leaveRequest
                                        .leaveRequests[key].reason_desc!);
                          },
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
      ],
    );
  }
}
