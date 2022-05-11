import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project_v3/Database/db_customer.dart';
import 'package:project_v3/Database/db_customer_branch.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/myTypeAhead.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/Extras/utility.dart';
import 'package:project_v3/Models/customer.dart';
import 'package:project_v3/Models/region_salesperson.dart';

class AddCustomerBranch extends StatefulWidget {
  Region_Salesperson? region_salesperson;
  AddCustomerBranch({this.region_salesperson});
  @override
  _AddCustomerBranchState createState() => _AddCustomerBranchState();
}

class _AddCustomerBranchState extends State<AddCustomerBranch> {
  late MyTypeAhead customer;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  initState() {}
  AddCustomerBranch() async {
    Position position = await _determinePosition();
    String latitude = position.latitude.toStringAsFixed(6);
    String longitude = position.longitude.toStringAsFixed(6);

    if (_formKey.currentState!.validate()) {
      if (!customer.isEmpty()) {
        Customer customer1 = (await Database_customer()
            .get_customer(customer.getValue().toString()));
        if (customer1.code == "DSTXXXX") {
          Utility.showMessage(context,
              "Customer Code is invalid. Please choose from the given dropdown.");
        } else {
          _formKey.currentState!.save();
          String code = (customer1.code.toString());
          if (_formKey.currentState!.value['branch_Type'] == null) {
            Utility.showMessage(context, "Please Select Branch Type");
            return;
          }
          String branch_Type =
              (_formKey.currentState?.value['branch_Type'].toString())!;
          String branch_Name =
              (_formKey.currentState?.value['branch_Name'].toString())!;
          String address1 =
              (_formKey.currentState?.value['address1'].toString())!;
          String address2 = "";
          String location =
              (_formKey.currentState?.value['location'].toString())!;
          /* String city = (_formKey.currentState?.value['city'].toString())!;
          String state = (_formKey.currentState?.value['state'].toString())!;*/
          /*String country =
              (_formKey.currentState?.value['country'].toString())!;*/
          int post_Code = int.parse(
              (_formKey.currentState?.value['post_Code'].toString())!);
          /* String sub_Area =
              (_formKey.currentState?.value['sub_Area'].toString())!;
          String area = (_formKey.currentState?.value['area'].toString())!;*/
          String contact_Person =
              _formKey.currentState?.value['contact_Person'];
          String branch_Email = _formKey.currentState?.value['branch_Email'];
          String branch_Phone = _formKey.currentState?.value['branch_Phone'];
          String gstin = _formKey.currentState?.value['gstin'];
          String? pan =
              _formKey.currentState?.value['gstin'].toString().substring(2, 12);
          print(pan);
          String composite_Scheme = checkedValue.toString();
          String isDefault = checkedValue2.toString();
          String active = checkedValue3.toString();

          /*if (sub_Area == 'Central') sub_Area = area + "-CL";
          if (sub_Area == 'North - West') sub_Area = area + "-NW";
          if (sub_Area == 'North - East') sub_Area = area + "-NE";
          if (sub_Area == 'South - West') sub_Area = area + "-SW";*/
          Map<String, dynamic> customerBranch = {
            "code": code,
            "branch_Code": "",
            "branch_Type": branch_Type,
            "branch_Name": branch_Name,
            "address1": address1,
            "address2": address2,
            "location": location,
            "latitude": latitude,
            "longitude": longitude,
            "city": widget.region_salesperson!.sub_Area!.split("-")[0],
            "state": widget.region_salesperson!.area,
            "country": "India",
            "post_Code": post_Code,
            "sub_Area": widget.region_salesperson!.sub_Area!,
            "area": widget.region_salesperson!.area,
            "contact_Person": contact_Person,
            "branch_Email": branch_Email,
            "branch_Phone": branch_Phone,
            "gstin": gstin,
            "pan": pan,
            "composite_Scheme": composite_Scheme,
            "isDefault": isDefault,
            "active": active
          };
          print(customerBranch);
          bool isAdded =
              await Database_customerBranch.addCustomerBranch(customerBranch);
          showMessage(
              context,
              isAdded
                  ? "Customer Branch Added"
                  : "Customer Branch Already Exist",
              isAdded);
        }
      }
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

  var checkedValue = false;
  var checkedValue2 = false;
  var checkedValue3 = false;
  @override
  Widget build(BuildContext context) {
    customer = MyTypeAhead(
      itemList: Database_customer.codesBySubArea,
      message: "Please Enter Customer ID",
      isEnabled: true,
    );
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
        title: Text("Add Customer Branch",
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
                    customer,
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
                          name: 'branch_Type',
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
                            'Bill To',
                            'Ship To',
                            'Bill To / Ship To',
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
                              return "Please Enter Branch Name";
                            }
                            return null;
                          }),
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
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          name: 'address1',
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
                              return "Please Enter Address";
                            }
                            return null;
                          }),
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
                              return "Please Enter Locality";
                            }
                            return null;
                          }),
                    ),
                    SizedBox(
                        height: MyScreen.getScreenHeight(context) * (6 / 553)),
                    /*  SizedBox(
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
                              return "Please Enter City";
                            }
                            return null;
                          }),
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
                              return "Please Enter State";
                            }
                            return null;
                          }),
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
                              return "Please Enter Country";
                            }
                            return null;
                          }),
                    ),
                    SizedBox(
                        height: MyScreen.getScreenHeight(context) * (6 / 553)),*/
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
                            RegExp regexpost = RegExp(r'^[0-9]{6}$');
                            if (value == null || value.isEmpty) {
                              return "Please Enter Post Code";
                            } else if (!regexpost.hasMatch(value)) {
                              return "Enter Valid Post Code (Ex: 123456)";
                            }
                            return null;
                          }),
                    ),
                    /*    SizedBox(
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
                          name: 'area',
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
                    ]),*/
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
                              return "Please Enter Branch Name";
                            }
                            return null;
                          }),
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
                            RegExp regexmob = RegExp(r'^[0-9]{10}$');
                            if (value == null || value.isEmpty) {
                              return "Please Enter Phone Number 1";
                            } else if (!regexmob.hasMatch(value)) {
                              return "Enter Valid Phone Number 1 (Ex: 1234567890)";
                            }
                            return null;
                          }),
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
                            RegExp regexem = RegExp(r'^[A-Z0-9]{15}$');
                            if (value == null || value.isEmpty) {
                              return "Please Enter GST Number";
                            } else if (!regexem.hasMatch(value)) {
                              return "Enter Valid GST Number (Ex: 22AAAAA0000A1Z5)";
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
                              'Composite Scheme (Select if applicable under Composite Scheme)',
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
                              'Default Branch (Select if you want to set this branch as Default Branch)',
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
                          title: Text('Active (Select if Branch is Active)',
                              style: TextStyle(
                                  color: MyDrawer.emp.darkTheme == 1
                                      ? MyColors.pewterBlue
                                      : MyColors.black,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (20 / 1063.6))),
                          value: checkedValue3,
                          onChanged: (value) {
                            setState(() {
                              checkedValue3 = !checkedValue3;
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
                        AddCustomerBranch();
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
                              child: Text("Save Branch",
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

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location Service are disabled");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location Permission are permanently denied");
    }
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }
}
