import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:project_v3/Database/db_item.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/Extras/utility.dart';
import 'package:project_v3/Models/item.dart';

import '../Extras/routes.dart';

class EditItem extends StatefulWidget {
  Item item;
  EditItem({required this.item});

  @override
  _EditItemState createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  final _formKey = GlobalKey<FormBuilderState>();
  Future<void> confirmationDialog(
    BuildContext context,
    String message,
  ) async {
    showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Alert'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('No'),
            onPressed: () async {
              Navigator.pop(c, false);
            },
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () async {
              Navigator.pop(c, false);
              // MyDrawer.emp = widget.emp;
              Navigator.popUntil(
                  context, ModalRoute.withName(MyRoutes.MyAdminHome));
            },
          ),
        ],
      ),
    );
  }

  EditItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // String code = (_formKey.currentState?.value['code'].toString())!;
      int hsn_Code =
          int.parse((_formKey.currentState?.value['hsn_Code'].toString())!);
      String item_Name =
          (_formKey.currentState?.value['item_Name'].toString())!;
      String grp = (_formKey.currentState?.value['grp'].toString())!;
      String sub_Group =
          (_formKey.currentState?.value['sub_Group'].toString())!;
      String item_Type =
          (_formKey.currentState?.value['item_Type'].toString())!;
      int unit_Item =
          int.parse((_formKey.currentState?.value['unit_Item'].toString())!);
      String? barcodestr = _formKey.currentState?.value['barcode'].toString();
      if (_formKey.currentState?.value['barcode'].toString() !=
          widget.item.barcode!.toString()) {
        print(barcodestr);
        print(widget.item.barcode!.toString());
        if (await Utility.isBarcodeNotExist(barcodestr!)) {
          Utility.showMessage(context,
              "Barcode already assigned. Please change the Barcode to Continue.");
          return;
        }
      }
      int barcode =
          int.parse((_formKey.currentState?.value['barcode'].toString())!);
      String pur_Item = checkedValue.toString();
      String sell_Item = checkedValue2.toString();
      int price =
          int.parse((_formKey.currentState?.value['price'].toString())!);
      int net_Weight =
          int.parse((_formKey.currentState?.value['net_Weight'].toString())!);
      Map<String, dynamic> item = {
        "code": widget.item.code,
        "hsn_Code": hsn_Code,
        "item_Name": item_Name,
        "grp": grp,
        "sub_Group": sub_Group,
        "item_Type": item_Type,
        "unit_Item": unit_Item,
        "barcode": barcode,
        "pur_Item": pur_Item,
        "sell_Item": sell_Item,
        "price": price,
        "net_Weight": net_Weight
      };
      print(item);
      if (await Database_Item.updateItem(item)) {
        Utility.showMessage(context, "Item Updated");
        Navigator.popUntil(context, ModalRoute.withName(MyRoutes.MyAdminHome));
        if (await Database_Item().get_Items()) {
          Navigator.pushNamed(context, MyRoutes.MyViewItems);
        }
      }
    }
  }

  var checkedValue;
  var checkedValue2;
  @override
  void initState() {
    //implement initState
    checkedValue = widget.item.pur_Item == "true" ? true : false;
    checkedValue2 = widget.item.sell_Item == "true" ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: MyDrawer.emp.darkTheme == 1
                  ? MyColors.white
                  : MyColors.scarlet,
              size: MyScreen.getScreenHeight(context) * (30 / 1063.6)),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              if (widget.item.hsn_Code.toString() !=
                      _formKey.currentState!.value['hsn_Code'].toString() ||
                  widget.item.item_Name !=
                      _formKey.currentState!.value['item_Name'] ||
                  widget.item.grp != _formKey.currentState!.value['grp'] ||
                  widget.item.sub_Group !=
                      _formKey.currentState!.value['sub_Group'] ||
                  widget.item.item_Type !=
                      _formKey.currentState!.value['item_Type'] ||
                  widget.item.unit_Item.toString() !=
                      _formKey.currentState!.value['unit_Item'].toString() ||
                  widget.item.barcode.toString() !=
                      _formKey.currentState!.value['barcode'].toString() ||
                  widget.item.pur_Item.toString() != checkedValue.toString() ||
                  widget.item.sell_Item.toString() !=
                      checkedValue2.toString() ||
                  widget.item.price.toString() !=
                      _formKey.currentState!.value['price'].toString() ||
                  widget.item.net_Weight.toString() !=
                      _formKey.currentState!.value['net_Weight'].toString()) {
                confirmationDialog(context,
                    "Exit to Edit Item Page?\n\nChanges will not be saved.");
              } else {
                Navigator.popUntil(
                    context, ModalRoute.withName(MyRoutes.MyViewItems));
              }
            }
          },
        ),
        shape: Border(
          bottom: BorderSide(
            color: MyColors.scarlet,
            width: MyScreen.getScreenHeight(context) * (4 / 1063.6),
          ),
        ),
        title: Text("Edit Item",
            style: TextStyle(
                color: MyDrawer.emp.darkTheme == 1
                    ? MyColors.white
                    : MyColors.scarlet,
                fontSize: MyScreen.getScreenHeight(context) * (20 / 1063.6))),
        centerTitle: true,
        backgroundColor: MyDrawer.emp.darkTheme == 1
            ? MyColors.richBlackFogra
            : MyColors.white,
      ),
      backgroundColor: MyDrawer.emp.darkTheme == 1
          ? MyColors.richBlackFogra
          : MyColors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            alignment: Alignment.center,
            child: Stack(children: [
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                        height: MyScreen.getScreenWidth(context) * (70 / 640)),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                      child: Text("HSN Code *",
                          style: TextStyle(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.pewterBlue
                                  : MyColors.black,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (20 / 1063.6))),
                    ),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (50 / 1063.6),
                      child: FormBuilderTextField(
                          name: 'hsn_Code',
                          initialValue: widget.item.hsn_Code!.toString(),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: MyDrawer.emp.darkTheme == 1
                                        ? MyColors.pewterBlue
                                        : MyColors.black)),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: TextStyle(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.middleRed
                                  : MyColors.scarlet,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (25 / 1063.6)),
                          validator: (value) {
                            RegExp regexhsn = RegExp(r'^[0-9]{8}$');
                            if (value == null || value.isEmpty) {
                              return "Please Enter HSN Code";
                            } else if (!regexhsn.hasMatch(value)) {
                              return "Enter Proper HSN Code (Ex: 12345678)";
                            }
                            return null;
                          }),
                    ),
                    SizedBox(
                        height: MyScreen.getScreenHeight(context) * (6 / 553)),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                      child: Text("Item Name *",
                          style: TextStyle(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.pewterBlue
                                  : MyColors.black,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (20 / 1063.6))),
                    ),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (50 / 1063.6),
                      child: FormBuilderTextField(
                          name: 'item_Name',
                          initialValue: widget.item.item_Name,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: MyDrawer.emp.darkTheme == 1
                                        ? MyColors.pewterBlue
                                        : MyColors.black)),
                          ),
                          style: TextStyle(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.middleRed
                                  : MyColors.scarlet,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (25 / 1063.6)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Item Name";
                            }
                            return null;
                          }),
                    ),
                    SizedBox(
                        height: MyScreen.getScreenHeight(context) * (6 / 553)),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                      child: Text("Group Name *",
                          style: TextStyle(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.pewterBlue
                                  : MyColors.black,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (20 / 1063.6))),
                    ),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (50 / 1063.6),
                      child: FormBuilderTextField(
                          name: 'grp',
                          initialValue: widget.item.grp,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.pewterBlue
                                  : MyColors.black,
                            )),
                          ),
                          style: TextStyle(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.middleRed
                                  : MyColors.scarlet,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (25 / 1063.6)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Group Name";
                            }
                            return null;
                          }),
                    ),
                    SizedBox(
                        height: MyScreen.getScreenHeight(context) * (6 / 553)),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                      child: Text("Sub Group Name *",
                          style: TextStyle(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.pewterBlue
                                  : MyColors.black,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (20 / 1063.6))),
                    ),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (50 / 1063.6),
                      child: FormBuilderTextField(
                          name: 'sub_Group',
                          initialValue: widget.item.sub_Group,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.pewterBlue
                                  : MyColors.black,
                            )),
                          ),
                          style: TextStyle(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.middleRed
                                  : MyColors.scarlet,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (25 / 1063.6)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Sub Group Name";
                            }
                            return null;
                          }),
                    ),
                    SizedBox(
                        height: MyScreen.getScreenHeight(context) * (6 / 553)),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                      child: Text("Item Type *",
                          style: TextStyle(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.pewterBlue
                                  : MyColors.black,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (20 / 1063.6))),
                    ),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (50 / 1063.6),
                      child: FormBuilderTextField(
                          name: 'item_Type',
                          initialValue: widget.item.item_Type,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.pewterBlue
                                  : MyColors.black,
                            )),
                          ),
                          style: TextStyle(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.middleRed
                                  : MyColors.scarlet,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (25 / 1063.6)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Item Type";
                            }
                            return null;
                          }),
                    ),
                    SizedBox(
                        height: MyScreen.getScreenHeight(context) * (6 / 553)),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                      child: Text("Number of Units (Ex: 2 [Packet, Box]) *",
                          style: TextStyle(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.pewterBlue
                                  : MyColors.black,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (20 / 1063.6))),
                    ),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (50 / 1063.6),
                      child: FormBuilderTextField(
                          name: 'unit_Item',
                          initialValue: widget.item.unit_Item.toString(),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.pewterBlue
                                  : MyColors.black,
                            )),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: TextStyle(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.middleRed
                                  : MyColors.scarlet,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (25 / 1063.6)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Number of Units";
                            }
                            return null;
                          }),
                    ),
                    SizedBox(
                        height: MyScreen.getScreenHeight(context) * (6 / 553)),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                      child: Text("Barcode *",
                          style: TextStyle(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.pewterBlue
                                  : MyColors.black,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (20 / 1063.6))),
                    ),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (50 / 1063.6),
                      child: FormBuilderTextField(
                          name: 'barcode',
                          initialValue: widget.item.barcode.toString(),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.pewterBlue
                                  : MyColors.black,
                            )),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: TextStyle(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.middleRed
                                  : MyColors.scarlet,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (25 / 1063.6)),
                          validator: (value) {
                            RegExp regexbarcode = RegExp(r'^[0-9]{9}$');
                            if (value == null || value.isEmpty) {
                              return "Please Enter Barcode";
                            } else if (!regexbarcode.hasMatch(value)) {
                              return "Enter Proper Barcode (Ex: 123456789)";
                            }
                            return null;
                          }),
                    ),
                    SizedBox(
                        height: MyScreen.getScreenHeight(context) * (6 / 553)),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (50 / 1063.6),
                      child: Theme(
                        data: ThemeData(
                          unselectedWidgetColor: MyDrawer.emp.darkTheme == 1
                              ? MyColors.pewterBlue
                              : MyColors.black,
                        ),
                        child: CheckboxListTile(
                          title: Text(
                              'Purchase Item (Select if available for Purchase)',
                              style: TextStyle(
                                  color: MyDrawer.emp.darkTheme == 1
                                      ? MyColors.pewterBlue
                                      : MyColors.black,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (20 / 1063.6))),
                          value: checkedValue,
                          onChanged: (value) {
                            setState(() {
                              checkedValue = !checkedValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          checkColor: MyColors.white,
                          activeColor: MyDrawer.emp.darkTheme == 1
                              ? MyColors.middleRed
                              : MyColors.scarlet,
                        ),
                      ),
                    ),
                    SizedBox(
                        height: MyScreen.getScreenHeight(context) * (6 / 553)),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (50 / 1063.6),
                      child: Theme(
                        data: ThemeData(
                          unselectedWidgetColor: MyDrawer.emp.darkTheme == 1
                              ? MyColors.pewterBlue
                              : MyColors.black,
                        ),
                        child: CheckboxListTile(
                          title: Text(
                              'Sell Item (Select if available for Sales)',
                              style: TextStyle(
                                  color: MyDrawer.emp.darkTheme == 1
                                      ? MyColors.pewterBlue
                                      : MyColors.black,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (20 / 1063.6))),
                          value: checkedValue2,
                          onChanged: (value) {
                            setState(() {
                              checkedValue2 = !checkedValue2;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          checkColor: MyColors.white,
                          activeColor: MyDrawer.emp.darkTheme == 1
                              ? MyColors.middleRed
                              : MyColors.scarlet,
                        ),
                      ),
                    ),
                    SizedBox(
                        height: MyScreen.getScreenHeight(context) * (12 / 553)),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                      child: Text("Price *",
                          style: TextStyle(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.pewterBlue
                                  : MyColors.black,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (20 / 1063.6))),
                    ),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (50 / 1063.6),
                      child: FormBuilderTextField(
                          name: 'price',
                          initialValue: widget.item.price.toString(),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.pewterBlue
                                  : MyColors.black,
                            )),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: TextStyle(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.middleRed
                                  : MyColors.scarlet,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (25 / 1063.6)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Price";
                            }
                            return null;
                          }),
                    ),
                    SizedBox(
                        height: MyScreen.getScreenHeight(context) * (6 / 553)),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                      child: Text("Net Weight *",
                          style: TextStyle(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.pewterBlue
                                  : MyColors.black,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (20 / 1063.6))),
                    ),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (50 / 1063.6),
                      child: FormBuilderTextField(
                          name: 'net_Weight',
                          initialValue: widget.item.net_Weight.toString(),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.pewterBlue
                                  : MyColors.black,
                            )),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: TextStyle(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.middleRed
                                  : MyColors.scarlet,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (25 / 1063.6)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Net Weight";
                            }
                            return null;
                          }),
                    ),
                    SizedBox(
                        height: MyScreen.getScreenHeight(context) * (6 / 553)),
                    // Button
                    SizedBox(
                        height:
                            MyScreen.getScreenHeight(context) * (60 / 1063.6)),
                    InkWell(
                      onTap: () {
                        EditItem();
                      },
                      child: SizedBox(
                        width: MyScreen.getScreenWidth(context) * (85 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (60 / 1063.6),
                        child: Stack(
                          children: [
                            Opacity(
                              opacity: 0.8,
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      MyScreen.getScreenHeight(context) *
                                          (10 / 1063.6)),
                                  color: MyDrawer.emp.darkTheme == 1
                                      ? MyColors.middleRed
                                      : MyColors.scarlet,
                                ),
                              ),
                            ),
                            Center(
                              child: Text("Save Item",
                                  style: TextStyle(
                                      color: MyDrawer.emp.darkTheme == 1
                                          ? MyColors.richBlackFogra
                                          : MyColors.white,
                                      fontSize:
                                          MyScreen.getScreenHeight(context) *
                                              (17 / 1063.6),
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
