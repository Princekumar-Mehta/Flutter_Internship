import 'package:flutter/material.dart';
import 'package:project_v3/Database/db_item.dart';

import 'myColors.dart';
import 'myScreen.dart';
import 'myTypeAhead.dart';

class MyItemContainer extends StatefulWidget {
  const MyItemContainer({Key? key}) : super(key: key);

  @override
  _MyItemContainerState createState() => _MyItemContainerState();
}

class _MyItemContainerState extends State<MyItemContainer> {
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
  var _calculated = [
    'Subtotal',
    '5067.30',
    'Tax',
    '609.00',
    'Total',
    '5676.30'
  ];
  List<MyTypeAhead>? order_item_name;
  int? _counter;
  @override
  void initState() {
    Database_Item.insertData();
    var _items = Database_Item();
    _items.get_Items();
    _animatedHeight = -1;
    _counter = 0;
    order_item_name = [];
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
              Container(
                height: MyScreen.getScreenHeight(context) * (32 / 1063.6),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      order_item_name!.add(MyTypeAhead(
                          itemList: Database_Item.item_names,
                          message: "Please Enter Item Name",
                          isEnabled: true));
                      _counter = _counter! + 1;
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
              )
            ],
          ),
        ),
      ),
      //items
      ListView.builder(
          shrinkWrap: true,
          itemCount: _counter,
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
                            width: 200,
                            child: order_item_name![key],
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
                        children: [
                          // Spacing to be kept between Field Name & Field Input
                          SizedBox(
                              height: MyScreen.getScreenHeight(context) *
                                  (25 / 1063.6)),
                          SizedBox(
                              width: MyScreen.getScreenWidth(context) *
                                  (70 / 490.9)),
                          Text("Price: \$ XX.XX",
                              style: TextStyle(
                                  color: MyColors.pewterBlue,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (19 / 1063.6))),
                          SizedBox(
                              width: MyScreen.getScreenWidth(context) *
                                  (50 / 490.9)),
                          Text("Unit: Packet",
                              style: TextStyle(
                                  color: MyColors.pewterBlue,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (19 / 1063.6))),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            MyScreen.getScreenWidth(context) * (20 / 490.9),
                            MyScreen.getScreenHeight(context) * (30 / 1063.6),
                            MyScreen.getScreenWidth(context) * (20 / 490.9),
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
                                            //                   <--- left side
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          top: BorderSide(
                                            //                   <--- left side
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
                                                        (22 / 1069.9)),
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
                                            //                   <--- left side
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          top: BorderSide(
                                            //                   <--- left side
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          right: BorderSide(
                                            //                   <--- left side
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
                                                        (22 / 1069.9)),
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
                                            //                   <--- left side
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          top: BorderSide(
                                            //                   <--- left side
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
                                                        (22 / 1069.9)),
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
                                            //                   <--- left side
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          top: BorderSide(
                                            //                   <--- left side
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          right: BorderSide(
                                            //                   <--- left side
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
                                            initialValue: "0",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: MyColors.pewterBlue,
                                                fontSize:
                                                    MyScreen.getScreenHeight(
                                                            context) *
                                                        (22 / 1069.9)),
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
                                                      (19 / 1069.9)),
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
                                                      (19 / 1069.9)),
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
                                            //                   <--- left side
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          top: BorderSide(
                                            //                   <--- left side
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
                                                        (22 / 1069.9)),
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
                                            //                   <--- left side
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          top: BorderSide(
                                            //                   <--- left side
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          right: BorderSide(
                                            //                   <--- left side
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
                                            initialValue: "0",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: MyColors.pewterBlue,
                                                fontSize:
                                                    MyScreen.getScreenHeight(
                                                            context) *
                                                        (22 / 1069.9)),
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
                                                      (19 / 1069.9)),
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
                                                      (19 / 1069.9)),
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
                                            //                   <--- left side
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          top: BorderSide(
                                            //                   <--- left side
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
                                                        (22 / 1069.9)),
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
                                            //                   <--- left side
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          top: BorderSide(
                                            //                   <--- left side
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          right: BorderSide(
                                            //                   <--- left side
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
                                            initialValue: "0",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: MyColors.pewterBlue,
                                                fontSize:
                                                    MyScreen.getScreenHeight(
                                                            context) *
                                                        (22 / 1069.9)),
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
                                                      (19 / 1069.9)),
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
                                                      (19 / 1069.9)),
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
                                            //                   <--- left side
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          top: BorderSide(
                                            //                   <--- left side
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          bottom: BorderSide(
                                            //                   <--- left side
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
                                                        (22 / 1069.9)),
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
                                            //                   <--- left side
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          top: BorderSide(
                                            //                   <--- left side
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          bottom: BorderSide(
                                            //                   <--- left side
                                            color: MyColors.pewterBlue,
                                            width: 1.0,
                                          ),
                                          right: BorderSide(
                                            //                   <--- left side
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
                                            "XX",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: MyColors.pewterBlue,
                                                fontSize:
                                                    MyScreen.getScreenHeight(
                                                            context) *
                                                        (22 / 1069.9)),
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
                                  (12 / 490.9),
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
                                  onTap: () {},
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
