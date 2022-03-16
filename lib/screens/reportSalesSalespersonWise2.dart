/*import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';*/
/*
class SalesSalespersonModel {
  String salespersonName;
  int sales;
  final charts.Color color;

  SalesSalespersonModel({
    required this.year,
    required this.financial,
    required this.color,
  });
}

class ReportSalesSalespersonWise2 extends StatelessWidget {
  ReportSalesSalespersonWise2({Key? key}) : super(key: key);
  final List<SalesSalespersonModel> data = [
    SalesSalespersonModel(
      year: "2014",
      financial: 250,
      color: charts.ColorUtil.fromDartColor(Colors.blueGrey),
    ),
    SalesSalespersonModel(
      year: "2015",
      financial: 300,
      color: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    SalesSalespersonModel(
      year: "2016",
      financial: 100,
      color: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    SalesSalespersonModel(
      year: "2017",
      financial: 450,
      color: charts.ColorUtil.fromDartColor(Colors.yellow),
    ),
    SalesSalespersonModel(
      year: "2018",
      financial: 630,
      color: charts.ColorUtil.fromDartColor(Colors.lightBlueAccent),
    ),
    SalesSalespersonModel(
      year: "2019",
      financial: 950,
      color: charts.ColorUtil.fromDartColor(Colors.pink),
    ),
    SalesSalespersonModel(
      year: "2020",
      financial: 400,
      color: charts.ColorUtil.fromDartColor(Colors.purple),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<charts.Series<SalesSalespersonModel, String>> series = [
      charts.Series(
        id: "financial",
        data: data,
        domainFn: (SalesSalespersonModel series, _) => series.year,
        measureFn: (SalesSalespersonModel series, _) => series.financial,
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
}*/
