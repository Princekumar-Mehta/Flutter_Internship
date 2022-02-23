import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/myTypeAhead.dart';
import 'package:project_v3/Extras/utility.dart';

import 'customer.dart';
import 'customer_branch.dart';
import 'db_item.dart';
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
  int current = -1;
  Customer customer = Customer();
  CustomerBranch billing_branch = CustomerBranch();
  CustomerBranch shipping_branch = CustomerBranch();
  late List<Item> item_detials;
  int? counter;

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
  }
  print_order() {
    List<Map<String, dynamic>> my_order = [];
    for (int i = 0; i < counter!; i++) {
      Map<String, dynamic> json = {
        'item_name': item_name![i],
        'packet': packet![i],
        'patti': patti![i],
        'box': box![i],
        'price': price![i],
        'netWeight': netWeight![i],
        'subTotal': subTotal![i],
        'total': total![i],
        'totalItem': totalItem![i],
        'tax': tax![i],
        'item_details': item_detials[i],
      };
      my_order.add({
        'item_no': i,
        "order": json,
      });
    }
    print(my_order);
  }

  giveTextFormField(mycontroller, context,
      {isEditable = true, myAlign = TextAlign.right}) {
    return TextFormField(
      decoration:
          InputDecoration(contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 13)),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      controller: mycontroller,
      onChanged: (value) {},
      textAlign: myAlign,
      readOnly: !isEditable,
      style: TextStyle(
          color: MyColors.pewterBlue,
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
