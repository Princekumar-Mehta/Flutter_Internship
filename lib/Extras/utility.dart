import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_v3/Database/db_SignUp.dart';

class Utility {
  static Future<Employee> getEmployee(String email_id) async {
    Employee? emp;
    RegExp _numeric = RegExp(r'^-?[0-9]+$');
    if (email_id == '' && _numeric.hasMatch(email_id.toString())) {
      emp = await Database_signUp.getEmp(email: '', id: int.parse(email_id));
    } else {
      emp = await Database_signUp.getEmp(email: email_id.toLowerCase(), id: 0);
    }
    return emp!;
  }

  static Future<bool> isExist(String email_id) async {
    Employee? emp;
    RegExp _numeric = RegExp(r'^-?[0-9]+$');
    if (email_id == '' && _numeric.hasMatch(email_id.toString())) {
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
