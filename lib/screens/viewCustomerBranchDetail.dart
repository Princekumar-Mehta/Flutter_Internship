import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/Models/customer_branch.dart';

import 'editCustomerBranch.dart';

class ViewCustomerBranchDetail extends StatefulWidget {
  CustomerBranch? customerBranch;
  ViewCustomerBranchDetail({this.customerBranch});
  @override
  _ViewCustomerBranchDetailState createState() =>
      _ViewCustomerBranchDetailState();
}

class _ViewCustomerBranchDetailState extends State<ViewCustomerBranchDetail> {
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
        title: Text("View Customer Branch",
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
              Column(
                children: [
                  SizedBox(
                      height: MyScreen.getScreenHeight(context) * (6 / 553)),
                  SizedBox(
                    width: MyScreen.getScreenWidth(context) * (228 / 294),
                    height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                    child: Text("Customer *",
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
                      name: 'customer',
                      enabled: false,
                      initialValue: widget.customerBranch!.code!,
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
                    ),
                  ),
                  // Spacing to be kept between Field Name & Field Input
                  SizedBox(
                      height: MyScreen.getScreenHeight(context) * (6 / 553)),
                  SizedBox(
                    width: MyScreen.getScreenWidth(context) * (228 / 294),
                    height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                    child: Text("Branch Type *",
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
                      name: 'branch_Type',
                      enabled: false,
                      initialValue: widget.customerBranch!.branch_Type!,
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
                    ),
                  ),
                  SizedBox(
                      height: MyScreen.getScreenHeight(context) * (6 / 553)),
                  SizedBox(
                    width: MyScreen.getScreenWidth(context) * (228 / 294),
                    height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                    child: Text("Branch Name *",
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
                      name: 'branch_Name',
                      enabled: false,
                      initialValue: widget.customerBranch!.branch_Name!,
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
                    ),
                  ),
                  SizedBox(
                      height: MyScreen.getScreenHeight(context) * (6 / 553)),
                  SizedBox(
                    width: MyScreen.getScreenWidth(context) * (228 / 294),
                    height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                    child: Text("Address 1 *",
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
                      name: 'address1',
                      enabled: false,
                      initialValue: widget.customerBranch!.address1!,
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
                    ),
                  ),
                  SizedBox(
                      height: MyScreen.getScreenHeight(context) * (6 / 553)),
                  SizedBox(
                    width: MyScreen.getScreenWidth(context) * (228 / 294),
                    height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                    child: Text("Locality * (Ex: Gota, Chandkheda, Iskcon)",
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
                      name: 'location',
                      enabled: false,
                      initialValue: widget.customerBranch!.location!,
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
                    ),
                  ),
                  SizedBox(
                      height: MyScreen.getScreenHeight(context) * (6 / 553)),
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
                  SizedBox(
                    width: MyScreen.getScreenWidth(context) * (228 / 294),
                    height: MyScreen.getScreenHeight(context) * (50 / 1063.6),
                    child: FormBuilderTextField(
                      name: 'city',
                      enabled: false,
                      initialValue: widget.customerBranch!.city!,
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
                    ),
                  ),
                  SizedBox(
                      height: MyScreen.getScreenHeight(context) * (6 / 553)),
                  SizedBox(
                    width: MyScreen.getScreenWidth(context) * (228 / 294),
                    height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                    child: Text("State *",
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
                      name: 'state',
                      enabled: false,
                      initialValue: widget.customerBranch!.state!,
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
                    ),
                  ),

                  SizedBox(
                      height: MyScreen.getScreenHeight(context) * (6 / 553)),
                  SizedBox(
                    width: MyScreen.getScreenWidth(context) * (228 / 294),
                    height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                    child: Text("Country *",
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
                      name: 'country',
                      enabled: false,
                      initialValue: widget.customerBranch!.country!,
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
                    ),
                  ),
                  SizedBox(
                      height: MyScreen.getScreenHeight(context) * (6 / 553)),
                  SizedBox(
                    width: MyScreen.getScreenWidth(context) * (228 / 294),
                    height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                    child: Text("Post Code *",
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
                      name: 'post_Code',
                      enabled: false,
                      initialValue:
                          widget.customerBranch!.post_Code!.toString(),
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
                    ),
                  ),
                  SizedBox(
                      height: MyScreen.getScreenHeight(context) * (6 / 553)),
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
                  SizedBox(
                    width: MyScreen.getScreenWidth(context) * (228 / 294),
                    height: MyScreen.getScreenHeight(context) * (50 / 1063.6),
                    child: FormBuilderTextField(
                      name: 'sub_Area',
                      enabled: false,
                      initialValue: widget.customerBranch!.sub_Area!,
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
                    ),
                  ),
                  SizedBox(
                      height: MyScreen.getScreenHeight(context) * (6 / 553)),
                  SizedBox(
                    width: MyScreen.getScreenWidth(context) * (228 / 294),
                    height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                    child: Text("Area *",
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
                      name: 'area',
                      enabled: false,
                      initialValue: widget.customerBranch!.area,
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
                    ),
                  ),
                  SizedBox(
                      height: MyScreen.getScreenHeight(context) * (6 / 553)),
                  SizedBox(
                    width: MyScreen.getScreenWidth(context) * (228 / 294),
                    height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                    child: Text("Contact Person Name *",
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
                      name: 'contact_Person',
                      enabled: false,
                      initialValue: widget.customerBranch!.contact_Person!,
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
                    ),
                  ),
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
                      height: MyScreen.getScreenHeight(context) * (6 / 553)),
                  SizedBox(
                    width: MyScreen.getScreenWidth(context) * (228 / 294),
                    height: MyScreen.getScreenHeight(context) * (50 / 1063.6),
                    child: FormBuilderTextField(
                      name: 'branch_Email',
                      enabled: false,
                      initialValue: widget.customerBranch!.branch_Email!,
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
                    ),
                  ),
                  SizedBox(
                      height: MyScreen.getScreenHeight(context) * (6 / 553)),
                  SizedBox(
                    width: MyScreen.getScreenWidth(context) * (228 / 294),
                    height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                    child: Text("Phone *",
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
                      name: 'branch_Phone',
                      enabled: false,
                      initialValue: widget.customerBranch!.branch_Phone!,
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
                    ),
                  ),
                  SizedBox(
                      height: MyScreen.getScreenHeight(context) * (6 / 553)),
                  SizedBox(
                    width: MyScreen.getScreenWidth(context) * (228 / 294),
                    height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                    child: Text("GST Number *",
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
                      name: 'gstin',
                      enabled: false,
                      initialValue: widget.customerBranch!.gstin!,
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
                    ),
                  ),
                  SizedBox(
                      height: MyScreen.getScreenHeight(context) * (6 / 553)),
                  SizedBox(
                    width: MyScreen.getScreenWidth(context) * (228 / 294),
                    height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                    child: Text("Composite Scheme",
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
                      name: 'composite_Scheme',
                      enabled: false,
                      initialValue: widget.customerBranch!.composite_Scheme!,
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
                    ),
                  ),
                  SizedBox(
                      height: MyScreen.getScreenHeight(context) * (6 / 553)),
                  SizedBox(
                    width: MyScreen.getScreenWidth(context) * (228 / 294),
                    height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                    child: Text("Composite Scheme",
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
                      name: 'active',
                      enabled: false,
                      initialValue: widget.customerBranch!.active!,
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
                    ),
                  ),
                  SizedBox(
                    width: MyScreen.getScreenWidth(context) * (228 / 294),
                    height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                    child: Text("isDeault",
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
                      name: 'isDefault',
                      enabled: false,
                      initialValue: widget.customerBranch!.isDefault!,
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
                            child: Text("Edit Branch",
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
                                builder: (context) => EditCustomerBranch(
                                      customerBranch: widget.customerBranch,
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
