import 'package:flutter/material.dart';
import 'package:project_v3/Database/db_report.dart';
import 'package:project_v3/Email/send_email.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/Extras/pdf_report_api.dart';
import 'package:project_v3/screens/reportItemWise1.dart';
import 'package:project_v3/screens/reportSalesSalesPersonWise1.dart';
import 'package:project_v3/screens/viewOrderScreen.dart';

class ReportHome extends StatelessWidget {
  const ReportHome({Key? key}) : super(key: key);

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
        shape: Border(
          bottom: BorderSide(
            color: MyColors.scarlet,
            width: MyScreen.getScreenHeight(context) * (4 / 1063.6),
          ),
        ),
        title: Text("Report Home",
            style: TextStyle(
                color: MyDrawer.emp.darkTheme == 1
                    ? MyColors.white
                    : MyColors.scarlet,
                fontSize: MyScreen.getScreenHeight(context) * (20 / 1063.6))),
        centerTitle: true,
        backgroundColor: MyDrawer.emp.darkTheme == 1
            ? MyColors.richBlackFogra
            : MyColors.white,
      ),
      backgroundColor: MyDrawer.emp.darkTheme == 1
          ? MyColors.richBlackFogra
          : MyColors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: MyScreen.getScreenHeight(context) * (25 / 1063.6),
              ),
              Container(
                height: MyScreen.getScreenHeight(context) * (220 / 1063.6),
                padding: EdgeInsets.fromLTRB(
                    MyScreen.getScreenWidth(context) * (10 / 490.9),
                    MyScreen.getScreenHeight(context) * (5 / 1063.6),
                    MyScreen.getScreenWidth(context) * (10 / 490.9),
                    MyScreen.getScreenHeight(context) * (5 / 1063.6)),
                width: MyScreen.getScreenWidth(context) * (460 / 490.9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () async {
                        if (await Database_Report()
                            .getSalesperson_SalesReport()) {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ReportSalesSalespersonWise1(
                                        report_type: "sales",
                                      )));
                        }
                      },
                      child: Container(
                        height:
                            MyScreen.getScreenHeight(context) * (200 / 1063.6),
                        width: MyScreen.getScreenWidth(context) * (200 / 490.9),
                        decoration: BoxDecoration(
                          color: MyDrawer.emp.darkTheme == 1
                              ? MyColors.white
                              : MyColors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(
                              MyScreen.getScreenHeight(context) *
                                  (15 / 1063.6))),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MyScreen.getScreenHeight(context) *
                                  (40 / 1063.6),
                            ),
                            Icon(
                              Icons.bar_chart_outlined,
                              size: MyScreen.getScreenHeight(context) *
                                  (100 / 1063.6),
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.black
                                  : MyColors.scarlet,
                            ),
                            SizedBox(
                              height: MyScreen.getScreenHeight(context) *
                                  (20 / 1063.6),
                            ),
                            Text(
                              "Employee vs Sales",
                              style: TextStyle(
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (18 / 1063.6),
                                color: MyColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (20 / 490.9),
                    ),
                    InkWell(
                      onTap: () async {
                        if (await Database_Report().getItemWiseReport()) {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReportItemWise1(
                                        report_type: "quantity",
                                      )));
                        }
                      },
                      child: Container(
                        height:
                            MyScreen.getScreenHeight(context) * (200 / 1063.6),
                        width: MyScreen.getScreenWidth(context) * (200 / 490.9),
                        decoration: BoxDecoration(
                          color: MyDrawer.emp.darkTheme == 1
                              ? MyColors.white
                              : MyColors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(
                              MyScreen.getScreenHeight(context) *
                                  (15 / 1063.6))),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MyScreen.getScreenHeight(context) *
                                  (40 / 1063.6),
                            ),
                            Icon(
                              Icons.pie_chart_outlined,
                              size: MyScreen.getScreenHeight(context) *
                                  (100 / 1063.6),
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.black
                                  : MyColors.scarlet,
                            ),
                            SizedBox(
                              height: MyScreen.getScreenHeight(context) *
                                  (20 / 1063.6),
                            ),
                            Text(
                              "Item vs Quantity",
                              style: TextStyle(
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (18 / 1063.6),
                                color: MyColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MyScreen.getScreenHeight(context) * (18 / 1063.6),
              ),
              Container(
                height: MyScreen.getScreenHeight(context) * (220 / 1063.6),
                padding: EdgeInsets.fromLTRB(
                    MyScreen.getScreenWidth(context) * (10 / 490.9),
                    MyScreen.getScreenHeight(context) * (5 / 1063.6),
                    MyScreen.getScreenWidth(context) * (10 / 490.9),
                    MyScreen.getScreenHeight(context) * (5 / 1063.6)),
                width: MyScreen.getScreenWidth(context) * (460 / 490.9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () async {
                        if (await Database_Report()
                            .getSalesperson_HoursReport()) {
                          /* for (int i = 0;
                              i < Database_Report.hours_salesperson_wise.length;
                              i++) {
                            print(Database_Report.hours_salesperson_wise);
                          }*/
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ReportSalesSalespersonWise1(
                                        report_type: "hours",
                                      )));
                        }
                      },
                      child: Container(
                        height:
                            MyScreen.getScreenHeight(context) * (200 / 1063.6),
                        width: MyScreen.getScreenWidth(context) * (200 / 490.9),
                        decoration: BoxDecoration(
                          color: MyDrawer.emp.darkTheme == 1
                              ? MyColors.white
                              : MyColors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(
                              MyScreen.getScreenHeight(context) *
                                  (15 / 1063.6))),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MyScreen.getScreenHeight(context) *
                                  (40 / 1063.6),
                            ),
                            Icon(
                              Icons.bar_chart_outlined,
                              size: MyScreen.getScreenHeight(context) *
                                  (100 / 1063.6),
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.black
                                  : MyColors.scarlet,
                            ),
                            SizedBox(
                              height: MyScreen.getScreenHeight(context) *
                                  (20 / 1063.6),
                            ),
                            Text(
                              "Employee vs Hours",
                              style: TextStyle(
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (18 / 1063.6),
                                color: MyColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (20 / 490.9),
                    ),
                    InkWell(
                      onTap: () async {
                        if (await Database_Report()
                            .getItemWiseRevenueReport()) {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReportItemWise1(
                                        report_type: "revenue",
                                      )));
                        }
                      },
                      child: Container(
                        height:
                            MyScreen.getScreenHeight(context) * (200 / 1063.6),
                        width: MyScreen.getScreenWidth(context) * (200 / 490.9),
                        decoration: BoxDecoration(
                          color: MyDrawer.emp.darkTheme == 1
                              ? MyColors.white
                              : MyColors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(
                              MyScreen.getScreenHeight(context) *
                                  (15 / 1063.6))),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MyScreen.getScreenHeight(context) *
                                  (40 / 1063.6),
                            ),
                            Icon(
                              Icons.pie_chart_outlined,
                              size: MyScreen.getScreenHeight(context) *
                                  (100 / 1063.6),
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.black
                                  : MyColors.scarlet,
                            ),
                            SizedBox(
                              height: MyScreen.getScreenHeight(context) *
                                  (20 / 1063.6),
                            ),
                            Text(
                              "Item vs Revenue",
                              style: TextStyle(
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (18 / 1063.6),
                                color: MyColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MyScreen.getScreenHeight(context) * (18 / 1063.6),
              ),
              Container(
                height: MyScreen.getScreenHeight(context) * (220 / 1063.6),
                padding: EdgeInsets.fromLTRB(
                    MyScreen.getScreenWidth(context) * (10 / 490.9),
                    MyScreen.getScreenHeight(context) * (5 / 1063.6),
                    MyScreen.getScreenWidth(context) * (10 / 490.9),
                    MyScreen.getScreenHeight(context) * (5 / 1063.6)),
                width: MyScreen.getScreenWidth(context) * (460 / 490.9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () async {
                        if (await Database_Report()
                            .getSalesperson_DownloadReport()) {
                          final file = await PdfApi_Report.generatePDF(
                              report_type: 'employee');
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => viewOrder(file: file)));
                          Send_Mail.send_mail(
                              MyDrawer.emp.email!,
                              "Employee Report Generated",
                              "Your employee report has been generated. Please see the attachment for further details. \nThank you",
                              file: file,
                              isFile: 1);
                          //print("DONE");
                        }
                      },
                      child: Container(
                        height:
                            MyScreen.getScreenHeight(context) * (200 / 1063.6),
                        width: MyScreen.getScreenWidth(context) * (200 / 490.9),
                        decoration: BoxDecoration(
                          color: MyDrawer.emp.darkTheme == 1
                              ? MyColors.white
                              : MyColors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(
                              MyScreen.getScreenHeight(context) *
                                  (15 / 1063.6))),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MyScreen.getScreenHeight(context) *
                                  (40 / 1063.6),
                            ),
                            Icon(
                              Icons.table_chart_outlined,
                              size: MyScreen.getScreenHeight(context) *
                                  (100 / 1063.6),
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.black
                                  : MyColors.scarlet,
                            ),
                            SizedBox(
                              height: MyScreen.getScreenHeight(context) *
                                  (20 / 1063.6),
                            ),
                            Text(
                              "Export Employee Report",
                              style: TextStyle(
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (18 / 1063.6),
                                color: MyColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MyScreen.getScreenWidth(context) * (20 / 490.9),
                    ),
                    InkWell(
                      onTap: () async {
                        if (await Database_Report()
                            .getItemWiseDownloadReport()) {
                          final file = await PdfApi_Report.generatePDF(
                              report_type: 'item');
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => viewOrder(file: file)));
                          Send_Mail.send_mail(
                              MyDrawer.emp.email!,
                              "Item Report Generated",
                              "Your item report has been generated. Please see the attachment for further details. \nThank you",
                              file: file,
                              isFile: 1);
                          //print("DONE");
                        }
                      },
                      child: Container(
                        height:
                            MyScreen.getScreenHeight(context) * (200 / 1063.6),
                        width: MyScreen.getScreenWidth(context) * (200 / 490.9),
                        decoration: BoxDecoration(
                          color: MyDrawer.emp.darkTheme == 1
                              ? MyColors.white
                              : MyColors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(
                              MyScreen.getScreenHeight(context) *
                                  (15 / 1063.6))),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MyScreen.getScreenHeight(context) *
                                  (40 / 1063.6),
                            ),
                            Icon(
                              Icons.table_chart_outlined,
                              size: MyScreen.getScreenHeight(context) *
                                  (100 / 1063.6),
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.black
                                  : MyColors.scarlet,
                            ),
                            SizedBox(
                              height: MyScreen.getScreenHeight(context) *
                                  (20 / 1063.6),
                            ),
                            Text(
                              "Export Item Report",
                              style: TextStyle(
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (18 / 1063.6),
                                color: MyColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
