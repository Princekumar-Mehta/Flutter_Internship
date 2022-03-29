import 'dart:convert';

import 'package:flutter/services.dart';

import '../Models/item.dart';
import 'database_helper.dart';

class Database_Item {
  static List<String> item_names = [];
  static List<Item> items = [];
  static Future<bool> addItem(Map<String, dynamic> item) async {
    List<Item> existing_item = await DatabaseHelper.instance
        .getItem(item['item_Name'], item['net_Weight']);
    if (existing_item.isNotEmpty) {
      //print(existing_item[0].item_Name);
      return false;
    } else {
      final items = await DatabaseHelper.instance.getItems();
      if (item['code'].length == 0) {
        item['code'] = "I" +
            (int.parse(items[items.length - 1]
                        .code!
                        .substring(1, items[items.length - 1].code!.length)) +
                    1)
                .toString();
      }
      await DatabaseHelper.instance.addItem(Item.fromMap(item));
      return true;
    }
  }

  static Future<bool> updateItem(Map<String, dynamic> item) async {
    await DatabaseHelper.instance.updateItem(Item.fromMap(item));
    return true;
  }

  Future<bool> get_ItemNames() async {
    item_names = [];
    final items = await DatabaseHelper.instance.getItems();
    items.forEach((element) {
      item_names.add(
          element.item_Name! + " - " + element.net_Weight!.toString() + "g");
      //print(element.code! + "\n");
    });
    //  //print(item_names);
    return true;
  }

  Future<bool> get_Items() async {
    items = await DatabaseHelper.instance.getItems();
    return true;
  }

  Future<Item> get_Item(String item_name, int net_Weight) async {
    final items = await DatabaseHelper.instance.getItem(item_name, net_Weight);
    return items[0];
  }

  Future<Item> get_ItemByItemId(String item_Id) async {
    final items = await DatabaseHelper.instance.getItemByItemId(item_Id);
    return items[0];
  }

  static insertData() async {
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
  }
}
