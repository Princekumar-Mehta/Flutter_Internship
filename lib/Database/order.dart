import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/myTypeAhead.dart';

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
    counter = counter! + 1;
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
    counter = counter! - 1;
  }

  saveItem(key) async {
    Item item = await Database_Item().get_Item(item_name![key].getValue());
    print("hsn code of selected item is :" + item.hsn_Code.toString());
    packet![key].text = "0";
    patti![key].text = "0";
    box![key].text = "0";
    price![key].text = "0";
    netWeight![key].text = "0";
    tax![key].text = "0";
    subTotal![key].text = "0";
    total![key].text = "0";
    totalItem![key].text = "0";
    totalItem![key].text = (int.parse(packet![key].text.toString()) +
            int.parse(patti![key].text.toString()) +
            int.parse(box![key].text.toString()))
        .toString();
    subTotal![key].text =
        (double.parse(totalItem![key].text.toString()) * 100).toString();
    tax![key].text = (double.parse(subTotal![key].text) * 0.23).toString();
    total![key].text = (double.parse(subTotal![key].text.toString()) +
            double.parse(tax![key].text.toString()))
        .toString();
  }
}
