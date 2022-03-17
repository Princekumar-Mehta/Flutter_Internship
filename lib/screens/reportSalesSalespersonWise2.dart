import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';

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
    String dropdownvalue = 'Select an Option';
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bar Chart"),
        centerTitle: true,
        backgroundColor: Colors.green[700],
      ),
      backgroundColor: MyColors.richBlackFogra,
      body: Column(
        children: [
          SizedBox(
            height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
          ),
          SizedBox(
            width: MyScreen.getScreenWidth(context) * (228 / 294),
            height: MyScreen.getScreenHeight(context) * (30 / 1063.6),
            child: Text("Select Type *",
                style: TextStyle(
                    color: MyColors.pewterBlue,
                    fontSize:
                        MyScreen.getScreenHeight(context) * (20 / 1063.6))),
          ),
          Stack(children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: MyColors.pewterBlue,
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
                dropdownColor: MyColors.richBlackFogra,
                iconSize: MyScreen.getScreenHeight(context) * (35 / 1063.6),
                isExpanded: true,
                isDense: true,
                iconDisabledColor: MyColors.pewterBlue,
                iconEnabledColor: MyColors.pewterBlue,
                icon: const Icon(Icons.arrow_drop_down),
                style: TextStyle(color: MyColors.pewterBlue),
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
                                color: MyColors.pewterBlue,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (20 / 1063.6)))),
                  );
                }).toList(),
              ),
            )
          ]),
          Container(
            height: MyScreen.getScreenHeight(context) * .75,
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
