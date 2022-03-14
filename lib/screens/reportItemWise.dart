import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class ReportItemWise extends StatefulWidget {
  const ReportItemWise({Key? key}) : super(key: key);

  @override
  State<ReportItemWise> createState() => _ReportItemWiseState();
}

class _ReportItemWiseState extends State<ReportItemWise> {
  Map<String, double> dataMap = {
    "Food Items": 18.47,
    "Clothes": 17.70,
    "Technology": 4.25,
    "Cosmetics": 3.51,
    "Other": 2.83,
  };

  List<Color> colorList = [
    const Color(0xffD95AF3),
    const Color(0xff3EE094),
    const Color(0xff3398F6),
    const Color(0xffFA4A42),
    const Color(0xffFE9539)
  ];

  final gradientList = <List<Color>>[
    [
      Color.fromRGBO(223, 250, 92, 1),
      Color.fromRGBO(129, 250, 112, 1),
    ],
    [
      Color.fromRGBO(129, 182, 205, 1),
      Color.fromRGBO(91, 253, 199, 1),
    ],
    [
      Color.fromRGBO(175, 63, 62, 1.0),
      Color.fromRGBO(254, 154, 92, 1),
    ]
  ];
  @override
  void initState() {
    super.initState();
    // dataMap = {
    //   for (int i = 0; i < Database_Report.items.length; i++)
    //     Database_Report.items[i].item_Name.toString():
    //         double.parse(Database_Report.sales_in_packet[i].toString())
    // };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Pie Chart example"),
      ),
      body: Center(
        child: PieChart(
          dataMap: dataMap,
          colorList: colorList,
          chartRadius: MediaQuery.of(context).size.width / 2,
          centerText: "Budget",
          ringStrokeWidth: 24,
          animationDuration: const Duration(seconds: 3),
          chartValuesOptions: const ChartValuesOptions(
              showChartValues: true,
              showChartValuesOutside: true,
              showChartValuesInPercentage: true,
              showChartValueBackground: false),
          legendOptions: const LegendOptions(
              showLegends: true,
              legendShape: BoxShape.rectangle,
              legendTextStyle: TextStyle(fontSize: 15),
              legendPosition: LegendPosition.bottom,
              showLegendsInRow: true),
          gradientList: gradientList,
        ),
      ),
    );
  }
}
