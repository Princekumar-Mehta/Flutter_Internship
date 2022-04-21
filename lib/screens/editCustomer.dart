import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:project_v3/Database/db_customer.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/Extras/utility.dart';
import 'package:project_v3/Models/customer.dart';

import '../Extras/routes.dart';

class EditCustomer extends StatefulWidget {
  Customer customer;
  EditCustomer({required this.customer});

  @override
  _EditCustomerState createState() => _EditCustomerState();
}

class _EditCustomerState extends State<EditCustomer> {
  final _formKey = GlobalKey<FormBuilderState>();
  var checkedValue;
  String sub_Area = "";
  String city = "";
  @override
  initState() {
    city = widget.customer.sub_Area!.split("-")[0];
    sub_Area = widget.customer.sub_Area!.split("-")[1];
    if (sub_Area == "CL")
      sub_Area = "Central";
    else if (sub_Area == "NW")
      sub_Area = "North - West";
    else if (sub_Area == "SW")
      sub_Area = "South - West";
    else if (sub_Area == "NE") sub_Area = "North - East";

    checkedValue = widget.customer.active == "true" ? true : false;
  }

  EditCustomer() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String party_Name =
          (_formKey.currentState?.value['party_Name'].toString())!;
      String nick_Name =
          (_formKey.currentState?.value['nick_Name'].toString())!;
      String doc_Type = (_formKey.currentState?.value['doc_Type'].toString())!;
      String grp = (_formKey.currentState?.value['grp'].toString())!;
      String sub_Group =
          (_formKey.currentState?.value['sub_Group'].toString())!;
      int map_Cn =
          int.parse((_formKey.currentState?.value['map_Cn'].toString())!);
      int branch_Cn =
          int.parse((_formKey.currentState?.value['branch_Cn'].toString())!);
      String email = (_formKey.currentState?.value['email'].toString())!;
      String phone_1 = (_formKey.currentState?.value['phone_1'].toString())!;
      String phone_2 = (_formKey.currentState?.value['phone_2'].toString())!;
      int crd_Day =
          int.parse((_formKey.currentState?.value['crd_Day'].toString())!);
      int crd_Amt =
          int.parse((_formKey.currentState?.value['crd_Amt'].toString())!);
      int gL_Acc =
          int.parse((_formKey.currentState?.value['gL_Acc'].toString())!);
      String active = checkedValue.toString();
      String city = _formKey.currentState?.value['city'];
      String sub_Area = _formKey.currentState?.value['sub_Area'];
      if (sub_Area == 'Central') sub_Area = city + "-CL";
      if (sub_Area == 'North - West') sub_Area = city + "-NW";
      if (sub_Area == 'North - East') sub_Area = city + "-NE";
      if (sub_Area == 'South - West') sub_Area = city + "-SW";
      Map<String, dynamic> customer = {
        "code": widget.customer.code,
        "party_Name": party_Name,
        "nick_Name": nick_Name,
        "doc_Type": doc_Type,
        "grp": grp,
        "sub_Group": sub_Group,
        "map_Cn": map_Cn,
        "branch_Cn": branch_Cn,
        "sub_Area": sub_Area,
        "area": widget.customer.area!,
        "email": email,
        "phone_1": phone_1,
        "phone_2": phone_2,
        "crd_Day": crd_Day,
        "crd_Amt": crd_Amt,
        "gL_Acc": gL_Acc,
        "active": active,
      };
      print(customer);
      if (await Database_customer.updateCustomer(customer)) {
        Utility.showMessage(context, "Customer Updated");
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
       /* if (await Database_customer.getAllCustomers()) {
          Navigator.pushNamed(context, MyRoutes.MyViewCustomerScreen);
        }*/
      }
    }
  }

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
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
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
              if (widget.customer.party_Name !=
                      _formKey.currentState!.value['party_Name'] ||
                  widget.customer.nick_Name !=
                      _formKey.currentState!.value['nick_Name'] ||
                  widget.customer.doc_Type !=
                      _formKey.currentState!.value['doc_Type'] ||
                  widget.customer.grp != _formKey.currentState!.value['grp'] ||
                  widget.customer.sub_Group !=
                      _formKey.currentState!.value['sub_Group'] ||
                  widget.customer.map_Cn.toString() !=
                      _formKey.currentState!.value['map_Cn'].toString() ||
                  widget.customer.branch_Cn.toString() !=
                      _formKey.currentState!.value['branch_Cn'].toString() ||
                  widget.customer.email !=
                      _formKey.currentState!.value['email'] ||
                  widget.customer.phone_1 !=
                      _formKey.currentState!.value['phone_1'].toString() ||
                  widget.customer.phone_2 !=
                      _formKey.currentState!.value['phone_2'].toString() ||
                  widget.customer.crd_Day.toString() !=
                      _formKey.currentState!.value['crd_Day'].toString() ||
                  widget.customer.crd_Amt.toString() !=
                      _formKey.currentState!.value['crd_Amt'].toString() ||
                  widget.customer.gL_Acc.toString() !=
                      _formKey.currentState!.value['gL_Acc'].toString() ||
                  widget.customer.active !=
                      _formKey.currentState!.value['active'].toString()) {
                confirmationDialog(context,
                    "Exit to Home Page?\n\nChanges will not be saved.");
              } else {
                Navigator.pop(context);
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
        title: Text("Edit Customer",
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
      drawer: MyDrawer(),
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
                        height: MyScreen.getScreenHeight(context) * (6 / 553)),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                      child: Text("Party Name *",
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
                          name: 'party_Name',
                          initialValue: widget.customer.party_Name,
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
                              return "Please Enter Party Name";
                            }
                            return null;
                          }),
                    ),
                    SizedBox(
                        height: MyScreen.getScreenHeight(context) * (6 / 553)),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                      child: Text("Nick Name *",
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
                          name: 'nick_Name',
                          initialValue: widget.customer.nick_Name,
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
                              return "Please Enter Nick Name";
                            }
                            return null;
                          }),
                    ),
                    SizedBox(
                        height: MyScreen.getScreenHeight(context) * (6 / 553)),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                      child: Text("Doc Type *",
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
                          name: 'doc_Type',
                          initialValue: widget.customer.doc_Type,
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
                              return "Please Enter Doc Type";
                            }
                            return null;
                          }),
                    ),
                    SizedBox(
                        height: MyScreen.getScreenHeight(context) * (6 / 553)),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                      child: Text("Group Name*",
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
                          initialValue: widget.customer.grp,
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
                      child: Text("Sub Group*",
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
                          initialValue: widget.customer.sub_Group,
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
                      child: Text("Map_cn *",
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
                          name: 'map_Cn',
                          initialValue: widget.customer.map_Cn.toString(),
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
                              return "Please Enter Map_cn";
                            }
                            return null;
                          }),
                    ),
                    SizedBox(
                        height: MyScreen.getScreenHeight(context) * (6 / 553)),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                      child: Text("Branch_cn *",
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
                          name: 'branch_Cn',
                          initialValue: widget.customer.branch_Cn.toString(),
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
                              return "Please Enter Branch_cn";
                            }
                            return null;
                          }),
                    ),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                      child: Text("Sub Area *",
                          style: TextStyle(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.pewterBlue
                                  : MyColors.black,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (20 / 1063.6))),
                    ),
                    Stack(children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: MyDrawer.emp.darkTheme == 1
                                ? MyColors.pewterBlue
                                : MyColors.black,
                            width:
                                MyScreen.getScreenWidth(context) * (.75 / 294),
                          ),
                        ),
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height: 54,
                        child: FormBuilderDropdown<String>(
                          name: 'sub_Area',
                          initialValue: sub_Area,
                          dropdownColor: MyDrawer.emp.darkTheme == 1
                              ? MyColors.richBlackFogra
                              : MyColors.white,
                          iconSize:
                              MyScreen.getScreenHeight(context) * (35 / 1063.6),
                          isExpanded: true,
                          isDense: true,
                          iconDisabledColor: MyDrawer.emp.darkTheme == 1
                              ? MyColors.pewterBlue
                              : MyColors.black,
                          iconEnabledColor: MyDrawer.emp.darkTheme == 1
                              ? MyColors.pewterBlue
                              : MyColors.black,
                          icon: const Icon(Icons.arrow_drop_down),
                          style: TextStyle(
                            color: MyDrawer.emp.darkTheme == 1
                                ? MyColors.pewterBlue
                                : MyColors.black,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {});
                          },
                          items: <String>[
                            'Central',
                            'North - West',
                            'North - East',
                            'South - West'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Center(
                                  child: Text(value,
                                      style: TextStyle(
                                          color: MyDrawer.emp.darkTheme == 1
                                              ? MyColors.pewterBlue
                                              : MyColors.black,
                                          fontSize: MyScreen.getScreenHeight(
                                                  context) *
                                              (20 / 1063.6)))),
                            );
                          }).toList(),
                        ),
                      )
                    ]),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                      child: Text("City *",
                          style: TextStyle(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.pewterBlue
                                  : MyColors.black,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (20 / 1063.6))),
                    ),
                    Stack(children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: MyDrawer.emp.darkTheme == 1
                                ? MyColors.pewterBlue
                                : MyColors.black,
                            width:
                                MyScreen.getScreenWidth(context) * (.75 / 294),
                          ),
                        ),
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height: 54,
                        child: FormBuilderDropdown<String>(
                          name: 'city',
                          initialValue: city,
                          dropdownColor: MyDrawer.emp.darkTheme == 1
                              ? MyColors.richBlackFogra
                              : MyColors.white,
                          iconSize:
                              MyScreen.getScreenHeight(context) * (35 / 1063.6),
                          isExpanded: true,
                          isDense: true,
                          iconDisabledColor: MyDrawer.emp.darkTheme == 1
                              ? MyColors.pewterBlue
                              : MyColors.black,
                          iconEnabledColor: MyDrawer.emp.darkTheme == 1
                              ? MyColors.pewterBlue
                              : MyColors.black,
                          icon: const Icon(Icons.arrow_drop_down),
                          style: TextStyle(
                            color: MyDrawer.emp.darkTheme == 1
                                ? MyColors.pewterBlue
                                : MyColors.black,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {});
                          },
                          items: <String>[
                            'Ahmedabad',
                            'Rajkot',
                            'Vadodara',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Center(
                                  child: Text(value,
                                      style: TextStyle(
                                          color: MyDrawer.emp.darkTheme == 1
                                              ? MyColors.pewterBlue
                                              : MyColors.black,
                                          fontSize: MyScreen.getScreenHeight(
                                                  context) *
                                              (20 / 1063.6)))),
                            );
                          }).toList(),
                        ),
                      )
                    ]),
                    SizedBox(
                        height: MyScreen.getScreenHeight(context) * (6 / 553)),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                      child: Text("Email *",
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
                          name: 'email',
                          initialValue: widget.customer.email,
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
                            RegExp regexem = RegExp(
                                r'^[a-z0-9!#$%&"*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&"*+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9][a-zA-Z0-9-]{0,253}\.)*[a-zA-Z0-9][a-zA-Z0-9-]{0,253}\.[a-zA-Z0-9]{2,}$');
                            if (value == null || value.isEmpty) {
                              return "Please Enter Email ID";
                            } else if (!regexem.hasMatch(value)) {
                              return "Enter Proper Email ID";
                            }
                            return null;
                          }),
                    ),
                    SizedBox(
                        height: MyScreen.getScreenHeight(context) * (6 / 553)),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                      child: Text("Phone 1 *",
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
                          name: 'phone_1',
                          initialValue: widget.customer.phone_1,
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
                            RegExp regexem = RegExp(r'^[0-9]{10}$');
                            if (value == null || value.isEmpty) {
                              return "Please Enter Phone Number 1";
                            } else if (!regexem.hasMatch(value)) {
                              return "Enter Valid Phone Number 1";
                            }
                            return null;
                          }),
                    ),
                    SizedBox(
                        height: MyScreen.getScreenHeight(context) * (6 / 553)),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                      child: Text("Phone 2 *",
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
                          name: 'phone_2',
                          initialValue: widget.customer.phone_2,
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
                            RegExp regexem = RegExp(r'^[0-9]{10}$');
                            if (value == null || value.isEmpty) {
                              return "Please Enter Phone Number 2";
                            } else if (!regexem.hasMatch(value)) {
                              return "Enter Valid Phone Number 2";
                            }
                            return null;
                          }),
                    ),
                    SizedBox(
                        height: MyScreen.getScreenHeight(context) * (6 / 553)),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                      child: Text("Credit Day *",
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
                          name: 'crd_Day',
                          initialValue: widget.customer.crd_Day.toString(),
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
                              return "Please Enter Credit Day";
                            }
                            return null;
                          }),
                    ),
                    SizedBox(
                        height: MyScreen.getScreenHeight(context) * (6 / 553)),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                      child: Text("Credit Amount *",
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
                          name: 'crd_Amt',
                          initialValue: widget.customer.crd_Amt.toString(),
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
                              return "Please Enter Credit Amount";
                            }
                            return null;
                          }),
                    ),
                    SizedBox(
                        height: MyScreen.getScreenHeight(context) * (6 / 553)),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                      child: Text("Gl Acc *",
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
                          name: 'gL_Acc',
                          initialValue: widget.customer.gL_Acc.toString(),
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
                            RegExp regexgLAcc = RegExp(r'^[0-9]{6}$');
                            if (value == null || value.isEmpty) {
                              return "Please Enter gL Acc";
                            } else if (!regexgLAcc.hasMatch(value)) {
                              return "Enter Proper gL Acc";
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
                          title: Text('Active (Select if Active Customer)',
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

                    // Button
                    SizedBox(
                        height:
                            MyScreen.getScreenHeight(context) * (60 / 1063.6)),
                    InkWell(
                      onTap: () {
                        EditCustomer();
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
