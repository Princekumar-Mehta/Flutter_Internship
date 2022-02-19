import 'package:flutter/material.dart';
import 'package:project_v3/Database/db_item.dart';
import 'package:project_v3/Database/order.dart';

import 'myColors.dart';
import 'myScreen.dart';
import 'myTypeAhead.dart';

class MyItemContainer extends StatefulWidget {
  Order? order = Order();
  @override
  _MyItemContainerState createState() => _MyItemContainerState();

  Order getOrder() {
    return order!;
  }
}

class _MyItemContainerState extends State<MyItemContainer> {
  double? _animatedHeight;
  @override
  void initState() {
    Database_Item.insertData();
    _animatedHeight = -1;
  }

  @override
  Widget build(BuildContext context) {
    _animatedHeight = _animatedHeight == -1
        ? MyScreen.getScreenHeight(context) * (245 / 1063.9)
        : _animatedHeight;
    return Column(children: [
      Padding(
        padding: EdgeInsets.fromLTRB(
            MyScreen.getScreenWidth(context) * (15 / 490.9),
            MyScreen.getScreenHeight(context) * (15 / 1063.6),
            MyScreen.getScreenWidth(context) * (15 / 490.9),
            0),
        child: SizedBox(
          width: MyScreen.getScreenWidth(context) * (228 / 294),
          height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
          child: Stack(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text("Item List",
                    style: TextStyle(
                        color: MyColors.pewterBlue,
                        fontSize:
                            MyScreen.getScreenHeight(context) * (17 / 1063.6))),
              ),
              SizedBox(
                height: MyScreen.getScreenHeight(context) * (32 / 1063.6),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      widget.order!.item_name!.add(MyTypeAhead(
                          itemList: Database_Item.item_names,
                          message: "Please Enter Item Name",
                          isEnabled: true));
                      widget.order!.packet!.add("0");
                      widget.order!.patti!.add("0");
                      widget.order!.box!.add("0");
                      widget.order!.counter = widget.order!.counter! + 1;
                      print(widget.order!.counter);
                    });
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text("Add Item +",
                        style: TextStyle(
                            color: MyColors.pewterBlue,
                            fontSize: MyScreen.getScreenHeight(context) *
                                (17 / 1063.6))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      //items
      ListView.builder(
          shrinkWrap: true,
          itemCount: widget.order!.counter,
          itemBuilder: (context, index) {
            return Container(
              child: _row(index),
            );
          }),
    ]);
  }

  _row(int key) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          0, MyScreen.getScreenHeight(context) * (15 / 1063.6), 0, 0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.pewterBlue),
              borderRadius: BorderRadius.circular(
                  MyScreen.getScreenHeight(context) * (10 / 1063.6)),
            ),
            width: MyScreen.getScreenWidth(context) * (228 / 294),
            child: Padding(
              padding: EdgeInsets.all(
                  MyScreen.getScreenHeight(context) * (5 / 1063.6)),
              child: Column(children: [
                // Sr No + Item name + Dropdown Arrow
                SizedBox(
                  height: MyScreen.getScreenHeight(context) * (45 / 1063.6),
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text("${key + 1} Item:",
                            style: TextStyle(
                                color: MyColors.pewterBlue,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6))),
                      ),
                      // Replace with form input field
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            alignment: Alignment.center,
                            width: MyScreen.getScreenWidth(context) *
                                (200 / 490.9),
                            child: widget.order!.item_name![key],
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Container(
                          height:
                              MyScreen.getScreenHeight(context) * (40 / 1063.6),
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _animatedHeight != 0.0
                                    ? _animatedHeight = 0.0
                                    : _animatedHeight =
                                        MyScreen.getScreenHeight(context) *
                                            (245 / 1063.6);
                              });
                            },
                            child: Icon(Icons.keyboard_arrow_down,
                                color: MyColors.pewterBlue,
                                size: MyScreen.getScreenHeight(context) *
                                    (45 / 1063.6)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 0),
                  height: _animatedHeight,
                  child: Stack(
                    children: [
                      // Price & Unit
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Net Weight: " + (true ? "XX" : "YY"),
                              // (widget.order!.item_name![key] == null
                              //     ? Database_Item.item_names.contains(widget
                              //             .order!.item_name![key]
                              //             .getValue())
                              //         ? Database_Item()
                              //             .get_Items()['net_Weight']
                              //         : "XX"
                              //     : "XX"),
                              style: TextStyle(
                                  color: MyColors.pewterBlue,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (16 / 1063.6))),
                          Text("MRP: \u{20B9} XX.XX",
                              style: TextStyle(
                                  color: MyColors.pewterBlue,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (16 / 1063.6))),
                          Text("Unit: Packet",
                              style: TextStyle(
                                  color: MyColors.pewterBlue,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (16 / 1063.6))),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            MyScreen.getScreenWidth(context) * (20 / 490.9),
                            MyScreen.getScreenHeight(context) * (30 / 1063.6),
                            MyScreen.getScreenWidth(context) * (5 / 490.9),
                            MyScreen.getScreenHeight(context) * (5 / 1063.6)),
                        child: Row(
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                maxHeight: MyScreen.getScreenHeight(context) *
                                    (205 / 1063.6),
                                maxWidth: MyScreen.getScreenWidth(context) *
                                    (285 / 490.9),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                          left: BorderSide(
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          top: BorderSide(
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                        )),
                                        child: Center(
                                          child: Text(
                                            "Unit",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: MyColors.pewterBlue,
                                                fontSize:
                                                    MyScreen.getScreenHeight(
                                                            context) *
                                                        (18 / 1069.9)),
                                          ),
                                        ),
                                        height:
                                            MyScreen.getScreenHeight(context) *
                                                (35 / 1069.9),
                                        width:
                                            MyScreen.getScreenWidth(context) *
                                                (60 / 490.9),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                          left: BorderSide(
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          top: BorderSide(
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          right: BorderSide(
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                        )),
                                        height:
                                            MyScreen.getScreenHeight(context) *
                                                (35 / 1069.9),
                                        width:
                                            MyScreen.getScreenWidth(context) *
                                                (50 / 490.9),
                                        child: Center(
                                          child: Text(
                                            "Qty",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: MyColors.pewterBlue,
                                                fontSize:
                                                    MyScreen.getScreenHeight(
                                                            context) *
                                                        (18 / 1069.9)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                          left: BorderSide(
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          top: BorderSide(
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                        )),
                                        child: Center(
                                          child: Text(
                                            "Packet",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: MyColors.pewterBlue,
                                                fontSize:
                                                    MyScreen.getScreenHeight(
                                                            context) *
                                                        (18 / 1069.9)),
                                          ),
                                        ),
                                        height:
                                            MyScreen.getScreenHeight(context) *
                                                (40 / 1069.9),
                                        width:
                                            MyScreen.getScreenWidth(context) *
                                                (60 / 490.9),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                          left: BorderSide(
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          top: BorderSide(
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          right: BorderSide(
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                        )),
                                        height:
                                            MyScreen.getScreenHeight(context) *
                                                (40 / 1069.9),
                                        width:
                                            MyScreen.getScreenWidth(context) *
                                                (50 / 490.9),
                                        child: Center(
                                          child: TextFormField(
                                            onChanged: (value) {
                                              widget.order!.packet![key] =
                                                  value;
                                            },
                                            initialValue: "0",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: MyColors.pewterBlue,
                                                fontSize:
                                                    MyScreen.getScreenHeight(
                                                            context) *
                                                        (18 / 1069.9)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MyScreen.getScreenWidth(context) *
                                                (20 / 490.9),
                                      ),
                                      SizedBox(
                                        child: Text(
                                          "Subtotal",
                                          style: TextStyle(
                                              color: MyColors.pewterBlue,
                                              fontSize:
                                                  MyScreen.getScreenHeight(
                                                          context) *
                                                      (16 / 1069.9)),
                                        ),
                                        width:
                                            MyScreen.getScreenWidth(context) *
                                                (75 / 490.9),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "2546.00",
                                          style: TextStyle(
                                              color: MyColors.pewterBlue,
                                              fontSize:
                                                  MyScreen.getScreenHeight(
                                                          context) *
                                                      (16 / 1069.9)),
                                        ),
                                        width:
                                            MyScreen.getScreenWidth(context) *
                                                (75 / 490.9),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                          left: BorderSide(
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          top: BorderSide(
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                        )),
                                        child: Center(
                                          child: Text(
                                            "Patti",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: MyColors.pewterBlue,
                                                fontSize:
                                                    MyScreen.getScreenHeight(
                                                            context) *
                                                        (18 / 1069.9)),
                                          ),
                                        ),
                                        height:
                                            MyScreen.getScreenHeight(context) *
                                                (40 / 1069.9),
                                        width:
                                            MyScreen.getScreenWidth(context) *
                                                (60 / 490.9),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                          left: BorderSide(
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          top: BorderSide(
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          right: BorderSide(
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                        )),
                                        height:
                                            MyScreen.getScreenHeight(context) *
                                                (40 / 1069.9),
                                        width:
                                            MyScreen.getScreenWidth(context) *
                                                (50 / 490.9),
                                        child: Center(
                                          child: TextFormField(
                                            onChanged: (value) {
                                              widget.order!.box![key] = value;
                                            },
                                            initialValue: "0",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: MyColors.pewterBlue,
                                                fontSize:
                                                    MyScreen.getScreenHeight(
                                                            context) *
                                                        (18 / 1069.9)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MyScreen.getScreenWidth(context) *
                                                (20 / 490.9),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: MyColors.pewterBlue,
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          "Tax",
                                          style: TextStyle(
                                              color: MyColors.pewterBlue,
                                              fontSize:
                                                  MyScreen.getScreenHeight(
                                                          context) *
                                                      (16 / 1069.9)),
                                        ),
                                        width:
                                            MyScreen.getScreenWidth(context) *
                                                (75 / 490.9),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: MyColors.pewterBlue,
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "546.00",
                                          style: TextStyle(
                                              color: MyColors.pewterBlue,
                                              fontSize:
                                                  MyScreen.getScreenHeight(
                                                          context) *
                                                      (16 / 1069.9)),
                                        ),
                                        width:
                                            MyScreen.getScreenWidth(context) *
                                                (75 / 490.9),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                          left: BorderSide(
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          top: BorderSide(
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                        )),
                                        child: Center(
                                          child: Text(
                                            "Box",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: MyColors.pewterBlue,
                                                fontSize:
                                                    MyScreen.getScreenHeight(
                                                            context) *
                                                        (18 / 1069.9)),
                                          ),
                                        ),
                                        height:
                                            MyScreen.getScreenHeight(context) *
                                                (40 / 1069.9),
                                        width:
                                            MyScreen.getScreenWidth(context) *
                                                (60 / 490.9),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                          left: BorderSide(
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          top: BorderSide(
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          right: BorderSide(
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                        )),
                                        height:
                                            MyScreen.getScreenHeight(context) *
                                                (40 / 1069.9),
                                        width:
                                            MyScreen.getScreenWidth(context) *
                                                (50 / 490.9),
                                        child: Center(
                                          child: TextFormField(
                                            onChanged: (value) {
                                              widget.order!.patti![key] = value;
                                            },
                                            initialValue: "0",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: MyColors.pewterBlue,
                                                fontSize:
                                                    MyScreen.getScreenHeight(
                                                            context) *
                                                        (18 / 1069.9)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MyScreen.getScreenWidth(context) *
                                                (20 / 490.9),
                                      ),
                                      SizedBox(
                                        child: Text(
                                          "Total",
                                          style: TextStyle(
                                              color: MyColors.pewterBlue,
                                              fontSize:
                                                  MyScreen.getScreenHeight(
                                                          context) *
                                                      (16 / 1069.9)),
                                        ),
                                        width:
                                            MyScreen.getScreenWidth(context) *
                                                (75 / 490.9),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "3092.00",
                                          style: TextStyle(
                                              color: MyColors.pewterBlue,
                                              fontSize:
                                                  MyScreen.getScreenHeight(
                                                          context) *
                                                      (16 / 1069.9)),
                                        ),
                                        width:
                                            MyScreen.getScreenWidth(context) *
                                                (75 / 490.9),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                          left: BorderSide(
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          top: BorderSide(
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          bottom: BorderSide(
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                        )),
                                        child: Center(
                                          child: Text(
                                            "Total",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: MyColors.pewterBlue,
                                                fontSize:
                                                    MyScreen.getScreenHeight(
                                                            context) *
                                                        (18 / 1069.9)),
                                          ),
                                        ),
                                        height:
                                            MyScreen.getScreenHeight(context) *
                                                (40 / 1069.9),
                                        width:
                                            MyScreen.getScreenWidth(context) *
                                                (60 / 490.9),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                          left: BorderSide(
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          top: BorderSide(
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          bottom: BorderSide(
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          right: BorderSide(
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                        )),
                                        height:
                                            MyScreen.getScreenHeight(context) *
                                                (40 / 1069.9),
                                        width:
                                            MyScreen.getScreenWidth(context) *
                                                (50 / 490.9),
                                        child: Center(
                                          child: Text(
                                            "XXX",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: MyColors.pewterBlue,
                                                fontSize:
                                                    MyScreen.getScreenHeight(
                                                            context) *
                                                        (18 / 1069.9)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MyScreen.getScreenWidth(context) *
                                  (15 / 490.9),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: MyScreen.getScreenHeight(context) *
                                      (30 / 1063.6),
                                ),
                                InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: MyColors.richBlackFogra,
                                      border: Border.all(
                                          color: MyColors.richBlackFogra),
                                    ),
                                    child: Icon(Icons.save,
                                        color: MyColors.pewterBlue,
                                        size:
                                            MyScreen.getScreenHeight(context) *
                                                (35 / 1063.6)),
                                  ),
                                  onTap: () {},
                                ),
                                SizedBox(
                                  height: MyScreen.getScreenHeight(context) *
                                      (50 / 1063.6),
                                ),
                                InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: MyColors.richBlackFogra,
                                      border: Border.all(
                                          color: MyColors.richBlackFogra),
                                    ),
                                    child: Icon(Icons.delete_forever,
                                        color: MyColors.pewterBlue,
                                        size:
                                            MyScreen.getScreenHeight(context) *
                                                (40 / 1063.6)),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      widget.order!.item_name!.removeAt(key);
                                      // widget.order!.price!.removeAt(key);
                                      // widget.order!.packet!.removeAt(key);
                                      // widget.order!.box!.removeAt(key);
                                      // widget.order!.patti!.removeAt(key);
                                      // widget.order!.tax!.removeAt(key);
                                      // widget.order!.total!.removeAt(key);
                                      widget.order!.counter =
                                          widget.order!.counter! - 1;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
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
    );
  }
}
