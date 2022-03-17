import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:project_v3/Database/db_report.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
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
  Map<String, bool> selected = {};
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
        if (selected[Database_Report.salespersons[i].id.toString()] == true) {
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
              color: MyColors.scarlet,
              size: MyScreen.getScreenHeight(context) * (30 / 1063.6)),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        title: Text("Select Employees To Analyse",
            style: TextStyle(
                color: MyColors.white,
                fontSize: MyScreen.getScreenHeight(context) * (20 / 1063.6))),
        centerTitle: true,
        backgroundColor: MyColors.richBlackFogra,
      ),
      backgroundColor: MyColors.richBlackFogra,
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Theme(
            data: ThemeData(
              unselectedWidgetColor: MyColors.scarlet,
            ),
            child: Column(
              children: [
                CheckboxListTile(
                  checkColor: MyColors.white,
                  activeColor: MyColors.scarlet,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text('Select All',
                      style: TextStyle(fontSize: 13, color: MyColors.white)),
                  value: selectAll,
                  onChanged: (value) {
                    setState(() {
                      selectAll = value!;
                      for (int i = 0;
                          i < Database_Report.salespersons.length;
                          i++) {
                        selected[Database_Report.salespersons[i].id
                            .toString()] = selectAll;
                      }
                    });
                  },
                ),
                Divider(
                  color: MyColors.white,
                  indent: 15,
                  endIndent: 15,
                  thickness: 1,
                ),
                ListView.builder(
                    padding: EdgeInsets.all(12),
                    shrinkWrap: true,
                    itemCount: Database_Report.salespersons.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: _row(index),
                      );
                    }),
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
                              color: MyColors.middleRed,
                            ),
                          ),
                        ),
                        Center(
                          child: Text("Generate Report",
                              style: TextStyle(
                                  color: MyColors.richBlackFogra,
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
            activeColor: MyColors.scarlet,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(
                Database_Report.salespersons[key].id.toString() +
                    "\t" +
                    Database_Report.salespersons[key].name.toString(),
                style: TextStyle(fontSize: 13, color: MyColors.white)),
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
