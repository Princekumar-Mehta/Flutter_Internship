import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:project_v3/Database/db_Customer.dart';
import 'package:project_v3/Database/db_Customer_branch.dart';
import 'package:project_v3/Database/order.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myItemContainer.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/myTypeAhead.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/Extras/pdf_api.dart';
import 'package:project_v3/Extras/utility.dart';

import 'confirmSalesOrder.dart';

class SalesOrderScreen extends StatefulWidget {
  const SalesOrderScreen({Key? key}) : super(key: key);

  @override
  _SalesOrderScreenState createState() => _SalesOrderScreenState();
}

class _SalesOrderScreenState extends State<SalesOrderScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  DateTime? _dateTime;
  final df = DateFormat('dd-MM-yyyy');

  String phone_number = "+91 XXXXX XXXXX";
  String email = "example@example.com";
  late MyTypeAhead customer;
  late MyTypeAhead billing_address;
  late MyTypeAhead shipping_address;
  late MyTypeAhead manufacturing_branch;
  MyItemContainer? getOrders;
  late Order order;
  Future<void> placeOrder(BuildContext context) async {
    if ((!customer.isEmpty() &&
        !billing_address.isEmpty() &&
        !shipping_address.isEmpty() &&
        !manufacturing_branch.isEmpty())) {
      order = getOrders!.getOrder();
      order.customer = (await Database_customer()
          .get_customer(customer.getValue().toString()));
      if (order.customer.code == "DSTXXXX") {
        Utility.showMessage(context,
            "Customer Code is invalid. Please choose from the given dropdown.");
      } else {
        order.billing_branch = await Database_customerBranch()
            .get_customerBranch(
                (billing_address.getValue().toString()).substring(0, 5));
        if (order.billing_branch.branch_Code == "BXXXX") {
          Utility.showMessage(context,
              "Billing Address is invalid. Please choose from the given dropdown.");
        } else {
          order.shipping_branch = await Database_customerBranch()
              .get_customerBranch(
                  shipping_address.getValue().toString().substring(0, 5));
          if (order.shipping_branch.branch_Code == "BXXXX") {
            Utility.showMessage(context,
                "Shipping Address is invalid. Please choose from the given dropdown.");
          } else {
            if (order.shipping_branch.code == order.billing_branch.code) {
              if (order.billing_branch.code == customer.getValue()) {
                if (phone_number == order.billing_branch.branch_Phone &&
                    email == order.billing_branch.branch_Email) {
                  print(order.billing_branch.branch_Phone);
                  print(order.billing_branch.branch_Email);
                  print("Successful");
                  order.manufacturing_Branch = manufacturing_branch.getValue();
                  _formKey.currentState!.save();
                  order.OrderBydate =
                      _formKey.currentState!.value['order_date'];
                  order.salesPerson = MyDrawer.emp;
                  final file = await PdfApi.generatePDF(order: order);
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ConfirmOrder(order: order, file: file)));
                  Navigator.pop(context);
                } else {
                  Utility.showMessage(context,
                      "Mobile Number and Email ID have not been updated.\n\nPlease refresh the page and try again.");
                }
              } else {
                Utility.showMessage(context,
                    "Shipping Address and Billing Address do not match with available Customer Branches.\n\nPlease choose from the given dropdown.");
              }
            } else {
              Utility.showMessage(context,
                  "Shipping Address and Billing Address are not of the same Customer.\n\nPlease choose from the given dropdown.");
            }
          }
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getOrders = MyItemContainer();

    //  print("inti state called");
  }

  void fetch_contact() async {
    Map<String, String> branch_contact = await Database_customerBranch()
        .get_customerBranchContact(billing_address.getValue().toString());
    if (phone_number != branch_contact['phone']! ||
        email != branch_contact['email']!) {
      phone_number = branch_contact['phone']!;
      email = branch_contact['email']!;
    }
  }

  bool? isCustomerId = false;
  @override
  Widget build(BuildContext context) {
    //  print("hello");
    try {
      if (customer.getValue().toString().length == 7) {
        isCustomerId = true;
        var _customerBranches = Database_customerBranch();
        _customerBranches.get_customerBranches(customer.getValue().toString());
      } else {
        isCustomerId = false;
        billing_address.setValue("");
        shipping_address.setValue("");
      }
      if (Database_customerBranch.bill_branch_codes
          .contains(billing_address.getValue().toString())) {
        fetch_contact();
      }
    } catch (e) {}
    customer = MyTypeAhead(
      itemList: Database_customer.codes,
      message: "Please Enter Customer ID",
      isEnabled: true,
    );
    billing_address = MyTypeAhead(
      itemList: Database_customerBranch.bill_branch_codes,
      message: "Please Enter Billing Address",
      isEnabled: isCustomerId!,
    );
    shipping_address = MyTypeAhead(
      itemList: Database_customerBranch.ship_branch_codes,
      message: "Please Enter Shipping Address",
      isEnabled: isCustomerId!,
    );
    manufacturing_branch = manufacturing_branch = MyTypeAhead(
      itemList: [],
      message: "Please Enter Manufacturing Branch",
      isEnabled: true,
    );
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          shape: Border(
            bottom: BorderSide(
              color: MyColors.scarlet,
              width: MyScreen.getScreenHeight(context) * (4 / 1063.6),
            ),
          ),
          title: Text("Place Sales Order",
              style: TextStyle(
                  color: MyColors.scarlet,
                  fontSize: MyScreen.getScreenHeight(context) * (20 / 1063.6))),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: MyColors.scarlet,
                size: MyScreen.getScreenHeight(context) * (30 / 1063.6)),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert,
                  color: MyColors.scarlet,
                  size: MyScreen.getScreenHeight(context) * (30 / 1063.6)),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            IconButton(
              icon: Icon(Icons.refresh,
                  color: MyColors.scarlet,
                  size: MyScreen.getScreenHeight(context) * (30 / 1063.6)),
              onPressed: () {
                setState(() {});
              },
            ),
          ],
          backgroundColor: MyColors.richBlackFogra,
        ),
        backgroundColor: MyColors.richBlackFogra,
        body: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                // Date Container
                Container(
                  height: 35,
                  padding: EdgeInsets.fromLTRB(
                      MyScreen.getScreenWidth(context) * (310 / 490.9),
                      0,
                      0,
                      0),
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      Text(
                        "Date: ",
                        style: TextStyle(
                            color: MyColors.pewterBlue,
                            fontSize: MyScreen.getScreenHeight(context) *
                                (20 / 1063.6)),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height:
                            MyScreen.getScreenHeight(context) * (32 / 1063.6),
                        width: MyScreen.getScreenWidth(context) * (63 / 294),
                        child: FormBuilderTextField(
                          name: 'order_date',
                          enabled: false,
                          readOnly: true,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: MyColors.richBlackFogra)),
                          ),
                          initialValue: (df.format(new DateTime.now())),
                          style: TextStyle(
                              color: MyColors.pewterBlue,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (20 / 1063.6)),
                        ),
                      ),
                    ],
                  ),
                ),
                // Form
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      MyScreen.getScreenWidth(context) * (40 / 490.9),
                      0,
                      MyScreen.getScreenWidth(context) * (40 / 490.9),
                      0),
                  child: Column(
                    children: [
                      SizedBox(
                          height:
                              MyScreen.getScreenHeight(context) * (6 / 553)),
                      // Customer Input
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (30 / 1063.6),
                        child: Text("Customer *",
                            style: TextStyle(
                                color: MyColors.pewterBlue,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6))),
                      ),
                      customer,
                      // Spacing to be kept between Field Name & Field Input
                      SizedBox(
                          height:
                              MyScreen.getScreenHeight(context) * (6 / 553)),
                      // Billing Address Input
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (30 / 1063.6),
                        child: Text("Billing Address *",
                            style: TextStyle(
                                color: MyColors.pewterBlue,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6))),
                      ),
                      billing_address,

                      // Spacing to be kept between Field Name & Field Input
                      SizedBox(
                          height:
                              MyScreen.getScreenHeight(context) * (6 / 553)),
                      // Shipping Address Input
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (30 / 1063.6),
                        child: Text("Shipping Address *",
                            style: TextStyle(
                                color: MyColors.pewterBlue,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6))),
                      ),
                      shipping_address,
                      // Spacing to be kept between Field Name & Field Input
                      SizedBox(
                          height:
                              MyScreen.getScreenHeight(context) * (6 / 553)),
                      // Phone Number (Load by default)
                      // Inside Container needs to be auto filled, and width still
                      // needs to be made dynamic.
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (30 / 1063.6),
                        child: Text("Phone: $phone_number",
                            style: TextStyle(
                                color: MyColors.pewterBlue,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (17 / 1063.6))),
                      ),
                      // Spacing to be kept between Field Name & Field Input
                      SizedBox(
                          height:
                              MyScreen.getScreenHeight(context) * (6 / 553)),
                      // Email ID (Load by default)
                      // Inside Container needs to be auto filled, and width still
                      // needs to be made dynamic.
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (30 / 1063.6),
                        child: Row(children: [
                          Text("Email: $email",
                              style: TextStyle(
                                  color: MyColors.pewterBlue,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (17 / 1063.6))),
                        ]),
                      ),
                      // Spacing to be kept between Field Name & Field Input
                      SizedBox(
                          height:
                              MyScreen.getScreenHeight(context) * (6 / 553)),
                      // Manufacturing Branch Input
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (30 / 1063.6),
                        child: Text("Manufacturing Branch *",
                            style: TextStyle(
                                color: MyColors.pewterBlue,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6))),
                      ),
                      manufacturing_branch,
                      // Spacing to be kept between Field Name & Field Input
                      SizedBox(
                          height:
                              MyScreen.getScreenHeight(context) * (6 / 553)),
                      // Order Required By Input
                      // Check if calendar icon is having any on pressed action
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (30 / 1063.6),
                        child: Text("Order Required By *",
                            style: TextStyle(
                                color: MyColors.pewterBlue,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6))),
                      ),
                      SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (50 / 1063.6),
                        child: FormBuilderDateTimePicker(
                          inputType: InputType.date,
                          format: DateFormat('dd-MM-yyyy'),
                          firstDate: DateTime.now(),
                          name: 'date',
                          style: TextStyle(
                              color: MyColors.pewterBlue,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (25 / 1063.6)),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: MyColors.pewterBlue)),
                            suffixIcon: Icon(Icons.calendar_today,
                                color: MyColors.pewterBlue,
                                size: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6)),
                            fillColor: MyColors.grullo,
                          ),
                          initialValue: DateTime.now(),
                        ),
                      ),
                      // Item List & Add Item
                      getOrders!,
                      // Item Input Container
                    ],
                  ),
                ),

                // Spacing between Sign order button and form
                SizedBox(
                    height: MyScreen.getScreenHeight(context) * (20 / 1063.6)),
                // Sign Order Button
                SizedBox(
                  width: MyScreen.getScreenWidth(context) * (85 / 294),
                  height: MyScreen.getScreenHeight(context) * (60 / 1063.6),
                  child: InkWell(
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                MyScreen.getScreenHeight(context) *
                                    (10 / 1063.6)),
                            color: MyColors.middleRed,
                          ),
                        ),
                        Center(
                          child: Text("Sign Order",
                              style: TextStyle(
                                  color: MyColors.richBlackFogra,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (17 / 1063.6),
                                  fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                    onTap: () => placeOrder(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
