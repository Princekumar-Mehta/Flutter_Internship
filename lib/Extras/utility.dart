import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_v3/Database/db_Customer.dart';
import 'package:project_v3/Database/db_Customer_branch.dart';
import 'package:project_v3/Database/db_Employee.dart';
import 'package:project_v3/Database/db_daily_attendance.dart';
import 'package:project_v3/Database/db_hourly_attendance.dart';
import 'package:project_v3/Database/db_item.dart';
import 'package:project_v3/Models/employee.dart';

class Utility {
  static int totalLeaves = 30;

  static Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/DIMS.png');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  static insert_Admin() async {
    await Database_customer().insertData();
    await Database_customerBranch().insertData();
    await Database_Item.insertData();
    File _pickedImage = await getImageFileFromAssets('images/DIMS.png');
    Database_signUp.addEmp(
      name: "Admin",
      email: "pam2020se@gmail.com",
      phone: "1234567890",
      password: "Admin@123",
      role: "Admin",
      managerid: "2",
      status: "Approved",
      profile_pic: _pickedImage.path,
      darkTheme: 1,
    );

    Database_signUp.addEmp(
      name: "Prince Mehta",
      email: "18bce111@nirmauni.ac.in",
      phone: "1234567890",
      password: "Manager@123",
      role: "General Manager",
      managerid: "2",
      status: "Approved",
      profile_pic: _pickedImage.path,
      darkTheme: 1,
    );
    Database_signUp.addEmp(
      name: "Maurya Patel",
      email: "18bce120@nirmauni.ac.in",
      phone: "1234567890",
      password: "Sales@123",
      role: "Salesperson",
      managerid: "2",
      status: "Approved",
      profile_pic: _pickedImage.path,
      darkTheme: 1,
    );
    Database_signUp.addEmp(
      name: "Dev Rami",
      email: "malhar.shah16@gmail.com",
      phone: "1234567890",
      password: "Sales@123",
      role: "Salesperson",
      managerid: "2",
      status: "Approved",
      profile_pic: _pickedImage.path,
      darkTheme: 1,
    );
    Database_signUp.addEmp(
      name: "Malhar Shah",
      email: "malhar.shah00@gmail.com",
      phone: "1234567890",
      password: "Sales@123",
      role: "Salesperson",
      managerid: "2",
      status: "Approved",
      profile_pic: _pickedImage.path,
      darkTheme: 1,
    );
    Database_Hourly_Attendance.addHourlyAttendance(
      emp_id: 3,
      date: DateTime.now().toString().split(" ")[0],
      time: "10:00",
      latitude: "23.129654",
      longitude: "72.541589",
    );
    Database_Hourly_Attendance.addHourlyAttendance(
      emp_id: 3,
      date: DateTime.now().toString().split(" ")[0],
      time: "11:00",
      latitude: "23.128515",
      longitude: "72.548370",
    );
    Database_Hourly_Attendance.addHourlyAttendance(
      emp_id: 3,
      date: DateTime.now().toString().split(" ")[0],
      time: "12:00",
      latitude: "23.121618",
      longitude: "72.546856",
    );
    Database_Hourly_Attendance.addHourlyAttendance(
      emp_id: 3,
      date: DateTime.now().toString().split(" ")[0],
      time: "13:00",
      latitude: "23.113097",
      longitude: "72.545682",
    );
    Database_Hourly_Attendance.addHourlyAttendance(
      emp_id: 3,
      date: DateTime.now().toString().split(" ")[0],
      time: "14:00",
      latitude: "23.113842",
      longitude: "72.555366",
    );
    Database_Hourly_Attendance.addHourlyAttendance(
      emp_id: 3,
      date: DateTime.now().toString().split(" ")[0],
      time: "15:00",
      latitude: "23.103844",
      longitude: "72.549834",
    );
    Database_Hourly_Attendance.addHourlyAttendance(
      emp_id: 3,
      date: DateTime.now().toString().split(" ")[0],
      time: "16:00",
      latitude: "23.100411",
      longitude: "72.548784",
    );
    Database_Hourly_Attendance.addHourlyAttendance(
      emp_id: 3,
      date: DateTime.now().toString().split(" ")[0],
      time: "17:00",
      latitude: "23.097482",
      longitude: "72.546203",
    );
    Database_Hourly_Attendance.addHourlyAttendance(
      emp_id: 3,
      date: DateTime.now().toString().split(" ")[0],
      time: "18:00",
      latitude: "23.094935",
      longitude: "72.546364",
    );
    Database_Hourly_Attendance.addHourlyAttendance(
      emp_id: 3,
      date: DateTime.now().toString().split(" ")[0],
      time: "19:00",
      latitude: "23.090718",
      longitude: "72.544989",
    );
    Database_Daily_Attendance().updateDailyAttendance(
        emp_id: 3,
        date: DateTime.now().toString().split(" ")[0],
        hours: "09:00");
  }

  static Future<Employee> getEmployee(String email_id) async {
    Employee? emp;
    RegExp _numeric = RegExp(r'^-?[0-9]+$');
    print(email_id);
    if (_numeric.hasMatch(email_id.toString())) {
      emp = await Database_signUp.getEmp(email: '', id: int.parse(email_id));
    } else {
      emp = await Database_signUp.getEmp(email: email_id.toLowerCase(), id: 0);
    }
    return emp!;
  }

  static Future<bool> isNotExist(String email_id) async {
    Employee? emp;
    RegExp _numeric = RegExp(r'^-?[0-9]+$');
    if (_numeric.hasMatch(email_id.toString())) {
      emp = await Database_signUp.getEmp(email: '', id: int.parse(email_id));
    } else {
      emp = await Database_signUp.getEmp(email: email_id.toLowerCase(), id: 0);
    }
    return (emp == null);
  }

  static Future<void> showMessage(BuildContext context, String message,
      {String title: "Alert"}) async {
    showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(title),
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

  static formatDate(date) {
    return date.split(" ")[0].split("-");
  }

  static calculateDifferenceDays(fromDate, toDate) {
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

  static calculateDistance(lat1, long1, lat2, long2) {
    var R = 6371e3;
    lat1 = double.parse(lat1);
    long1 = double.parse(long1);
    lat2 = double.parse(lat2);
    long2 = double.parse(long2);

    var phi1 = (lat1) * (math.pi / 180);
    var phi2 = (lat2) * (math.pi / 180);

    var delphi = (lat2 - lat1) * (math.pi / 180);
    var delLambda = (long2 - long1) * (math.pi / 180);

    var a = math.sin(delphi / 2) * math.sin(delphi / 2) +
        math.cos(phi1) *
            math.cos(phi2) *
            math.sin(delLambda / 2) *
            math.sin(delLambda / 2);

    var c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    var d = (R * c) / 1000;

    return d.toStringAsFixed(2);
  }
}
