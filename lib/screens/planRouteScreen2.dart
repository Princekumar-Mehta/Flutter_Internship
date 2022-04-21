import 'package:flutter/material.dart';
import 'package:project_v3/Database/db_route.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';

class PlanRouteScreen2 extends StatefulWidget {
  String route;
  PlanRouteScreen2({required this.route});

  @override
  _PlanRouteScreen2State createState() => _PlanRouteScreen2State();
}

class _PlanRouteScreen2State extends State<PlanRouteScreen2> {
  Map<String, bool> selected = {};
  var days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  moveToReportScreen2() async {
    List<String> selected_Days = [];
    for (int i = 0; i < days.length; i++) {
      if (selected[days[i]]!) {
        selected_Days.add(days[i]);
      }
    }
    await Database_Route().addRoute(
        salesperson_Id: MyDrawer.emp.id!,
        days: selected_Days,
        route: widget.route);
    // Database_Route().getRouteAllRoutesBySalespersonId(MyDrawer.emp.id!);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  bool selectAll = false;
  @override
  void initState() {
    for (int i = 0; i < days.length; i++) {
      selected[days[i].toString()] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // DatabaseHelper.instance.Temp_Query();
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
        title: Text("Select Days",
            style: TextStyle(
                color: MyDrawer.emp.darkTheme == 1
                    ? MyColors.white
                    : MyColors.scarlet,
                fontSize: MyScreen.getScreenHeight(context) * (20 / 1063.6))),
        centerTitle: true,
        shape: Border(
          bottom: BorderSide(
            color: MyColors.scarlet,
            width: MyScreen.getScreenHeight(context) * (4 / 1063.6),
          ),
        ),
        backgroundColor: MyDrawer.emp.darkTheme == 1
            ? MyColors.richBlackFogra
            : MyColors.white,
      ),
      backgroundColor: MyDrawer.emp.darkTheme == 1
          ? MyColors.richBlackFogra
          : MyColors.white,
      body: Theme(
        data: ThemeData(
          unselectedWidgetColor: MyDrawer.emp.darkTheme == 1
              ? MyColors.middleRed
              : MyColors.scarlet,
        ),
        child: Column(
          children: [
            CheckboxListTile(
              checkColor: MyColors.white,
              activeColor: MyDrawer.emp.darkTheme == 1
                  ? MyColors.middleRed
                  : MyColors.scarlet,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text('Select All',
                  style: TextStyle(
                      fontSize: 13,
                      color: MyDrawer.emp.darkTheme == 1
                          ? MyColors.pewterBlue
                          : MyColors.black)),
              value: selectAll,
              onChanged: (value) {
                setState(() {
                  selectAll = value!;
                  for (int i = 0; i < days.length; i++) {
                    selected[days[i].toString()] = selectAll;
                  }
                });
              },
            ),
            Divider(
              color: MyDrawer.emp.darkTheme == 1
                  ? MyColors.pewterBlue
                  : MyColors.black,
              indent: 15,
              endIndent: 15,
              thickness: 1,
            ),
            Expanded(
              flex: 1,
              child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  shrinkWrap: true,
                  itemCount: days.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: _row(index),
                    );
                  }),
            ),
            InkWell(
              onTap: () {
                moveToReportScreen2();
              },
              child: SizedBox(
                width: MyScreen.getScreenWidth(context) * (85 / 294),
                height: MyScreen.getScreenHeight(context) * (60 / 1063.6),
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
                      child: Text("Add Route",
                          style: TextStyle(
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.richBlackFogra
                                  : MyColors.white,
                              fontSize: MyScreen.getScreenHeight(context) *
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
    );
  }

  _row(int key) {
    return Row(
      children: [
        Container(
          width: 300,
          child: CheckboxListTile(
            checkColor: MyColors.white,
            activeColor: MyDrawer.emp.darkTheme == 1
                ? MyColors.middleRed
                : MyColors.scarlet,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(days[key].toString(),
                style: TextStyle(
                    fontSize: 13,
                    color: MyDrawer.emp.darkTheme == 1
                        ? MyColors.pewterBlue
                        : MyColors.black)),
            value: selected[days[key].toString()],
            onChanged: (value) {
              setState(() {
                selected[days[key].toString()] = value!;
                selectAll = true;
                for (int i = 0; i < days.length; i++) {
                  if (selected[days[i].toString()] == false) selectAll = false;
                }
              });
            },
          ),
        )
      ],
    );
  }
}
