import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:project_v3/Database/db_report.dart';
import 'package:project_v3/screens/reportSalesSalespersonWise2.dart';

class ReportSalesSalespersonWise1 extends StatefulWidget {
  const ReportSalesSalespersonWise1({Key? key}) : super(key: key);

  @override
  _ReportSalesSalespersonWise1State createState() =>
      _ReportSalesSalespersonWise1State();
}

class _ReportSalesSalespersonWise1State
    extends State<ReportSalesSalespersonWise1> {
  final _formKey = GlobalKey<FormBuilderState>();
  moveToReportScreen2() {
    final colors = [
      charts.ColorUtil.fromDartColor(Colors.blueGrey),
      charts.ColorUtil.fromDartColor(Colors.red),
      charts.ColorUtil.fromDartColor(Colors.green),
      charts.ColorUtil.fromDartColor(Colors.lightBlueAccent),
      charts.ColorUtil.fromDartColor(Colors.pink),
      charts.ColorUtil.fromDartColor(Colors.purple),
    ];
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final List<SalesSalespersonModel> data = [];
      for (int i = 0; i < Database_Report.salespersons.length; i++) {
        if (_formKey.currentState
                ?.value[Database_Report.salespersons[i].id.toString()] ==
            true) {
          print(Database_Report.sales_salesperson_wise[i]);
          data.add(
            SalesSalespersonModel(
              salespersonName: Database_Report.salespersons[i].name.toString(),
              sales: Database_Report.sales_salesperson_wise[i],
              color: colors[i % colors.length],
            ),
          );
        }
      }

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ReportSalesSalespersonWise2(
                    data: data,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Employees To Analyse"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              ListView.builder(
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
                child: Text("Generate Report"),
              )
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
          child: FormBuilderCheckbox(
              name: Database_Report.salespersons[key].id!.toString(),
              title: Text(Database_Report.salespersons[key].id!.toString() +
                  " " +
                  Database_Report.salespersons[key].name!.toString())),
        )
      ],
    );
  }
}
