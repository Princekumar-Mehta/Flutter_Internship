import 'dart:convert';

import 'package:flutter/services.dart';

import '../Models/customer.dart';
import 'database_helper.dart';

class Database_customer {
  static List<String> codes = [];
  static List<Customer> customers = [];
  static addCustomer(Map<String, dynamic> customer) async {
    List<Customer> existing_customer = await DatabaseHelper.instance
        .getCustomerByPartyName(customer['party_Name']);
    print(existing_customer.length);
    if (existing_customer.isNotEmpty) {
      //print(existing_item[0].item_Name);
      return false;
    } else {
      final customers = await DatabaseHelper.instance.getCustomers();
      print("customers length " + customers.length.toString());
      if (customer['code'].length == 0) {
        customer['code'] = "DST" +
            (int.parse(customers[customers.length - 1].code!.substring(
                        3, customers[customers.length - 1].code!.length)) +
                    1)
                .toString();
      }
      await DatabaseHelper.instance.addCustomer(Customer.fromMap(customer));
      return true;
    }
  }

  static Future<bool> getAllCustomers() async {
    customers = (await DatabaseHelper.instance.getCustomers());
    print(customers.length);
    return true;
  }

  Future<Customer> get_customer(String customer_Code) async {
    final customers = await DatabaseHelper.instance.getCustomer(customer_Code);
    if (customers.isEmpty) {
      return Customer(code: "DSTXXXX");
    } else {
      return customers[0];
    }
  }

  static print_customer() async {
    final customers = await DatabaseHelper.instance.getCustomers();
    // print(customers);
    //for (int i = 0; i < customers.length; i++) print(customers[i].toMap());
  }

  Future<bool> get_customerIds() async {
    final customers = await DatabaseHelper.instance.getCustomers();
    codes = [];
    customers.forEach((element) {
      codes.add(element.code!);
    });
    return true;
    //print(codes);
  }

  Future<bool> insertData() async {
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
    return true;
  }

  static Future<bool> updateCustomer(Map<String, dynamic> customer) async {
    await DatabaseHelper.instance.updateCustomer(Customer.fromMap(customer));
    return true;
  }
}
