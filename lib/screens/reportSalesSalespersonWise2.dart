import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';

class DataSalespersonModel {
  String salespersonName;
  int data;
  final charts.Color color;

  DataSalespersonModel({
    required this.salespersonName,
    required this.data,
    required this.color,
  });
}

class ReportSalesSalespersonWise2 extends StatefulWidget {
  final List<DataSalespersonModel> data;
  ReportSalesSalespersonWise2({required this.data});

  @override
  State<ReportSalesSalespersonWise2> createState() =>
      _ReportSalesSalespersonWise2State();
}

class _ReportSalesSalespersonWise2State
    extends State<ReportSalesSalespersonWise2> {
  @override
  Widget build(BuildContext context) {
    List<charts.Series<DataSalespersonModel, String>> series = [
      charts.Series(
        id: "sales",
        data: widget.data,
        domainFn: (DataSalespersonModel series, _) => series.salespersonName,
        measureFn: (DataSalespersonModel series, _) => series.data,
        colorFn: (DataSalespersonModel series, _) => series.color,
      ),
    ];
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
        title: Text("Employee Reports",
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
      backgroundColor: MyColors.white,
      body: Column(
        children: [
          SizedBox(
            height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
          ),
          /*SizedBox(
            width: MyScreen.getScreenWidth(context) * (228 / 294),
            height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
            child: Text("Select Type *",
                style: TextStyle(
                    color: MyDrawer.emp.darkTheme == 1
                        ? MyColors.pewterBlue
                        : MyColors.black,
                    fontSize:
                        MyScreen.getScreenHeight(context) * (20 / 1063.6))),
          ),
          Stack(children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: MyDrawer.emp.darkTheme == 1
                      ? MyColors.pewterBlue
                      : MyColors.black,
                  width: MyScreen.getScreenWidth(context) * (.75 / 294),
                ),
              ),
              width: MyScreen.getScreenWidth(context) * (228 / 294),
              height: 50,
              child: FormBuilderDropdown<String>(
                name: 'role',
                validator: (value) {
                  if (value.toString() == "Select an Option") {
                    return "Please select a role";
                  }
                  return null;
                },
                dropdownColor: MyDrawer.emp.darkTheme == 1
                    ? MyColors.richBlackFogra
                    : MyColors.white,
                iconSize: MyScreen.getScreenHeight(context) * (35 / 1063.6),
                isExpanded: true,
                isDense: true,
                iconDisabledColor: MyDrawer.emp.darkTheme == 1
                    ? MyColors.pewterBlue
                    : MyColors.black,
                iconEnabledColor: MyDrawer.emp.darkTheme == 1
                    ? MyColors.pewterBlue
                    : MyColors.black,
                icon: const Icon(Icons.arrow_drop_down),
                style: TextStyle(
                    color: MyDrawer.emp.darkTheme == 1
                        ? MyColors.pewterBlue
                        : MyColors.black),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
                items: <String>[
                  'Salesperson',
                  'Regional Manager',
                  'Area Manager',
                  'General Manager'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Center(
                        child: Text(value,
                            style: TextStyle(
                                color: MyDrawer.emp.darkTheme == 1
                                    ? MyColors.pewterBlue
                                    : MyColors.black,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6)))),
                  );
                }).toList(),
              ),
            )
          ]),*/
          Container(
            height: MyScreen.getScreenHeight(context) * .85,
            //padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: charts.BarChart(
              series,
              animate: true,
            ),
          ),
        ],
      ),
    );
  }
}
