import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:url_launcher/url_launcher.dart';

class SalespersonAttendance extends StatefulWidget {
  @override
  State<SalespersonAttendance> createState() => _SalespersonAttendanceState();
}

class _SalespersonAttendanceState extends State<SalespersonAttendance> {
  List<TableRow> tableRows = [];

  @override
  Widget build(BuildContext context) {
    tableRows = [];
    for (int i = -1; i < 8; i++) {
      if (i == -1) {
        tableRows.add(TableRow(children: [
          Column(children: [
            Text(
              "Time",
              style: TextStyle(
                color: MyColors.white,
                fontSize: MyScreen.getScreenHeight(context) * (18 / 1063.6),
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
          Column(children: [
            Text(
              "Latitude",
              style: TextStyle(
                color: MyColors.white,
                fontSize: MyScreen.getScreenHeight(context) * (18 / 1063.6),
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
          Column(children: [
            Text(
              "Longitude",
              style: TextStyle(
                color: MyColors.white,
                fontSize: MyScreen.getScreenHeight(context) * (18 / 1063.6),
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        ]));
      } else {
        tableRows.add(TableRow(children: [
          Column(children: [
            Text(
              "XX:XX AM/PM",
              style: TextStyle(
                color: MyColors.white,
                fontSize: MyScreen.getScreenHeight(context) * (18 / 1063.6),
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
          Column(children: [
            Text(
              "123.666666",
              style: TextStyle(
                color: MyColors.white,
                fontSize: MyScreen.getScreenHeight(context) * (18 / 1063.6),
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
          Column(children: [
            Text(
              "123.666666",
              style: TextStyle(
                color: MyColors.white,
                fontSize: MyScreen.getScreenHeight(context) * (18 / 1063.6),
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        ]));
      }
    }

    return Scaffold(
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(
            color: MyColors.scarlet,
            width: MyScreen.getScreenHeight(context) * (4 / 1063.6),
          ),
        ),
        title: Text("Salesperson Attendance",
            style: TextStyle(
                color: MyColors.white,
                fontSize: MyScreen.getScreenHeight(context) * (20 / 1063.6))),
        centerTitle: true,
        backgroundColor: MyColors.richBlackFogra,
      ),
      drawer: MyDrawer(),
      backgroundColor: MyColors.richBlackFogra,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              MyScreen.getScreenWidth(context) * (20 / 490.9),
              MyScreen.getScreenHeight(context) * (20 / 1063.6),
              MyScreen.getScreenWidth(context) * (20 / 490.9),
              MyScreen.getScreenHeight(context) * (20 / 1063.6)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: MyColors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      width: MyScreen.getScreenWidth(context) * (450 / 490.9),
                      height: MyScreen.getScreenHeight(context) * (80 / 1063.6),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            MyScreen.getScreenWidth(context) * (10.0 / 490.9),
                            MyScreen.getScreenHeight(context) * (0 / 1063.6),
                            MyScreen.getScreenWidth(context) * (10.0 / 490.9),
                            MyScreen.getScreenHeight(context) * (0 / 1063.6)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: MyScreen.getScreenWidth(context) *
                                      (50 / 490.9),
                                  height: MyScreen.getScreenWidth(context) *
                                      (50 / 490.9),
                                  color: MyColors.richBlackFogra,
                                  child: Image.file(
                                      File(MyDrawer.emp.profile_pic!)),
                                ),
                                SizedBox(
                                  width: MyScreen.getScreenWidth(context) *
                                      (10 / 490.9),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          MyDrawer.emp.name!,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: MyScreen.getScreenHeight(
                                                    context) *
                                                (20 / 1063.6),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MyScreen.getScreenHeight(context) *
                                              (8 / 1063.6),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        launch("tel:1234567891");
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            size: MyScreen.getScreenHeight(
                                                    context) *
                                                (25 / 1063.6),
                                          ),
                                          SizedBox(
                                            width: MyScreen.getScreenWidth(
                                                    context) *
                                                (10 / 490.9),
                                          ),
                                          Text(
                                            "12345 67891",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  MyScreen.getScreenHeight(
                                                          context) *
                                                      (15 / 1063.6),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MyScreen.getScreenWidth(
                                                    context) *
                                                (125 / 490.9),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MyScreen.getScreenHeight(context) * (20 / 1063.6),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(
                      MyScreen.getScreenWidth(context) * (10 / 490.9),
                      MyScreen.getScreenHeight(context) * (5 / 1063.6),
                      MyScreen.getScreenWidth(context) * (10 / 490.9),
                      MyScreen.getScreenHeight(context) * (5 / 1063.6)),
                  width: MyScreen.getScreenWidth(context) * (480 / 490.9),
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(2.5),
                      1: FlexColumnWidth(2.5),
                      2: FlexColumnWidth(2.5),
                    },
                    border: TableBorder.all(
                        color: MyColors.grey,
                        style: BorderStyle.solid,
                        width: 1),
                    children: tableRows,
                  ),
                ),
                SizedBox(
                  height: MyScreen.getScreenHeight(context) * (550 / 1063.6),
                ),
                SizedBox(
                  width: MyScreen.getScreenWidth(context) * (130 / 294),
                  height: MyScreen.getScreenHeight(context) * (60 / 1063.6),
                  child: InkWell(
                    onTap: () async {
                      Position position = await _determinePosition();
                      print(
                          "Latitude: " + position.latitude.toStringAsFixed(6));
                      print("Longitude: " +
                          position.longitude.toStringAsFixed(6));
                      String time = DateTime.now()
                          .toString()
                          .split(" ")[1]
                          .substring(0, 5);
                      String meridian = "";
                      if (int.parse(time.substring(0, 2)) < 12) {
                        meridian = "AM";
                      } else {
                        meridian = "PM";
                      }
                      print("Time: " + time + " " + meridian);
                    },
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
                              color: MyColors.middleRed,
                            ),
                          ),
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.location_history,
                                size: MyScreen.getScreenHeight(context) *
                                    (25 / 1063.6),
                                color: MyColors.richBlackFogra,
                              ),
                              Text("Log Current Location",
                                  style: TextStyle(
                                      color: MyColors.richBlackFogra,
                                      fontSize:
                                          MyScreen.getScreenHeight(context) *
                                              (17 / 1063.6),
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
