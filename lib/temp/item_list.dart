import 'package:flutter/material.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';

class adminHome extends StatelessWidget {
  const adminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          shape: Border(
            bottom: BorderSide(
              color: MyColors.scarlet,
              width: MyScreen.getScreenHeight(context) * (4 / 1063.6),
            ),
          ),
          title: Text("Sync Successful",
              style: TextStyle(
                  color: MyColors.scarlet,
                  fontSize: MyScreen.getScreenHeight(context) * (20 / 1063.6))),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.menu,
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
                  child: Icon(Icons.sync,
                      color: MyColors.scarlet,
                      size: MyScreen.getScreenHeight(context) * (30 / 1063.6)),
                ),
                onTap: () {
                  // Navigator.pop(context, true);
                },
              ),
            ),
          ],
          backgroundColor: MyColors.richBlackFogra,
        ),
        backgroundColor: MyColors.richBlackFogra,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: MyScreen.getScreenHeight(context) * (25 / 1063.6),
                ),
                // Outer Shell
                Container(
                  padding: EdgeInsets.fromLTRB(
                      MyScreen.getScreenWidth(context) * (10 / 490.9),
                      MyScreen.getScreenHeight(context) * (5 / 1063.6),
                      MyScreen.getScreenWidth(context) * (10 / 490.9),
                      MyScreen.getScreenHeight(context) * (5 / 1063.6)),
                  height: MyScreen.getScreenHeight(context) * (140 / 1063.6),
                  width: MyScreen.getScreenWidth(context) * (460 / 490.9),
                  decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(
                        MyScreen.getScreenHeight(context) * (15 / 1063.6))),
                  ),
                  child: Column(
                    children: [
                      // Order Summary
                      Row(
                        children: [
                          Icon(
                            Icons.timeline,
                            size: MyScreen.getScreenHeight(context) *
                                (30 / 1063.6),
                            color: MyColors.black,
                          ),
                          SizedBox(
                            width:
                                MyScreen.getScreenWidth(context) * (15 / 490.9),
                          ),
                          Text("Order Summary",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (22 / 1063.6),
                                fontWeight: FontWeight.bold,
                                color: MyColors.black,
                              )),
                        ],
                      ),
                      Container(
                        color: MyColors.black,
                        height:
                            MyScreen.getScreenHeight(context) * (3 / 1063.6),
                      ),
                      SizedBox(
                        height:
                            MyScreen.getScreenHeight(context) * (10 / 1063.6),
                      ),
                      // Main
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: MyScreen.getScreenWidth(context) *
                                    (53 / 490.9),
                                height: MyScreen.getScreenWidth(context) *
                                    (53 / 490.9),
                                decoration: BoxDecoration(
                                  color: MyColors.scarlet,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          MyScreen.getScreenHeight(context) *
                                              (10 / 1063.6))),
                                ),
                                child: Icon(
                                  Icons.timelapse,
                                  size: MyScreen.getScreenHeight(context) *
                                      (30 / 1063.6),
                                  color: MyColors.black,
                                ),
                              ),
                              SizedBox(
                                height: MyScreen.getScreenHeight(context) *
                                    (2 / 1063.6),
                              ),
                              Text("Processing Orders",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize:
                                        MyScreen.getScreenHeight(context) *
                                            (12 / 1063.6),
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.black,
                                  )),
                            ],
                          ),
                          /*SizedBox(
                            width: MyScreen.getScreenWidth(context) *
                                (60 / 490.9),
                          ),*/
                          Column(
                            children: [
                              Container(
                                width: MyScreen.getScreenWidth(context) *
                                    (53 / 490.9),
                                height: MyScreen.getScreenHeight(context) *
                                    (53 / 1063.6),
                                decoration: BoxDecoration(
                                  color: MyColors.scarlet,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          MyScreen.getScreenHeight(context) *
                                              (10 / 1063.6))),
                                ),
                                child: Icon(
                                  Icons.radio_button_checked,
                                  size: MyScreen.getScreenHeight(context) *
                                      (30 / 1063.6),
                                  color: MyColors.black,
                                ),
                              ),
                              SizedBox(
                                height: MyScreen.getScreenWidth(context) *
                                    (2 / 490.9),
                              ),
                              Text("Fulfilled Orders",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize:
                                        MyScreen.getScreenHeight(context) *
                                            (12 / 1063.6),
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.black,
                                  )),
                            ],
                          ),
                          /*SizedBox(
                            width: MyScreen.getScreenWidth(context) *
                                (60 / 490.9),
                          ),*/
                          Column(
                            children: [
                              Container(
                                width: MyScreen.getScreenWidth(context) *
                                    (53 / 490.9),
                                height: MyScreen.getScreenHeight(context) *
                                    (53 / 1063.6),
                                decoration: BoxDecoration(
                                  color: MyColors.scarlet,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          MyScreen.getScreenHeight(context) *
                                              (10 / 1063.6))),
                                ),
                                child: Icon(
                                  Icons.timer,
                                  size: MyScreen.getScreenHeight(context) *
                                      (30 / 1063.6),
                                  color: MyColors.black,
                                ),
                              ),
                              SizedBox(
                                height: MyScreen.getScreenWidth(context) *
                                    (2 / 490.9),
                              ),
                              Text("Pending Orders",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize:
                                        MyScreen.getScreenHeight(context) *
                                            (12 / 1063.6),
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.black,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ],
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
