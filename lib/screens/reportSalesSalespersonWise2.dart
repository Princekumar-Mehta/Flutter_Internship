import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SalesSalespersonModel {
  String salespersonName;
  int sales;
  final charts.Color color;

  SalesSalespersonModel({
    required this.salespersonName,
    required this.sales,
    required this.color,
  });
}

class ReportSalesSalespersonWise2 extends StatefulWidget {
  final List<SalesSalespersonModel> data;
  ReportSalesSalespersonWise2({required this.data});

  @override
  State<ReportSalesSalespersonWise2> createState() =>
      _ReportSalesSalespersonWise2State();
}

class _ReportSalesSalespersonWise2State
    extends State<ReportSalesSalespersonWise2> {
  // final List<SalesSalespersonModel> data = [
  //   SalesSalespersonModel(
  //     salespersonName: "Prince Mehta",
  //     sales: 2500,
  //     color: charts.ColorUtil.fromDartColor(Colors.blueGrey),
  //   ),
  //   SalesSalespersonModel(
  //     salespersonName: "Malhar Shah",
  //     sales: 3000,
  //     color: charts.ColorUtil.fromDartColor(Colors.red),
  //   ),
  //   SalesSalespersonModel(
  //     salespersonName: "Maurya Patel",
  //     sales: 1000,
  //     color: charts.ColorUtil.fromDartColor(Colors.green),
  //   ),
  //   SalesSalespersonModel(
  //     salespersonName: "Rose",
  //     sales: 4580,
  //     color: charts.ColorUtil.fromDartColor(Colors.yellow),
  //   ),
  //   SalesSalespersonModel(
  //     salespersonName: "Joey",
  //     sales: 0,
  //     color: charts.ColorUtil.fromDartColor(Colors.lightBlueAccent),
  //   ),
  //   // SalesSalespersonModel(
  //   //   salespersonName: "2019",
  //   //   sales: 950,
  //   //   color: charts.ColorUtil.fromDartColor(Colors.pink),
  //   // ),
  //   // SalesSalespersonModel(
  //   //   salespersonName: "2020",
  //   //   sales: 400,
  //   //   color: charts.ColorUtil.fromDartColor(Colors.purple),
  //   // ),
  // ];

  @override
  Widget build(BuildContext context) {
    List<charts.Series<SalesSalespersonModel, String>> series = [
      charts.Series(
        id: "sales",
        data: widget.data,
        domainFn: (SalesSalespersonModel series, _) => series.salespersonName,
        measureFn: (SalesSalespersonModel series, _) => series.sales,
        colorFn: (SalesSalespersonModel series, _) => series.color,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bar Chart"),
        centerTitle: true,
        backgroundColor: Colors.green[700],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: charts.BarChart(
          series,
          animate: true,
        ),
      ),
    );
  }
}
