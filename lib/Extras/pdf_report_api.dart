import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_v3/Database/db_report.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfApi_Report {
  static Future<File> generatePDF({
    required String report_type,
  }) async {
    final document = PdfDocument();
    final page = document.pages.add();

    drawGrid(page, report_type);
    drawCompanyDetails(page, report_type);
    return saveFile(document);
  }

  static void drawGrid(PdfPage page, String report_type) {
    final grid = PdfGrid();
    grid.columns.add(count: 5);

    final headerRow = grid.headers.add(1)[0];
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.cells[0].value = 'Sr No.';
    headerRow.cells[1].value =
        report_type == "employee" ? 'Employee ID' : 'Item Code';
    headerRow.cells[2].value =
        report_type == "employee" ? 'Employee Name' : 'Item Name';
    headerRow.cells[3].value =
        report_type == "employee" ? 'Average Hours' : 'Item Sales (Packets)';
    headerRow.cells[4].value =
        report_type == "employee" ? 'Sales (Rupees)' : 'Item Sales (Revenue)';
    headerRow.style.font =
        PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold);
    int length = report_type == "employee"
        ? Database_Report.salespersons.length
        : Database_Report.items.length;
    //print(length);
    for (int i = 0; i < length; i++) {
      final row = grid.rows.add();
      // print(Database_Report.items[i].code.toString());
      // print(Database_Report.items[i].item_Name);
      // print(Database_Report.sales_in_packet[i].toString());
      // print(Database_Report.sales_in_revenue[i].toString());
      // print(Database_Report.salespersons[i].id);
      // print(Database_Report.salespersons[i].name);
      // print(Database_Report.hours_salesperson_wise[i]);
      // print(Database_Report.sales_salesperson_wise[i]);
      row.cells[0].value = (i + 1).toString();
      row.cells[1].value = report_type == "employee"
          ? Database_Report.salespersons[i].id.toString()
          : Database_Report.items[i].code.toString();
      row.cells[2].value = report_type == "employee"
          ? Database_Report.salespersons[i].name
          : Database_Report.items[i].item_Name;
      row.cells[3].value = report_type == "employee"
          ? Database_Report.hours_salesperson_wise[i].toString()
          : Database_Report.sales_in_packet[i].toString();
      row.cells[4].value = report_type == "employee"
          ? Database_Report.sales_salesperson_wise[i].toString()
          : Database_Report.sales_in_revenue[i].toString();
    }

    grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);

    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }

    for (int i = 0; i < grid.rows.count; i++) {
      final row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final cell = row.cells[j];
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }
    grid.draw(
      page: page,
      bounds: Rect.fromLTWH(0, 130, 0, 0),
    )!;
  }

  static void drawCompanyDetails(PdfPage page, String report_type) {
    final now = DateFormat.yMMMEd().format(DateTime.now());
    final companyText = '''
    Balaji Wafers Private Limited,
    Survey No.19, Vajdi (Vad),
    Kalawad Road, Ta. Lodhika,
    Dist. Rajkot - 360021,

    State : Gujarat (India)

    ''';

    String timeText = "Date: " + now;

    PdfFont font =
        PdfStandardFont(PdfFontFamily.helvetica, 12, style: PdfFontStyle.bold);

    PdfTextElement(
            text: companyText,
            font: font,
            format: PdfStringFormat(alignment: PdfTextAlignment.left))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 0, page.getClientSize().width / 2,
                page.getClientSize().height / 2));

    PdfTextElement(
            text: timeText,
            font: font,
            format: PdfStringFormat(alignment: PdfTextAlignment.right))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                page.getClientSize().width / 2,
                0,
                page.getClientSize().width / 2,
                page.getClientSize().height / 2));

    page.graphics.drawLine(
        PdfPen(PdfColor(0, 0, 0), width: 2), Offset(0, 100), Offset(762, 100));

    PdfTextElement(
            text: report_type == "employee" ? "Employee Report" : "Item Report",
            font: font,
            format: PdfStringFormat(alignment: PdfTextAlignment.left))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                (page.getClientSize().width / 2) - 40,
                110,
                page.getClientSize().width / 2,
                page.getClientSize().height / 2));
  }

  static Future<File> saveFile(PdfDocument document) async {
    final path = await getApplicationDocumentsDirectory();
    // Might have replace path for above method

    final fileName =
        path.path + '/Report${DateTime.now().toIso8601String()}.pdf';
    final file = File(fileName);
    print("path for report: " + file.path);

    file.writeAsBytes(document.save());
    document.dispose();

    return file;
  }
}
