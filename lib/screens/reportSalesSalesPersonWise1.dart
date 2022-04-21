import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:project_v3/Database/db_report.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/Extras/utility.dart';
import 'package:project_v3/screens/reportSalesSalespersonWise2.dart';

class ReportSalesSalespersonWise1 extends StatefulWidget {
  String report_type;
  ReportSalesSalespersonWise1({required this.report_type});
  @override
  _ReportSalesSalespersonWise1State createState() =>
      _ReportSalesSalespersonWise1State();
}

class _ReportSalesSalespersonWise1State
    extends State<ReportSalesSalespersonWise1> {
  Map<String, bool> selected = {};
  moveToReportScreen2() {
    final colors = [
      charts.ColorUtil.fromDartColor(const Color(0xFF8DA0CB)),
      charts.ColorUtil.fromDartColor(const Color(0xFFE78AC3)),
      charts.ColorUtil.fromDartColor(const Color(0xFFA6D853)),
      charts.ColorUtil.fromDartColor(const Color(0xFFFFD930)),
      charts.ColorUtil.fromDartColor(const Color(0xFFE4C493)),
      charts.ColorUtil.fromDartColor(const Color(0xFFB3B3B3)),
      charts.ColorUtil.fromDartColor(const Color(0xFF65C2A5)),
      charts.ColorUtil.fromDartColor(const Color(0xFFFC8D62)),
    ];
    final List<DataSalespersonModel> data = [];
    //print(Database_Report.salespersons.length.toString());
    for (int i = 0; i < Database_Report.salespersons.length; i++) {
      if (selected[Database_Report.salespersons[i].id.toString()] == true) {
        //print(Database_Report.sales_salesperson_wise[i]);
        data.add(
          DataSalespersonModel(
            salespersonName: Database_Report.salespersons[i].name.toString(),
            data: widget.report_type != "sales"
                ? Database_Report.hours_salesperson_wise[i]
                : Database_Report.sales_salesperson_wise[i],
            color: colors[i % colors.length],
          ),
        );
        //print(Database_Report.hours_salesperson_wise[i]);
      }
    }
    if (data.isEmpty) {
      Utility.showMessage(
          context, "Please select at least one employee to proceed");
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ReportSalesSalespersonWise2(
                    data: data,
                  )));
    }
  }

  @override
  void initState() {
    for (int i = 0; i < Database_Report.salespersons.length; i++) {
      selected[Database_Report.salespersons[i].id.toString()] = false;
    }
  }

  bool selectAll = false;
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
        title: Text("Select Employees to Analyze",
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
      body: SingleChildScrollView(
        child: Theme(
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
                    for (int i = 0;
                        i < Database_Report.salespersons.length;
                        i++) {
                      selected[Database_Report.salespersons[i].id.toString()] =
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
              ListView.builder(
                  padding: const EdgeInsets.all(12),
                  shrinkWrap: true,
                  itemCount: Database_Report.salespersons.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: _row(index),
                    );
                  }),
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
                ),
              ),
            ],
          ),
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
                Database_Report.salespersons[key].id.toString() +
                    "\t" +
                    Database_Report.salespersons[key].name.toString(),
                style: TextStyle(
                    fontSize: 13,
                    color: MyDrawer.emp.darkTheme == 1
                        ? MyColors.pewterBlue
                        : MyColors.black)),
            value: selected[Database_Report.salespersons[key].id.toString()],
            onChanged: (value) {
              setState(() {
                selected[Database_Report.salespersons[key].id.toString()] =
                    value!;
                selectAll = true;
                for (int i = 0; i < Database_Report.salespersons.length; i++) {
                  if (selected[Database_Report.salespersons[i].id.toString()] ==
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
