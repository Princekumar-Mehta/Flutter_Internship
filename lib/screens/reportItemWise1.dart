import 'package:flutter/material.dart';
import 'package:project_v3/Database/db_report.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/Extras/utility.dart';
import 'package:project_v3/screens/reportItemWise2.dart';

class ReportItemWise1 extends StatefulWidget {
  String report_type;
  ReportItemWise1({required this.report_type});

  @override
  _ReportItemWise1State createState() => _ReportItemWise1State();
}

class _ReportItemWise1State extends State<ReportItemWise1> {
  Map<String, double> dataMap = {};
  Map<String, bool> selected = {};
  moveToReportScreen2() {
    //print(selected);
    dataMap = {};
    for (int i = 0; i < Database_Report.items.length; i++) {
      //    print(_formKey.currentState?.value[Database_Report.items[i].item_Name]);
      if (selected[Database_Report.items[i].code.toString()] == true) {
        dataMap[Database_Report.items[i].item_Name.toString()] =
            widget.report_type == "revenue"
                ? double.parse(Database_Report.sales_in_revenue[i].toString())
                : double.parse(Database_Report.sales_in_packet[i].toString());
      }
    }
    if (dataMap.isEmpty) {
      Utility.showMessage(context, "Please select at least one item");
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ReportItemWise2(
                    dataMap: dataMap,
                  )));
    }
  }

  bool selectAll = false;
  @override
  void initState() {
    for (int i = 0; i < Database_Report.items.length; i++) {
      selected[Database_Report.items[i].code.toString()] = false;
    }
  }

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
        title: Text("Select Items to Analyze",
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
                  for (int i = 0; i < Database_Report.items.length; i++) {
                    selected[Database_Report.items[i].code.toString()] =
                        selectAll;
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
                  itemCount: Database_Report.items.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: _row(index),
                    );
                  }),
            ),
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
                      child: Text("Generate Report",
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
                onTap: () {
                  moveToReportScreen2();
                },
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
            title: Text(
                Database_Report.items[key].code.toString() +
                    "\t" +
                    Database_Report.items[key].item_Name.toString(),
                style: TextStyle(
                    fontSize: 13,
                    color: MyDrawer.emp.darkTheme == 1
                        ? MyColors.pewterBlue
                        : MyColors.black)),
            value: selected[Database_Report.items[key].code.toString()],
            onChanged: (value) {
              setState(() {
                selected[Database_Report.items[key].code.toString()] = value!;
                selectAll = true;
                for (int i = 0; i < Database_Report.items.length; i++) {
                  if (selected[Database_Report.items[i].code.toString()] ==
                      false) selectAll = false;
                }
              });
            },
          ),
        )
      ],
    );
  }
}
