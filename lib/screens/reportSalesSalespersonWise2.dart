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
