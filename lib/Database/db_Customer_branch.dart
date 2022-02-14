import 'dart:convert';

import 'package:flutter/services.dart';

import 'customer_branch.dart';
import 'database_helper.dart';

class Database_customerBranch {
  static List<String> bill_branch_codes = [];
  static List<String> ship_branch_codes = [];
  static String iphone_number = "";
  static String iemail = "";
  static addCustomerBranch(Map<String, dynamic> customer_branch) async {
    await DatabaseHelper.instance
        .addCustomerBranch(Customer_Branch.fromMap(customer_branch));
  }

  get_customerBranches(String customer_code) async {
    final bill_branches = await DatabaseHelper.instance
        .getCustomerBranches(0, customer_code); // 0 for bill type, 1 ship type
    bill_branches.forEach((element) {
      bill_branch_codes
          .add(element.branch_code! + " : " + element.branch_Name!);
    });
    final ship_branches = await DatabaseHelper.instance
        .getCustomerBranches(1, customer_code); // 0 for bill type, 1 ship type
    ship_branches.forEach((element) {
      ship_branch_codes
          .add(element.branch_code! + " : " + element.branch_Name!);
    });
    print(ship_branch_codes);
  }

  static get_customerBranchContact(String branch) async {
    print("hello customer branch class");
    final bill_branch = await DatabaseHelper.instance
        .getCustomerBranchContact(branch.substring(0, 5));
    print(branch.substring(0, 5));
    bill_branch.forEach((element) {
      iphone_number = element.branch_Phone.toString();
      iemail = element.branch_Email.toString();
      print(iphone_number + iemail);
      return;
    });
  }

  static insertData() async {
    bool isData =
        await DatabaseHelper.instance.isCustomerBranchTableContainData();
    if (isData == false) {
      print("customer branches data insert");
      List? data;
      var jsonText =
          await rootBundle.loadString('assets/data/CustomerBranch.json');
      data = json.decode(jsonText);
      data!.forEach((element) {
        Database_customerBranch.addCustomerBranch(element);
      });
    }
  }
}
