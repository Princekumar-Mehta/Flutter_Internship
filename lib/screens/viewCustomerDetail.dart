import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/Models/customer.dart';

import 'editCustomer.dart';

class ViewCustomerDetail extends StatefulWidget {
  Customer customer;
  ViewCustomerDetail({required this.customer});

  @override
  _ViewCustomerDetailState createState() => _ViewCustomerDetailState();
}

class _ViewCustomerDetailState extends State<ViewCustomerDetail> {
  var checkedValue;
  @override
  void initState() {
    //implement initState
    checkedValue = widget.customer.active == "true" ? true : false;
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
            Navigator.pop(context);
          },
        ),
        shape: Border(
          bottom: BorderSide(
            color: MyColors.scarlet,
            width: MyScreen.getScreenHeight(context) * (4 / 1063.6),
          ),
        ),
        title: Text("View Customer",
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
              Column(
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
                        enabled: false,
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
                        enabled: false,
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
                        enabled: false,
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
                        enabled: false,
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
                        enabled: false,
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
                        enabled: false,
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
                        enabled: false,
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
                        enabled: false,
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
                    child: Text("Phone_1 *",
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
                        enabled: false,
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
                        enabled: false,
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
                        enabled: false,
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
                        enabled: false,
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
                        enabled: false,
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
                            checkedValue = checkedValue;
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
                  SizedBox(
                    width: MyScreen.getScreenWidth(context) * (85 / 294),
                    height: MyScreen.getScreenHeight(context) * (60 / 1063.6),
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
                                color: MyDrawer.emp.darkTheme == 1
                                    ? MyColors.middleRed
                                    : MyColors.scarlet,
                              ),
                            ),
                          ),
                          Center(
                            child: Text("Edit Customer",
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
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditCustomer(
                                      customer: widget.customer,
                                    )));
                      },
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
