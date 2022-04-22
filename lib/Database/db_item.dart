import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:project_v3/Database/db_customer_branch.dart';
import 'package:project_v3/Database/db_stock.dart';
import 'package:project_v3/Email/send_email.dart';

import '../Models/item.dart';
import 'database_helper.dart';
import 'db_scheme.dart';

class Database_Item {
  static List<String> item_names = [];
  static Map<String, double> discounts = {};
  static List<Item> items = [];
  static Future<bool> addItem(Map<String, dynamic> item) async {
    List<Item> existing_item = await DatabaseHelper.instance
        .getItem(item['item_Name'], item['net_Weight']);
    if (existing_item.isNotEmpty) {
      //print(existing_item[0].item_Name);
      return false;
    } else {
      final items = await DatabaseHelper.instance.getItems();
      bool isItNew = false;
      if (item['code'].length == 0) {
        item['code'] = "I" +
            (int.parse(items[items.length - 1]
                        .code!
                        .substring(1, items[items.length - 1].code!.length)) +
                    1)
                .toString();
        isItNew = true;
      }
      await DatabaseHelper.instance.addItem(Item.fromMap(item));
      Database_Stock.addStock(
          emp_Id: 1,
          role: "Admin",
          item_Id: item['code']!,
          packet: 1000,
          patti: 1000,
          box: 1000,
          minimum_Packet: 0,
          order_Packet: 1000,
          last_Order_In_Packet: 0,
          last_Order_Date: "00-00-0000");

      String message =
          "One more reason to love Balaji! A new item is available for ordering:\n";
      message += "\n\nItem Name: " +
          item['item_Name'].toString() +
          " - " +
          item['net_Weight'].toString() +
          "g" +
          "\nItem Type: " +
          item['item_Type'] +
          "\nItem Price: " +
          item['price'].toString() +
          "\n\n Thank you";
      if (isItNew) {
        if (await Database_customerBranch().get_AllcustomerShipBranches()) {
          for (int i = 0;
              i < Database_customerBranch.all_ship_branches.length;
              i++) {
            Send_Mail.send_mail(
                Database_customerBranch.all_ship_branches[i].branch_Email!,
                "New Item Added",
                "Details<br>\n\n" + message);
          }
        }
      }
      return true;
    }
  }

  static Future<bool> updateItem(Map<String, dynamic> item) async {
    await DatabaseHelper.instance.updateItem(Item.fromMap(item));
    return true;
  }

  Future<bool> get_ItemNames() async {
    item_names = [];
    discounts = {};
    final items = await DatabaseHelper.instance.getItems();
    items.forEach((element) async {
      String temp_item_Name = element.code! +
          " - " +
          element.item_Name! +
          " - " +
          element.net_Weight!.toString() +
          "g";
      String date = DateTime.now().toString().split(" ")[0];
      if (!(await Database_Scheme()
          .isSchemeNotExist(element.code!, date, date))) {
        item_names.add(temp_item_Name + "*");
        discounts[element.code!] = Database_Scheme.discounts.last;
      } else {
        item_names.add(temp_item_Name);
        discounts[element.code!] = 0.0;
      }
    });
    //  //print(item_names);
    return true;
  }

  Future<bool> get_ItemNamesForSell() async {
    item_names = [];
    discounts = {};
    final items = await DatabaseHelper.instance.getItems();
    items.forEach((element) async {
      if (element.sell_Item == 'true') {
        String temp_item_Name = element.code! +
            " - " +
            element.item_Name! +
            " - " +
            element.net_Weight!.toString() +
            "g";
        String date = DateTime.now().toString().split(" ")[0];
        if (!(await Database_Scheme()
            .isSchemeNotExist(element.code!, date, date))) {
          item_names.add(temp_item_Name + "*");
          discounts[element.code!] = Database_Scheme.discounts.last;
        } else {
          item_names.add(temp_item_Name);
          discounts[element.code!] = 0.0;
        }
      }
    });
    //  //print(item_names);
    return true;
  }

  Future<bool> get_Items() async {
    items = await DatabaseHelper.instance.getItems();
    return true;
  }

  Future<Item> get_ItemByItemId(String item_Id) async {
    final items = await DatabaseHelper.instance.getItemByItemId(item_Id);
    return items[0];
  }

  static Future<bool> insertData() async {
    bool isData = await DatabaseHelper.instance.isItemTableContainData();
    if (isData == false) {
      // //print("customer branches data insert");
      List? data;
      var jsonText = await rootBundle.loadString('assets/data/Item.json');
      data = json.decode(jsonText);
      data!.forEach((element) {
        Database_Item.addItem(element);
      });
    }
    return true;
  }
}
