import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:project_v3/Database/db_report.dart';
import 'package:project_v3/screens/reportItemWise2.dart';

class ReportItemWise1 extends StatefulWidget {
  const ReportItemWise1({Key? key}) : super(key: key);

  @override
  _ReportItemWise1State createState() => _ReportItemWise1State();
}

class _ReportItemWise1State extends State<ReportItemWise1> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, double> dataMap = {};
  moveToReportScreen2() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      for (int i = 0; i < Database_Report.items.length; i++) {
        //    print(_formKey.currentState?.value[Database_Report.items[i].item_Name]);
        if (_formKey.currentState?.value[Database_Report.items[i].item_Name] ==
            true) {
          dataMap[Database_Report.items[i].item_Name.toString()] =
              double.parse(Database_Report.sales_in_packet[i].toString());
        }
      }
      print(dataMap);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ReportItemWise2(
                    dataMap: dataMap,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Items To Analyse"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: Database_Report.items.length,
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
              name: Database_Report.items[key].item_Name!,
              title: Text(Database_Report.items[key].item_Name!)),
        )
      ],
    );
  }
}
