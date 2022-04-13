import 'package:flutter/material.dart';
import 'package:project_v3/Database/db_item.dart';
import 'package:project_v3/Models/order.dart';

import 'myColors.dart';
import 'myScreen.dart';
import 'mydrawer.dart';

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
    print("current is ${widget.order!.current}");
    _animatedHeight = _animatedHeight == -1
        ? MyScreen.getScreenHeight(context) * (250 / 1063.9)
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
                        color: MyDrawer.emp.darkTheme == 1
                            ? MyColors.pewterBlue
                            : MyColors.black,
                        fontSize:
                            MyScreen.getScreenHeight(context) * (17 / 1063.6))),
              ),
              SizedBox(
                height: MyScreen.getScreenHeight(context) * (32 / 1063.6),
                child: InkWell(
                  onTap: () async {
                    bool isOkay = true;
                    if (widget.order!.current != -1) {
                      isOkay = await widget.order!
                          .saveItem(widget.order!.current, context);
                      print(isOkay);
                    }
                    setState(() {
                      if (isOkay) widget.order!.addItem(context);
                    });
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text("Add Item +",
                        style: TextStyle(
                            color: MyDrawer.emp.darkTheme == 1
                                ? MyColors.pewterBlue
                                : MyColors.black,
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
              border: Border.all(
                color: MyDrawer.emp.darkTheme == 1
                    ? MyColors.pewterBlue
                    : MyColors.black,
              ),
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
                                color: MyDrawer.emp.darkTheme == 1
                                    ? MyColors.pewterBlue
                                    : MyColors.black,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6))),
                      ),
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
                            onTap: () async {
                              bool isOkay = true;
                              int old_current = widget.order!.current;
                              if (widget.order!.current == key ||
                                  widget.order!.current != -1) {
                                isOkay =
                                    await widget.order!.saveItem(key, context);
                              }
                              setState(() {
                                if (old_current == key && isOkay) {
                                  widget.order!.current = -1;
                                } else {
                                  if (isOkay) {
                                    widget.order!.current = key;
                                  }
                                }
                              });
                            },
                            child: Icon(
                                widget.order!.current != key
                                    ? Icons.keyboard_arrow_down
                                    : Icons.keyboard_arrow_up,
                                color: MyDrawer.emp.darkTheme == 1
                                    ? MyColors.pewterBlue
                                    : MyColors.black,
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
                  height: widget.order!.current != key ? 0.0 : _animatedHeight,
                  child: Column(
                    children: [
                      SizedBox(
                        height:
                            MyScreen.getScreenHeight(context) * (4 / 1063.6),
                      ),
                      // Price & Unit
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Net Weight:",
                              style: TextStyle(
                                  color: MyDrawer.emp.darkTheme == 1
                                      ? MyColors.pewterBlue
                                      : MyColors.black,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (16 / 1063.6))),
                          Container(
                            height: 16,
                            width: 30,
                            child: widget.order!.giveTextFormField(
                              widget.order!.netWeight![key],
                              context,
                              myAlign: TextAlign.left,
                              isEditable: false,
                            ),
                          ),
                          Text("MRP: \u{20B9}",
                              style: TextStyle(
                                  color: MyDrawer.emp.darkTheme == 1
                                      ? MyColors.pewterBlue
                                      : MyColors.black,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (16 / 1063.6))),
                          Container(
                            height: 16,
                            width: 30,
                            child: widget.order!.giveTextFormField(
                              widget.order!.price![key],
                              context,
                              myAlign: TextAlign.left,
                              isEditable: false,
                            ),
                          ),
                          Text("Unit: Packet",
                              style: TextStyle(
                                  color: MyDrawer.emp.darkTheme == 1
                                      ? MyColors.pewterBlue
                                      : MyColors.black,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (16 / 1063.6))),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            MyScreen.getScreenWidth(context) * (20 / 490.9),
                            MyScreen.getScreenHeight(context) * (10 / 1063.6),
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
                                            color: MyDrawer.emp.darkTheme == 1
                                                ? MyColors.pewterBlue
                                                : MyColors.black,
                                            width: 1.0,
                                          ),
                                          top: BorderSide(
                                            color: MyDrawer.emp.darkTheme == 1
                                                ? MyColors.pewterBlue
                                                : MyColors.black,
                                            width: 1.0,
                                          ),
                                        )),
                                        child: Center(
                                          child: Text(
                                            "Unit",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color:
                                                    MyDrawer.emp.darkTheme == 1
                                                        ? MyColors.pewterBlue
                                                        : MyColors.black,
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
                                            color: MyDrawer.emp.darkTheme == 1
                                                ? MyColors.pewterBlue
                                                : MyColors.black,
                                            width: 1.0,
                                          ),
                                          top: BorderSide(
                                            color: MyDrawer.emp.darkTheme == 1
                                                ? MyColors.pewterBlue
                                                : MyColors.black,
                                            width: 1.0,
                                          ),
                                          right: BorderSide(
                                            color: MyDrawer.emp.darkTheme == 1
                                                ? MyColors.pewterBlue
                                                : MyColors.black,
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
                                                color:
                                                    MyDrawer.emp.darkTheme == 1
                                                        ? MyColors.pewterBlue
                                                        : MyColors.black,
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
                                            color: MyDrawer.emp.darkTheme == 1
                                                ? MyColors.pewterBlue
                                                : MyColors.black,
                                            width: 1.0,
                                          ),
                                          top: BorderSide(
                                            color: MyDrawer.emp.darkTheme == 1
                                                ? MyColors.pewterBlue
                                                : MyColors.black,
                                            width: 1.0,
                                          ),
                                        )),
                                        child: Center(
                                          child: Text(
                                            "Packet",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color:
                                                    MyDrawer.emp.darkTheme == 1
                                                        ? MyColors.pewterBlue
                                                        : MyColors.black,
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
                                            color: MyDrawer.emp.darkTheme == 1
                                                ? MyColors.pewterBlue
                                                : MyColors.black,
                                            width: 1.0,
                                          ),
                                          top: BorderSide(
                                            color: MyDrawer.emp.darkTheme == 1
                                                ? MyColors.pewterBlue
                                                : MyColors.black,
                                            width: 1.0,
                                          ),
                                          right: BorderSide(
                                            color: MyDrawer.emp.darkTheme == 1
                                                ? MyColors.pewterBlue
                                                : MyColors.black,
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
                                          child: widget.order!
                                              .giveTextFormField(
                                                  widget.order!.packet![key],
                                                  context),
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
                                              color: MyDrawer.emp.darkTheme == 1
                                                  ? MyColors.pewterBlue
                                                  : MyColors.black,
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
                                        height: 16,
                                        alignment: Alignment.centerRight,
                                        child: widget.order!.giveTextFormField(
                                          widget.order!.subTotal![key],
                                          context,
                                          isEditable: false,
                                        ),
                                        width:
                                            MyScreen.getScreenWidth(context) *
                                                (80 / 490.9),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                          left: BorderSide(
                                            color: MyDrawer.emp.darkTheme == 1
                                                ? MyColors.pewterBlue
                                                : MyColors.black,
                                            width: 1.0,
                                          ),
                                          top: BorderSide(
                                            color: MyDrawer.emp.darkTheme == 1
                                                ? MyColors.pewterBlue
                                                : MyColors.black,
                                            width: 1.0,
                                          ),
                                        )),
                                        child: Center(
                                          child: Text(
                                            "Patti",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color:
                                                    MyDrawer.emp.darkTheme == 1
                                                        ? MyColors.pewterBlue
                                                        : MyColors.black,
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
                                            color: MyDrawer.emp.darkTheme == 1
                                                ? MyColors.pewterBlue
                                                : MyColors.black,
                                            width: 1.0,
                                          ),
                                          top: BorderSide(
                                            color: MyDrawer.emp.darkTheme == 1
                                                ? MyColors.pewterBlue
                                                : MyColors.black,
                                            width: 1.0,
                                          ),
                                          right: BorderSide(
                                            color: MyDrawer.emp.darkTheme == 1
                                                ? MyColors.pewterBlue
                                                : MyColors.black,
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
                                          child: widget.order!
                                              .giveTextFormField(
                                                  widget.order!.patti![key],
                                                  context),
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
                                              color: MyDrawer.emp.darkTheme == 1
                                                  ? MyColors.pewterBlue
                                                  : MyColors.black,
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          "Tax",
                                          style: TextStyle(
                                              color: MyDrawer.emp.darkTheme == 1
                                                  ? MyColors.pewterBlue
                                                  : MyColors.black,
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
                                        height: 20,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: MyDrawer.emp.darkTheme == 1
                                                  ? MyColors.pewterBlue
                                                  : MyColors.black,
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        alignment: Alignment.centerRight,
                                        child: widget.order!.giveTextFormField(
                                            widget.order!.tax![key], context,
                                            isEditable: false),
                                        width:
                                            MyScreen.getScreenWidth(context) *
                                                (80 / 490.9),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                          left: BorderSide(
                                            color: MyDrawer.emp.darkTheme == 1
                                                ? MyColors.pewterBlue
                                                : MyColors.black,
                                            width: 1.0,
                                          ),
                                          top: BorderSide(
                                            color: MyDrawer.emp.darkTheme == 1
                                                ? MyColors.pewterBlue
                                                : MyColors.black,
                                            width: 1.0,
                                          ),
                                        )),
                                        child: Center(
                                          child: Text(
                                            "Box",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color:
                                                    MyDrawer.emp.darkTheme == 1
                                                        ? MyColors.pewterBlue
                                                        : MyColors.black,
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
                                            color: MyDrawer.emp.darkTheme == 1
                                                ? MyColors.pewterBlue
                                                : MyColors.black,
                                            width: 1.0,
                                          ),
                                          top: BorderSide(
                                            color: MyDrawer.emp.darkTheme == 1
                                                ? MyColors.pewterBlue
                                                : MyColors.black,
                                            width: 1.0,
                                          ),
                                          right: BorderSide(
                                            color: MyDrawer.emp.darkTheme == 1
                                                ? MyColors.pewterBlue
                                                : MyColors.black,
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
                                            child: widget.order!
                                                .giveTextFormField(
                                                    widget.order!.box![key],
                                                    context)),
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
                                              color: MyDrawer.emp.darkTheme == 1
                                                  ? MyColors.pewterBlue
                                                  : MyColors.black,
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
                                        height: 16,
                                        alignment: Alignment.centerRight,
                                        child: widget.order!.giveTextFormField(
                                            widget.order!.total![key], context,
                                            isEditable: false),
                                        width:
                                            MyScreen.getScreenWidth(context) *
                                                (80 / 490.9),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                          left: BorderSide(
                                            color: MyDrawer.emp.darkTheme == 1
                                                ? MyColors.pewterBlue
                                                : MyColors.black,
                                            width: 1.0,
                                          ),
                                          top: BorderSide(
                                            color: MyDrawer.emp.darkTheme == 1
                                                ? MyColors.pewterBlue
                                                : MyColors.black,
                                            width: 1.0,
                                          ),
                                          bottom: BorderSide(
                                            color: MyDrawer.emp.darkTheme == 1
                                                ? MyColors.pewterBlue
                                                : MyColors.black,
                                            width: 1.0,
                                          ),
                                        )),
                                        child: Center(
                                          child: Text(
                                            "Total",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color:
                                                    MyDrawer.emp.darkTheme == 1
                                                        ? MyColors.pewterBlue
                                                        : MyColors.black,
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
                                            color: MyDrawer.emp.darkTheme == 1
                                                ? MyColors.pewterBlue
                                                : MyColors.black,
                                            width: 1.0,
                                          ),
                                          top: BorderSide(
                                            color: MyDrawer.emp.darkTheme == 1
                                                ? MyColors.pewterBlue
                                                : MyColors.black,
                                            width: 1.0,
                                          ),
                                          bottom: BorderSide(
                                            color: MyDrawer.emp.darkTheme == 1
                                                ? MyColors.pewterBlue
                                                : MyColors.black,
                                            width: 1.0,
                                          ),
                                          right: BorderSide(
                                            color: MyDrawer.emp.darkTheme == 1
                                                ? MyColors.pewterBlue
                                                : MyColors.black,
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
                                          child:
                                              widget.order!.giveTextFormField(
                                            widget.order!.totalItem![key],
                                            context,
                                            isEditable: false,
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
                                InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: MyDrawer.emp.darkTheme == 1
                                          ? MyColors.richBlackFogra
                                          : MyColors.white,
                                      border: Border.all(
                                        color: MyDrawer.emp.darkTheme == 1
                                            ? MyColors.richBlackFogra
                                            : MyColors.white,
                                      ),
                                    ),
                                    child: Icon(Icons.save,
                                        color: MyDrawer.emp.darkTheme == 1
                                            ? MyColors.pewterBlue
                                            : MyColors.black,
                                        size:
                                            MyScreen.getScreenHeight(context) *
                                                (35 / 1063.6)),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      widget.order!
                                          .saveItem(key, context, close: false);
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: MyScreen.getScreenHeight(context) *
                                      (50 / 1063.6),
                                ),
                                InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: MyDrawer.emp.darkTheme == 1
                                          ? MyColors.richBlackFogra
                                          : MyColors.white,
                                      border: Border.all(
                                        color: MyDrawer.emp.darkTheme == 1
                                            ? MyColors.richBlackFogra
                                            : MyColors.white,
                                      ),
                                    ),
                                    child: Icon(Icons.delete_forever,
                                        color: MyDrawer.emp.darkTheme == 1
                                            ? MyColors.pewterBlue
                                            : MyColors.black,
                                        size:
                                            MyScreen.getScreenHeight(context) *
                                                (40 / 1063.6)),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      widget.order!.deleteItem(key);
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
