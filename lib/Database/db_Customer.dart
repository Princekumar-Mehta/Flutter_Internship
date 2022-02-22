import 'dart:convert';

import 'package:flutter/services.dart';

import 'customer.dart';
import 'database_helper.dart';

class Database_customer {
  static List<String> codes = [];
  static addCustomer(Map<String, dynamic> customer) async {
    await DatabaseHelper.instance.addCustomer(Customer.fromMap(customer));
  }

  Future<Customer> get_customer(String customer_Code) async {
    final customers = await DatabaseHelper.instance.getCustomer(customer_Code);
    return customers[0];
  }

  static print_customer() async {
    final customers = await DatabaseHelper.instance.getCustomers();
    // print(customers);
    //for (int i = 0; i < customers.length; i++) print(customers[i].toMap());
  }

  get_customerIds() async {
    final customers = await DatabaseHelper.instance.getCustomers();
    customers.forEach((element) {
      codes.add(element.code!);
    });
    //print(codes);
  }

  static insertData() async {
    bool isData = await DatabaseHelper.instance.isCustomerTableContainData();
    if (isData == false) {
      //  print("customer data insert");
      List? data;
      var jsonText = await rootBundle.loadString('assets/data/Customer.json');
      data = json.decode(jsonText);
      data!.forEach((element) {
        Database_customer.addCustomer(element);
      });
    }
  }
}
