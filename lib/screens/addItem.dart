import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:project_v3/Database/db_item.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';
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
      String? barcodestr = _formKey.currentState?.value['barcode'].toString();
      if (await Utility.isBarcodeNotExist(barcodestr!)) {
        Utility.showMessage(context,
            "Barcode already assigned. Please change the Barcode to Continue.");
        return;
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
      bool isAdded = await Database_Item.addItem(item);

      showMessage(
          context, isAdded ? "Item Added" : "Item Already Exist", isAdded);
    }
  }

  static Future<void> showMessage(
    BuildContext context,
    String message,
    bool isAdded,
  ) async {
    showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Alert'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('Okay'),
            onPressed: () async {
              Navigator.pop(c, false);
              if (isAdded) Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  var checkedValue = true;

  var checkedValue2 = true;
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
            // if (_formKey.currentState!.validate()) {
            //   _formKey.currentState!.save();
            //   if (MyDrawer.emp.name.toString() !=
            //       _formKey.currentState!.value['full_name'] ||
            //       MyDrawer.emp.email.toString() !=
            //           _formKey.currentState!.value['email'] ||
            //       MyDrawer.emp.password.toString() !=
            //           _formKey.currentState!.value['password_1'] ||
            //       MyDrawer.emp.role.toString() !=
            //           _formKey.currentState!.value['role'] ||
            //       MyDrawer.emp.profile_pic.toString() != _pickedImage!.path) {
            //     confirmationDialog(context,
            //         "Exit to Home Page?\n\nChanges will not be saved.");
            //   } else {
            //     Navigator.pop(context);
            //   }
            // }
            Navigator.pop(context);
          },
        ),
        shape: Border(
          bottom: BorderSide(
            color: MyColors.scarlet,
            width: MyScreen.getScreenHeight(context) * (4 / 1063.6),
          ),
        ),
        title: Text("Add Item",
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
                          initialValue: "15151515",
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
                              return "Enter Proper HSN Code";
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
                              return "Enter Proper Barcode";
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
                        addItem();
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
