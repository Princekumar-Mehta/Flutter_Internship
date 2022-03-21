import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_v3/Database/db_final_individual_order.dart';
import 'package:project_v3/Database/db_final_order.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/myTypeAhead.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/Extras/utility.dart';

import 'customer.dart';
import 'customer_branch.dart';
import 'db_item.dart';
import 'employee.dart';
import 'item.dart';

class Order {
  List<MyTypeAhead>? item_name;
  List<TextEditingController>? packet;
  List<TextEditingController>? patti;
  List<TextEditingController>? box;
  List<TextEditingController>? price;
  List<TextEditingController>? netWeight;
  List<TextEditingController>? subTotal;
  List<TextEditingController>? total;
  List<TextEditingController>? totalItem;
  List<TextEditingController>? tax;
  String file_Address = "";
  Employee salesPerson = Employee();
  int current = -1;
  Customer customer = Customer();
  CustomerBranch billing_branch = CustomerBranch();
  CustomerBranch shipping_branch = CustomerBranch();
  String manufacturing_Branch = "";
  String OrderBydate = "";
  late List<Item> item_detials;
  int? counter;
  int final_total = 0;
  Order() {
    counter = 0;
    item_name = [];
    packet = [];
    patti = [];
    box = [];
    price = [];
    netWeight = [];
    subTotal = [];
    total = [];
    totalItem = [];
    tax = [];
    item_detials = [];
    manufacturing_Branch = "";
  }
  print_order() {
    List<Map<String, dynamic>> my_order = [];
    for (int i = 0; i < counter!; i++) {
      Map<String, dynamic> json = {
        'item_Name': item_name![i].getValue(),
        'packet': packet![i].text.toString(),
        'patti': patti![i].text.toString(),
        'box': box![i].text.toString(),
        'price': price![i].text.toString(),
        'netWeight': netWeight![i].text.toString(),
        'subTotal': subTotal![i].text.toString(),
        'total': total![i].text.toString(),
        'totalItem': totalItem![i].text.toString(),
        'tax': tax![i].text.toString(),
      };
      final_total =
          final_total + double.parse(total![i].text.toString()).round();
      my_order.add({
        'item_no': i,
        "order": json,
      });
    }
    String orders = my_order.toString();
    List<String> ordersL1 = (orders.split("}}"));
    for (int i = 0; i < ordersL1.length; i++) {
      print(ordersL1[i]);
      print("\n");
    }

    Map<String, dynamic> final_order = {
      'customer_Code': customer.code,
      'billing_Branch': billing_branch.branch_Code,
      'shipping_Branch': shipping_branch.branch_Code,
      'manufacturing_Branch': manufacturing_Branch,
      'order': my_order.toString(),
    };
    var encoder = JsonEncoder.withIndent("   ");
    //  print(encoder.convert(final_order));
  }

  addToDatabase(context) async {
    final_total = 0;
    for (int i = 0; i < counter!; i++) {
      print(final_total);
      final_total =
          final_total + double.parse(total![i].text.toString()).round();
    }
    int order_Id = (await Database_Final_Order().getFinalOrdersLastId()) + 1;
    print("total is " + final_total.toString());
    Database_Final_Order.addFinalOrder(
        customer_Code: customer.code!,
        billing_Branch_Code: billing_branch.branch_Code!,
        shipping_Branch_Code: shipping_branch.branch_Code!,
        manufacturing_Branch_Code: manufacturing_Branch,
        order_Id: order_Id,
        total: final_total,
        order_by_date: OrderBydate,
        file_Address: file_Address,
        salesperson_Code: salesPerson.id!);
    for (int i = 0; i < counter!; i++) {
      Database_Final_Individual_Order.addFinalIndividualOrder(
          order_Id: order_Id,
          packet: int.parse(packet![i].text),
          patti: int.parse(patti![i].text),
          box: int.parse(box![i].text),
          item_Code: item_detials[i].code!);
    }
    final_total = 0;
    return true;
  }

