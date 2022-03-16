import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class ReportItemWise2 extends StatefulWidget {
  Map<String, double> dataMap;
  ReportItemWise2({required this.dataMap});
  @override
  State<ReportItemWise2> createState() => _ReportItemWise2State();
}

class _ReportItemWise2State extends State<ReportItemWise2> {
  List<Color> colorList = [
    const Color(0xff5ca55f),
    const Color(0xff3EE094),
    const Color(0xff3398F6),
    const Color(0xffFA4A42),
    const Color(0xffFE9539),
    const Color(0xff4039fe),
    const Color(0xff85fe39),
    const Color(0xfff139fe),
  ];
  @override
  void initState() {
    super.initState();
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
