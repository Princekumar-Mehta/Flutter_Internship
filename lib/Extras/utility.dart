import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_v3/Database/db_Employee.dart';
import 'package:project_v3/Database/employee.dart';

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
  }

  static Future<Employee> getEmployee(String email_id) async {
    Employee? emp;
    RegExp _numeric = RegExp(r'^-?[0-9]+$');

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

  static Future<void> showMessage(
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
}
