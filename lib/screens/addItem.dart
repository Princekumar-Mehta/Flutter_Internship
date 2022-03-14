import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:project_v3/Database/db_item.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/utility.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _formKey = GlobalKey<FormBuilderState>();
  addItem() async {
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
      int barcode =
          int.parse((_formKey.currentState?.value['barcode'].toString())!);
      String pur_Item = checkedValue.toString();
      String sell_Item = checkedValue2.toString();
      int price =
          int.parse((_formKey.currentState?.value['price'].toString())!);
      int net_Weight =
          int.parse((_formKey.currentState?.value['net_Weight'].toString())!);
      Map<String, dynamic> item = {
        "code": "",
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
      Utility.showMessage(
          context,
          await Database_Item.addItem(item)
              ? "Item Added"
              : "Item Already Exist");
    }
  }

  var checkedValue = true;
  var checkedValue2 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: MyColors.scarlet,
                size: MyScreen.getScreenHeight(context) * (30 / 1063.6)),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          title: Text("Add Item",
              style: TextStyle(
                  color: MyColors.white,
                  fontSize: MyScreen.getScreenHeight(context) * (20 / 1063.6))),
          centerTitle: true,
          backgroundColor: MyColors.richBlackFogra,
        ),
        backgroundColor: MyColors.richBlackFogra,
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
                          height:
                              MyScreen.getScreenWidth(context) * (70 / 640)),
                      // SizedBox(
                      //   width: MyScreen.getScreenWidth(context) * (228 / 294),
                      //   height:
                      //       MyScreen.getScreenHeight(context) * (30 / 1063.6),
                      //   child: Text("Item Code *",
                      //       style: TextStyle(
                      //           color: MyColors.pewterBlue,
                      //           fontSize: MyScreen.getScreenHeight(context) *
                      //               (20 / 1063.6))),
                      // ),
                      // SizedBox(
                      //   width: MyScreen.getScreenWidth(context) * (228 / 294),
                      //   height:
                      //       MyScreen.getScreenHeight(context) * (50 / 1063.6),
                      //   child: FormBuilderTextField(
                      //     name: 'code',
                      //     decoration: InputDecoration(
                      //       enabledBorder: UnderlineInputBorder(
                      //           borderSide:
                      //               BorderSide(color: MyColors.pewterBlue)),
                      //     ),
                      //     style: TextStyle(
                      //         color: MyColors.middleRed,
                      //         fontSize: MyScreen.getScreenHeight(context) *
                      //             (25 / 1063.6)),
                      //     validator: (value) {
                      //       RegExp regexcode = RegExp(r'^I[0-9]{4}$');
                      //       if (value == null || value.isEmpty) {
                      //         return "Please Enter Item Code";
                      //       } else if (!regexcode.hasMatch(value)) {
                      //         return "Enter Proper Item Code";
                      //       }
                      //       return null;
                      //     },
                      //   ),
                      // ),
                      SizedBox(
                          height:
                              MyScreen.getScreenHeight(context) * (6 / 553)),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (30 / 1063.6),
                        child: Text("HSN Code *",
                            style: TextStyle(
                                color: MyColors.pewterBlue,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6))),
                      ),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (50 / 1063.6),
                        child: FormBuilderTextField(
                            name: 'hsn_Code',
                            initialValue: "15151515",
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MyColors.pewterBlue)),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            style: TextStyle(
                                color: MyColors.middleRed,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (25 / 1063.6)),
                            validator: (value) {
                              RegExp regexhsn = RegExp(r'^[0-9]{8}$');
                              if (value == null || value.isEmpty) {
                                return "Please Enter HSN Code";
                              } else if (!regexhsn.hasMatch(value)) {
                                return "Enter Proper HSN Code";
                              }
                              return null;
                            }),
                      ),
                      SizedBox(
                          height:
                              MyScreen.getScreenHeight(context) * (6 / 553)),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (30 / 1063.6),
                        child: Text("Item Name *",
                            style: TextStyle(
                                color: MyColors.pewterBlue,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6))),
                      ),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (50 / 1063.6),
                        child: FormBuilderTextField(
                            name: 'item_Name',
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MyColors.pewterBlue)),
                            ),
                            style: TextStyle(
                                color: MyColors.middleRed,
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
                          height:
                              MyScreen.getScreenHeight(context) * (6 / 553)),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (30 / 1063.6),
                        child: Text("Group Name *",
                            style: TextStyle(
                                color: MyColors.pewterBlue,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6))),
                      ),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (50 / 1063.6),
                        child: FormBuilderTextField(
                            name: 'grp',
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MyColors.pewterBlue)),
                            ),
                            style: TextStyle(
                                color: MyColors.middleRed,
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
                          height:
                              MyScreen.getScreenHeight(context) * (6 / 553)),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (30 / 1063.6),
                        child: Text("Sub Group Name *",
                            style: TextStyle(
                                color: MyColors.pewterBlue,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6))),
                      ),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (50 / 1063.6),
                        child: FormBuilderTextField(
                            name: 'sub_Group',
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MyColors.pewterBlue)),
                            ),
                            style: TextStyle(
                                color: MyColors.middleRed,
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
                          height:
                              MyScreen.getScreenHeight(context) * (6 / 553)),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (30 / 1063.6),
                        child: Text("Item Type *",
                            style: TextStyle(
                                color: MyColors.pewterBlue,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6))),
                      ),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (50 / 1063.6),
                        child: FormBuilderTextField(
                            name: 'item_Type',
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MyColors.pewterBlue)),
                            ),
                            style: TextStyle(
                                color: MyColors.middleRed,
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
                          height:
                              MyScreen.getScreenHeight(context) * (6 / 553)),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (30 / 1063.6),
                        child: Text("Number of Units (Ex: 2 [Packet, Box]) *",
                            style: TextStyle(
                                color: MyColors.pewterBlue,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6))),
                      ),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (50 / 1063.6),
                        child: FormBuilderTextField(
                            name: 'unit_Item',
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MyColors.pewterBlue)),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            style: TextStyle(
                                color: MyColors.middleRed,
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
                          height:
                              MyScreen.getScreenHeight(context) * (6 / 553)),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (30 / 1063.6),
                        child: Text("Barcode *",
                            style: TextStyle(
                                color: MyColors.pewterBlue,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6))),
                      ),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (50 / 1063.6),
                        child: FormBuilderTextField(
                            name: 'barcode',
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MyColors.pewterBlue)),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            style: TextStyle(
                                color: MyColors.middleRed,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (25 / 1063.6)),
                            validator: (value) {
                              RegExp regexbarcode = RegExp(r'^[0-9]{9}$');
                              if (value == null || value.isEmpty) {
                                return "Please Enter Barcode";
                              } else if (!regexbarcode.hasMatch(value)) {
                                return "Enter Proper Barcode";
                              }
                              return null;
                            }),
                      ),
                      SizedBox(
                          height:
                              MyScreen.getScreenHeight(context) * (6 / 553)),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (50 / 1063.6),
                        child: Theme(
                          data: ThemeData(
                            unselectedWidgetColor: MyColors.pewterBlue,
                          ),
                          child: CheckboxListTile(
                            title: Text(
                                'Purchase Item (Select if available for Purchase)',
                                style: TextStyle(
                                    color: MyColors.pewterBlue,
                                    fontSize:
                                        MyScreen.getScreenHeight(context) *
                                            (20 / 1063.6))),
                            value: checkedValue,
                            onChanged: (value) {
                              setState(() {
                                checkedValue = !checkedValue;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                            checkColor: MyColors.white,
                            activeColor: MyColors.scarlet,
                          ),
                        ),
                      ),
                      SizedBox(
                          height:
                              MyScreen.getScreenHeight(context) * (6 / 553)),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (50 / 1063.6),
                        child: Theme(
                          data: ThemeData(
                            unselectedWidgetColor: MyColors.pewterBlue,
                          ),
                          child: CheckboxListTile(
                            title: Text(
                                'Sell Item (Select if available for Sales)',
                                style: TextStyle(
                                    color: MyColors.pewterBlue,
                                    fontSize:
                                        MyScreen.getScreenHeight(context) *
                                            (20 / 1063.6))),
                            value: checkedValue2,
                            onChanged: (value) {
                              setState(() {
                                checkedValue2 = !checkedValue2;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                            checkColor: MyColors.white,
                            activeColor: MyColors.scarlet,
                          ),
                        ),
                      ),
                      SizedBox(
                          height:
                              MyScreen.getScreenHeight(context) * (12 / 553)),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (30 / 1063.6),
                        child: Text("Price *",
                            style: TextStyle(
                                color: MyColors.pewterBlue,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6))),
                      ),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (50 / 1063.6),
                        child: FormBuilderTextField(
                            name: 'price',
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MyColors.pewterBlue)),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            style: TextStyle(
                                color: MyColors.middleRed,
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
                          height:
                              MyScreen.getScreenHeight(context) * (6 / 553)),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (30 / 1063.6),
                        child: Text("Net Weight *",
                            style: TextStyle(
                                color: MyColors.pewterBlue,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6))),
                      ),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (50 / 1063.6),
                        child: FormBuilderTextField(
                            name: 'net_Weight',
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MyColors.pewterBlue)),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            style: TextStyle(
                                color: MyColors.middleRed,
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
                          height:
                              MyScreen.getScreenHeight(context) * (6 / 553)),
                      // Button
                      SizedBox(
                          height: MyScreen.getScreenHeight(context) *
                              (60 / 1063.6)),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (85 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (60 / 1063.6),
                        child: InkWell(
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
                                    color: MyColors.middleRed,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text("Save Item",
                                    style: TextStyle(
                                        color: MyColors.richBlackFogra,
                                        fontSize:
                                            MyScreen.getScreenHeight(context) *
                                                (17 / 1063.6),
                                        fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                          onTap: () {
                            addItem();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        )); /*Scaffold(
      appBar: AppBar(
        title: Text("Add Item"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Text("Code: "),
                  Container(
                    width: 100,
                    height: 40,
                    child: FormBuilderTextField(
                      name: "code",
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text("HSN Code: "),
                  Container(
                    width: 100,
                    height: 40,
                    child: FormBuilderTextField(
                      name: "hsn_Code",
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text("Item Name: "),
                  Container(
                    width: 100,
                    height: 40,
                    child: FormBuilderTextField(name: "item_Name"),
                  )
                ],
              ),
              Row(
                children: [
                  Text("Group: "),
                  Container(
                    width: 100,
                    height: 40,
                    child: FormBuilderTextField(name: "grp"),
                  )
                ],
              ),
              Row(
                children: [
                  Text("Sub Group: "),
                  Container(
                    width: 100,
                    height: 40,
                    child: FormBuilderTextField(name: "sub_Group"),
                  )
                ],
              ),
              Row(
                children: [
                  Text("Item Type: "),
                  Container(
                    width: 100,
                    height: 40,
                    child: FormBuilderTextField(name: "item_Type"),
                  )
                ],
              ),
              Row(
                children: [
                  Text("Unit Item: "),
                  Container(
                    width: 100,
                    height: 40,
                    child: FormBuilderTextField(
                      name: "unit_Item",
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text("Bar Code: "),
                  Container(
                    width: 100,
                    height: 40,
                    child: FormBuilderTextField(
                      name: "barcode",
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text("Pur Item: "),
                  Container(
                    width: 100,
                    height: 40,
                    child: FormBuilderTextField(name: "pur_Item"),
                  )
                ],
              ),
              Row(
                children: [
                  Text("Sell Item: "),
                  Container(
                    width: 100,
                    height: 40,
                    child: FormBuilderTextField(name: "sell_Item"),
                  )
                ],
              ),
              Row(
                children: [
                  Text("Price: "),
                  Container(
                    width: 100,
                    height: 40,
                    child: FormBuilderTextField(name: "price"),
                  )
                ],
              ),
              Row(
                children: [
                  Text("Net Weight: "),
                  Container(
                    width: 100,
                    height: 40,
                    child: FormBuilderTextField(
                      name: "net_Weight",
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  )
                ],
              ),
              InkWell(
                onTap: () {
                  addItem();
                },
                child: Text("Add Item"),
              ),
            ],
          ),
        ),
      ),
    );*/
  }
}
