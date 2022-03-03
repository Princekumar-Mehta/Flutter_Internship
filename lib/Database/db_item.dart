import 'dart:convert';

import 'package:flutter/services.dart';

import 'database_helper.dart';
import 'item.dart';

class Database_Item {
  static List<String> item_names = [];
  static addItem(Map<String, dynamic> order_item) async {
    await DatabaseHelper.instance.addItem(Item.fromMap(order_item));
  }

  get_Items() async {
    item_names = [];
    final items = await DatabaseHelper.instance
        .getItems(); // 0 for bill type, 1 ship type
    items.forEach((element) {
      item_names.add(element.item_Name!);
    });
    print(item_names);
  }

  Future<Item> get_Item(String item_name) async {
    final items = await DatabaseHelper.instance
        .getItem(item_name); // 0 for bill type, 1 ship type
    return items[0];
  }

  static insertData() async {
    bool isData = await DatabaseHelper.instance.isItemTableContainData();
    if (isData == false) {
      // print("customer branches data insert");
      List? data;
      var jsonText = await rootBundle.loadString('assets/data/Item.json');
      data = json.decode(jsonText);
      data!.forEach((element) {
        Database_Item.addItem(element);
      });
    }
  }
}
