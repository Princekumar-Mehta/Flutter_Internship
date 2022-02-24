import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_v3/Database/db_SignUp.dart';
import 'package:project_v3/Database/employee.dart';

class Utility {
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
        password: "Admin@123",
        role: "Admin",
        status: "Approved",
        profile_pic: _pickedImage.path);
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
}
