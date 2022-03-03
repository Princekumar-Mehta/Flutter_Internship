import 'package:flutter/material.dart';
import 'package:project_v3/Database/db_leave_request.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';

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
                    print(Database_leaveRequest.leaveRequests[index]);
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

  formatDate(date) {
    return date.split(" ")[0].split("-");
  }

  calculateAgo(lastToDate) {
    int lastYear = int.parse(lastToDate[0]);
    int lastMonth = int.parse(lastToDate[1]);
    int lastDay = int.parse(lastToDate[2]);
    final date1 = DateTime(lastYear, lastMonth, lastDay);
    final date2 = DateTime.now();
    print(date1);
    print(date2);
    final difference = date2.difference(date1).inDays;
    print(difference);
    final String weekorday = (difference / 7).toStringAsFixed(0);
    return {'difference': difference, 'weekorday': weekorday};
  }

  calculateDaysRequested(fromDate, toDate) {
    int fromYear = int.parse(fromDate[0]);
    int fromMonth = int.parse(fromDate[1]);
    int fromDay = int.parse(fromDate[2]);
    int toYear = int.parse(toDate[0]);
    int toMonth = int.parse(toDate[1]);
    int toDay = int.parse(toDate[2]);
    final date1 = DateTime(fromYear, fromMonth, fromDay);
    final date2 = DateTime(toYear, toMonth, toDay);
    final difference = date2.difference(date1).inDays + 1;
    final String months = (difference / 30.44).toStringAsFixed(0);
    final String weekorday = (difference / 7).toStringAsFixed(0);
    return {'difference': difference, 'weekorday': weekorday, 'months': months};
  }

  _row(int key) {
    var lastToDate = formatDate(
        Database_leaveRequest.lastApprovedLeaveRequests[key] == ""
            ? DateTime.now().add(const Duration(days: 2)).toString()
            : Database_leaveRequest.lastApprovedLeaveRequests[key]);
    var calculatedAgo = calculateAgo(lastToDate);
    var toDate = formatDate(Database_leaveRequest.leaveRequests[key].todate!);
    var fromDate =
        formatDate(Database_leaveRequest.leaveRequests[key].fromdate!);
    var daysRequested = calculateDaysRequested(fromDate, toDate);
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
                          child: Icon(
                            Icons.person,
                            color: MyColors.white,
                            size: MyScreen.getScreenHeight(context) *
                                (35 / 1063.6),
                          ),
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
                                    (calculatedAgo['difference'] == -1)
                                        ? ""
                                        : (int.parse(calculatedAgo[
                                                    'weekorday']) ==
                                                0
                                            ? calculatedAgo['difference']
                                                .toString()
                                            : calculatedAgo['weekorday']),
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
                                    (calculatedAgo['difference'] == -1)
                                        ? " Not Taken"
                                        : (int.parse(calculatedAgo[
                                                    'weekorday']) ==
                                                0
                                            ? " days ago"
                                            : " weeks ago"),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MyScreen.getScreenHeight(context) *
                                              (16 / 1063.6),
                                    ),
                                  ),
                                ),
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
                                "20",
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
                                "10",
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
