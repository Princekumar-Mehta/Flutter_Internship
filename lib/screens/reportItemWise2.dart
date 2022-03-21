import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';

class ReportItemWise2 extends StatefulWidget {
  Map<String, double> dataMap;
  ReportItemWise2({required this.dataMap});
  @override
  State<ReportItemWise2> createState() => _ReportItemWise2State();
}

class _ReportItemWise2State extends State<ReportItemWise2> {
  List<Color> colorList = [
    const Color(0xFF8DA0CB),
    const Color(0xFFE78AC3),
    const Color(0xFFA6D853),
    const Color(0xFFFFD930),
    const Color(0xFFE4C493),
    const Color(0xFFB3B3B3),
    const Color(0xFF65C2A5),
    const Color(0xFFFC8D62),
  ];
  @override
  void initState() {
    super.initState();
  }

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
        title: Text("Pie Chart Example",
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
      body: Center(
        child: PieChart(
          dataMap: widget.dataMap,
          colorList: colorList,
          chartRadius: MediaQuery.of(context).size.width / 2,
          centerText: "Sales",
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
          //   gradientList: gradientList,
        ),
      ),
    );
  }
}
