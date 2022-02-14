import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:project_v3/Database/db_Customer.dart';
import 'package:project_v3/Database/db_Customer_branch.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/myTypeAhead.dart';

class SalesOrderScreen extends StatefulWidget {
  const SalesOrderScreen({Key? key}) : super(key: key);

  @override
  _SalesOrderScreenState createState() => _SalesOrderScreenState();
}

class _SalesOrderScreenState extends State<SalesOrderScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  DateTime? _dateTime;
  final df = DateFormat('dd-MM-yyyy');
  double? _animatedHeight;
  var quantity = [
    '',
    'Qty',
    'Packet',
    '1',
    'Patti',
    '5',
    'Box',
    '10',
    'Total',
    '210'
  ];
  String phone_number = "+91 XXXXX XXXXX";
  String email = "example@example.com";
  late MyTypeAhead customer;
  late MyTypeAhead billing_address;
  late MyTypeAhead shipping_address;
  late MyTypeAhead manufacturing_branch;
  void placeOrder(BuildContext context) {
    if ((!customer.isEmpty() &&
        !billing_address.isEmpty() &&
        !shipping_address.isEmpty() &&
        !manufacturing_branch.isEmpty())) {}
  }

  @override
  void initState() {
    super.initState();
    Database_customer.insertData();
    var _customers = Database_customer();
    _customers.get_customerIds();
    Database_customerBranch.insertData();
  }

  bool? isCustomerId = false;
  @override
  Widget build(BuildContext context) {
    try {
      if (customer.getValue().toString().length == 7) {
        isCustomerId = true;
        var _customerBranches = Database_customerBranch();
        _customerBranches.get_customerBranches(customer.getValue().toString());
      } else {
        isCustomerId = false;
      }

      if (Database_customerBranch.bill_branch_codes
          .contains(billing_address.getValue().toString())) {
        Database_customerBranch.get_customerBranchContact(
            billing_address.getValue().toString());
        phone_number = Database_customerBranch.iphone_number;
        email = Database_customerBranch.iemail;
      }
    } catch (e) {}
    customer = MyTypeAhead(
      itemList: Database_customer.codes,
      message: "Please Enter Customer ID",
      isCustomer: 0,
      isEnabled: true,
    );
    billing_address = MyTypeAhead(
      itemList: Database_customerBranch.bill_branch_codes,
      message: "Please Enter Billing Address",
      isCustomer: 1,
      isEnabled: isCustomerId!,
    );
    shipping_address = MyTypeAhead(
      itemList: Database_customerBranch.ship_branch_codes,
      message: "Please Enter Shipping Address",
      isCustomer: 1,
      isEnabled: isCustomerId!,
    );
    manufacturing_branch = manufacturing_branch = MyTypeAhead(
      itemList: [],
      message: "Please Enter Manufacturing Branch",
      isCustomer: 1,
      isEnabled: true,
    );
    _animatedHeight = MyScreen.getScreenHeight(context) * (185 / 1063.9);
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
            Material(
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    color: MyColors.richBlackFogra,
                    border: Border.all(color: MyColors.richBlackFogra),
                  ),
                  child: Icon(Icons.more_vert,
                      color: MyColors.scarlet,
                      size: MyScreen.getScreenHeight(context) * (30 / 1063.6)),
                ),
                onTap: () {
                  Navigator.pop(context, true);
                },
              ),
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
                    MyScreen.getScreenWidth(context) * (310 / 490.9), 0, 0, 0),
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
                      height: MyScreen.getScreenHeight(context) * (32 / 1063.6),
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
                    MyScreen.getScreenWidth(context) * (15 / 490.9),
                    0,
                    MyScreen.getScreenWidth(context) * (15 / 490.9),
                    0),
                child: Column(
                  children: [
                    // Type Ahead Example
                    // Error here, the item selected from dropdown is not being replaced
                    // on the textfield.
                    // Spacing to be kept between Field Name & Field Input
                    SizedBox(
                        height: MyScreen.getScreenHeight(context) * (6 / 553)),
                    // Customer Input
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                      child: Text("Customer *",
                          style: TextStyle(
                              color: MyColors.pewterBlue,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (20 / 1063.6))),
                    ),
                    customer,
                    // Spacing to be kept between Field Name & Field Input
                    SizedBox(
                        height: MyScreen.getScreenHeight(context) * (6 / 553)),
                    // Billing Address Input
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                      child: Text("Billing Address *",
                          style: TextStyle(
                              color: MyColors.pewterBlue,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (20 / 1063.6))),
                    ),
                    billing_address,

                    // Spacing to be kept between Field Name & Field Input
                    SizedBox(
                        height: MyScreen.getScreenHeight(context) * (6 / 553)),
                    // Shipping Address Input
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                      child: Text("Shipping Address *",
                          style: TextStyle(
                              color: MyColors.pewterBlue,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (20 / 1063.6))),
                    ),
                    shipping_address,
                    // Spacing to be kept between Field Name & Field Input
                    SizedBox(
                        height: MyScreen.getScreenHeight(context) * (6 / 553)),
                    // Phone Number (Load by default)
                    // Inside Container needs to be auto filled, and width still
                    // needs to be made dynamic.
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                      child: Text("Phone: $phone_number",
                          style: TextStyle(
                              color: MyColors.pewterBlue,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (17 / 1063.6))),
                    ),
                    // Spacing to be kept between Field Name & Field Input
                    SizedBox(
                        height: MyScreen.getScreenHeight(context) * (6 / 553)),
                    // Email ID (Load by default)
                    // Inside Container needs to be auto filled, and width still
                    // needs to be made dynamic.
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
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
                        height: MyScreen.getScreenHeight(context) * (6 / 553)),
                    // Manufacturing Branch Input
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                      child: Text("Manufacturing Branch *",
                          style: TextStyle(
                              color: MyColors.pewterBlue,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (20 / 1063.6))),
                    ),
                    manufacturing_branch,
                    // Spacing to be kept between Field Name & Field Input
                    SizedBox(
                        height: MyScreen.getScreenHeight(context) * (6 / 553)),
                    // Order Required By Input
                    // Check if calendar icon is having any on pressed action
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
                      child: Text("Order Required By *",
                          style: TextStyle(
                              color: MyColors.pewterBlue,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (20 / 1063.6))),
                    ),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (228 / 294),
                      height: MyScreen.getScreenHeight(context) * (50 / 1063.6),
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
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          MyScreen.getScreenWidth(context) * (15 / 490.9),
                          MyScreen.getScreenHeight(context) * (15 / 1063.6),
                          MyScreen.getScreenWidth(context) * (15 / 490.9),
                          0),
                      child: SizedBox(
                        width: MyScreen.getScreenWidth(context) * (228 / 294),
                        height:
                            MyScreen.getScreenHeight(context) * (30 / 1063.6),
                        child: Stack(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text("Item List",
                                  style: TextStyle(
                                      color: MyColors.pewterBlue,
                                      fontSize:
                                          MyScreen.getScreenHeight(context) *
                                              (17 / 1063.6))),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text("Add Item +",
                                  style: TextStyle(
                                      color: MyColors.pewterBlue,
                                      fontSize:
                                          MyScreen.getScreenHeight(context) *
                                              (17 / 1063.6))),
                            )
                          ],
                        ),
                      ),
                    ),
                    // Item Input Container
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          MyScreen.getScreenWidth(context) * (15 / 490.9),
                          MyScreen.getScreenHeight(context) * (15 / 1063.6),
                          MyScreen.getScreenWidth(context) * (15 / 490.9),
                          0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: MyColors.pewterBlue),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width:
                                MyScreen.getScreenWidth(context) * (228 / 294),
                            child: Padding(
                              padding: EdgeInsets.all(
                                  MyScreen.getScreenHeight(context) *
                                      (5 / 1063.6)),
                              child: Column(children: [
                                // Sr No + Item name + Dropdown Arrow
                                Stack(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text("1",
                                          style: TextStyle(
                                              color: MyColors.pewterBlue,
                                              fontSize:
                                                  MyScreen.getScreenHeight(
                                                          context) *
                                                      (20 / 1063.6))),
                                    ),
                                    // Replace with form input field
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 200,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: MyColors.pewterBlue),
                                            ),
                                          ),
                                          child: Text(
                                              "Item: Balaji Masala Wafers",
                                              style: TextStyle(
                                                  color: MyColors.pewterBlue)),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      child: Container(
                                        height:
                                            MyScreen.getScreenHeight(context) *
                                                (40 / 1063.6),
                                        alignment: Alignment.topRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _animatedHeight != 0.0
                                                  ? _animatedHeight = 0.0
                                                  : _animatedHeight =
                                                      MyScreen.getScreenHeight(
                                                              context) *
                                                          (185 / 1063.6);
                                            });
                                          },
                                          child: Icon(Icons.keyboard_arrow_down,
                                              color: MyColors.pewterBlue,
                                              size: MyScreen.getScreenHeight(
                                                      context) *
                                                  (27 / 1063.6)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 120),
                                  height: _animatedHeight,
                                  child: Stack(
                                    children: [
                                      // Price & Unit
                                      Row(
                                        children: [
                                          // Spacing to be kept between Field Name & Field Input
                                          SizedBox(
                                              height: MyScreen.getScreenHeight(
                                                      context) *
                                                  (25 / 1063.6)),
                                          SizedBox(
                                              width: MyScreen.getScreenWidth(
                                                      context) *
                                                  (70 / 490.9)),
                                          Text("Price: \$ XX.XX",
                                              style: TextStyle(
                                                  color: MyColors.pewterBlue,
                                                  fontSize:
                                                      MyScreen.getScreenHeight(
                                                              context) *
                                                          (15 / 1063.6))),
                                          SizedBox(
                                              width: MyScreen.getScreenWidth(
                                                      context) *
                                                  (50 / 490.9)),
                                          Text("Unit: Packet",
                                              style: TextStyle(
                                                  color: MyColors.pewterBlue,
                                                  fontSize:
                                                      MyScreen.getScreenHeight(
                                                              context) *
                                                          (15 / 1063.6))),
                                        ],
                                      ),
                                      Positioned(
                                        top: MyScreen.getScreenHeight(context) *
                                            (30 / 1063.6),
                                        left: MyScreen.getScreenWidth(context) *
                                            (50 / 490.9),
                                        child: Container(
                                          constraints: BoxConstraints(
                                            maxHeight: MyScreen.getScreenHeight(
                                                    context) *
                                                (165 / 1063.6),
                                            maxWidth: MyScreen.getScreenWidth(
                                                    context) *
                                                (100 / 490.9),
                                          ),
                                          color: MyColors.richBlackFogra,
                                          child: GridView.count(
                                            padding: const EdgeInsets.all(0),
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 4,
                                            mainAxisSpacing: 8,
                                            childAspectRatio: 2,
                                            children: List.generate(
                                                quantity.length, (index) {
                                              return Text(quantity[index],
                                                  style: TextStyle(
                                                      color:
                                                          MyColors.pewterBlue,
                                                      fontSize: MyScreen
                                                              .getScreenHeight(
                                                                  context) *
                                                          (15 / 1063.6)));
                                            }),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
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
        )),
      ),
    );
  }
}
