import 'dart:convert';

import 'package:flutter/services.dart';

import '../Models/customer_branch.dart';
import 'database_helper.dart';

class Database_customerBranch {
  static List<String> bill_branch_codes = [];
  static List<String> ship_branch_codes = [];
  static List<CustomerBranch> all_branches = [];
  static List<CustomerBranch> bill_branches = [];
  static List<CustomerBranch> ship_branches = [];
  static List<CustomerBranch> all_ship_branches = [];
  static CustomerBranch specific_branch = CustomerBranch();
  static String iphone_number = "";
  static String iemail = "";

  static addCustomerBranch(Map<String, dynamic> customerBranch) async {
    List<CustomerBranch> existing_customer_branch = await DatabaseHelper
        .instance
        .getCustomerBranchByBranchName(customerBranch['branch_Name']);
    print(existing_customer_branch.length);
    if (existing_customer_branch.isNotEmpty) {
      //print(existing_item[0].item_Name);
      return false;
    } else {
      final customer_Branches =
          await DatabaseHelper.instance.getAllCustomerBranches();
      print("customers length " + customer_Branches.length.toString());
      if (customerBranch['branch_Code'].length == 0) {
        customerBranch['branch_Code'] = "B" +
            (int.parse(customer_Branches[customer_Branches.length - 1]
                        .branch_Code!
                        .substring(
                            1,
                            customer_Branches[customer_Branches.length - 1]
                                .branch_Code!
                                .length)) +
                    1)
                .toString();
      }
      await DatabaseHelper.instance.addCustomerBranch((customerBranch));
      return true;
    }
  }

  get_customerBranches(String customer_code) async {
    bill_branches = await DatabaseHelper.instance
        .getCustomerBranches(0, customer_code); // 0 for bill type, 1 ship type
    bill_branch_codes = [];
    ship_branch_codes = [];
    bill_branches.forEach((element) {
      bill_branch_codes
          .add(element.branch_Code! + " : " + element.branch_Name!);
    });
    ship_branches = await DatabaseHelper.instance
        .getCustomerBranches(1, customer_code); // 0 for bill type, 1 ship type
    ship_branches.forEach((element) {
      ship_branch_codes
          .add(element.branch_Code! + " : " + element.branch_Name!);
    });
  }

  Future<bool> get_AllcustomerBranchesByCode(String customer_code) async {
    all_branches = await DatabaseHelper.instance.getAllCustomerBranchesByCode(
        customer_code); // 0 for bill type, 1 ship type
    return true;
  }

  Future<bool> get_AllcustomerShipBranches() async {
    all_ship_branches = await DatabaseHelper.instance
        .getAllCustomerShipBranches(); // 0 for bill type, 1 ship type
    return true;
  }

  Future<CustomerBranch> get_customerBranch(String branch_Code) async {
    // print(branch_Code);
    final customerBranch =
        await DatabaseHelper.instance.getCustomerBranch(branch_Code);
    if (customerBranch.isEmpty) {
      return CustomerBranch(branch_Code: "BXXXX");
    } else {
      return customerBranch[0];
    }
  }

  Future<Map<String, String>> get_customerBranchContact(String branch) async {
    // print("hello customer branch class");
    final bill_branch = await DatabaseHelper.instance
        .getCustomerBranchContact(branch.substring(0, 5));
    //print(branch.substring(0, 5));
    // print(bill_branch);
    bill_branch.forEach((element) {
      iphone_number = element.branch_Phone.toString();
      iemail = element.branch_Email.toString();
    });
    // print(iphone_number + "   " + iemail);
    return {'phone': iphone_number, 'email': iemail};
  }

  Future<bool> insertData() async {
    bool isData =
        await DatabaseHelper.instance.isCustomerBranchTableContainData();
    if (isData == false) {
      //  print("customer branches data insert");
      List? data;
      var jsonText =
          await rootBundle.loadString('assets/data/CustomerBranch.json');
      data = json.decode(jsonText);
      data!.forEach((element) async {
        //  print(element);
        // print("\n");
        await DatabaseHelper.instance.addCustomerBranch(element);
      });
    }
    return true;
  }

  static Future<bool> updateCustomerBranch(
      Map<String, dynamic> customerBranch) async {
    await DatabaseHelper.instance
        .updateCustomerBranch(CustomerBranch.fromMap(customerBranch));
    return true;
  }
}