  giveTextFormField(mycontroller, context,
      {isEditable = true, myAlign = TextAlign.right}) {
    return TextFormField(
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 13)),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      controller: mycontroller,
      onChanged: (value) {},
      textAlign: myAlign,
      readOnly: !isEditable,
      style: TextStyle(
          color: MyDrawer.emp.darkTheme == 1
              ? MyColors.pewterBlue
              : MyColors.black,
          fontSize: MyScreen.getScreenHeight(context) * (18 / 1069.9)),
    );
  }

  addItem(BuildContext context) {
    item_name!.add(MyTypeAhead(
        itemList: Database_Item.item_names,
        message: "Please Enter Item Name",
        isEnabled: true));
    packet!.add(TextEditingController(text: "0"));
    patti!.add(TextEditingController(text: "0"));
    box!.add(TextEditingController(text: "0"));
    price!.add(TextEditingController(text: "0"));
    netWeight!.add(TextEditingController(text: "0"));
    tax!.add(TextEditingController(text: "0"));
    subTotal!.add(TextEditingController(text: "0"));
    total!.add(TextEditingController(text: "0"));
    totalItem!.add(TextEditingController(text: "0"));
    item_detials.add(Item());
    counter = counter! + 1;
    current = counter! - 1;
    print(counter);
  }

  deleteItem(key) {
    for (int i = key; i < item_name!.length - 1; i++) {
      item_name![i].setValue(item_name![i + 1].getValue());
      packet![i].text = packet![i + 1].text;
      patti![i].text = patti![i + 1].text;
      box![i].text = box![i + 1].text;
      price![i].text = price![i + 1].text;
      netWeight![i].text = netWeight![i + 1].text;
      tax![i].text = tax![i + 1].text;
      subTotal![i].text = subTotal![i + 1].text;
      total![i].text = total![i + 1].text;
      totalItem![i].text = totalItem![i + 1].text;
      item_detials[i] = item_detials[i + 1];
    }

    item_name!.removeAt(key);
    price!.removeAt(key);
    netWeight!.removeAt(key);
    packet!.removeAt(key);
    box!.removeAt(key);
    patti!.removeAt(key);
    tax!.removeAt(key);
    subTotal!.removeAt(key);
    total!.removeAt(key);
    totalItem!.removeAt(key);
    item_detials.removeAt(key);
    counter = counter! - 1;
    current = counter! - 1;
  }

  fillIfNull(key) {
    if (packet![key].text.toString().isEmpty) {
      packet![key].text = "0";
    }
    if (patti![key].text.toString().isEmpty) {
      patti![key].text = "0";
    }
    if (box![key].text.toString().isEmpty) {
      box![key].text = "0";
    }
  }

  Future<bool> saveItem(key, BuildContext context, {bool close = true}) async {
    if (item_name![key].getValue().toString().isEmpty) {
      Utility.showMessage(context, "Please enter Item Name");
      fillIfNull(key);
      return false;
    }
    item_detials[key] =
        await Database_Item().get_Item(item_name![key].getValue());
    fillIfNull(key);

    price![key].text = item_detials[key].price.toString();
    netWeight![key].text = item_detials[key].net_Weight.toString();
    tax![key].text = "0";
    subTotal![key].text = "0";
    totalItem![key].text = (int.parse(packet![key].text.toString()) +
            (int.parse(patti![key].text.toString()) * 5) +
            (int.parse(box![key].text.toString()) * 3 * 5))
        .toString();
    subTotal![key].text = (double.parse(totalItem![key].text.toString()) *
            item_detials[key].price!)
        .toStringAsFixed(2);
    tax![key].text =
        (double.parse(subTotal![key].text.toString()) * (.120182346))
            .toStringAsFixed(2);
    total![key].text = (double.parse(tax![key].text.toString()) +
            double.parse(subTotal![key].text.toString()))
        .toStringAsFixed(2);
    if (totalItem![key].text.toString() == "0") {
      Utility.showMessage(context, "Please Fill Qty");
      return false;
    }
    current = -1;
    return true;
  }
}
