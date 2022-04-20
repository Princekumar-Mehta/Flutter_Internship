import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_v3/Models/order.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfApi {
  static Future<File> generatePDF({
    required Order order,
    required ByteData imageSignature,
  }) async {
    // order.print_order();
    /*print(order.item_name![0].getValue().toString());
    print(order.netWeight![0].text.toString());
    print(order.counter);*/
    final document = PdfDocument();
    final page = document.pages.add();

    drawGrid(page, order);
    drawCompanyDetails(page, order);
    drawSignature(page, imageSignature);
    return saveFile(document);
  }

  static void drawGrid(PdfPage page, Order order) {
    final grid = PdfGrid();
    grid.columns.add(count: 12);

    final headerRow = grid.headers.add(1)[0];
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.cells[0].value = 'Sr No.';
    headerRow.cells[1].value = 'Item Code';
    headerRow.cells[2].value = 'Item Name';
    headerRow.cells[3].value = 'HSN Code';
    headerRow.cells[4].value = 'Price';
    headerRow.cells[5].value = 'Packet';
    headerRow.cells[6].value = 'Patti';
    headerRow.cells[7].value = 'Box';
    headerRow.cells[8].value = 'Total Quantity';
    headerRow.cells[9].value = 'SubTotal';
    headerRow.cells[10].value = 'Tax';
    headerRow.cells[11].value = 'Total';
    headerRow.style.font =
        PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold);

    for (int i = 0; i < order.counter!.toInt(); i++) {
      final row = grid.rows.add();

      row.cells[0].value = (i + 1).toString();
      row.cells[1].value = order.item_detials[i].code.toString();
      row.cells[2].value = order.item_name![i].getValue().toString();
      row.cells[3].value = order.item_detials[i].hsn_Code.toString();
      row.cells[4].value = order.item_detials[i].price.toString();
      row.cells[5].value = order.packet![i].text.toString();
      row.cells[6].value = order.patti![i].text.toString();
      row.cells[7].value = order.box![i].text.toString();
      row.cells[8].value = order.totalItem![i].text.toString();
      row.cells[9].value = order.subTotal![i].text.toString();
      row.cells[10].value = order.tax![i].text.toString();
      row.cells[11].value = order.total![i].text.toString();
    }

    /*final row1 = grid.rows.add();
    row1.cells[0].value = '1';
    row1.cells[1].value = 'I4578';
    row1.cells[2].value = 'Simply Salted';
    row1.cells[3].value = '19059090';
    row1.cells[4].value = '10';
    row1.cells[5].value = '1';
    row1.cells[6].value = '5';
    row1.cells[7].value = '10';
    row1.cells[8].value = '210';
    row1.cells[9].value = '5067.30';
    row1.cells[10].value = '609.00';
    row1.cells[11].value = '5676.30';

    final row2 = grid.rows.add();
    row2.cells[0].value = '2';
    row2.cells[1].value = 'I4356';
    row2.cells[2].value = 'Masala Masti';
    row2.cells[3].value = '19059090';
    row2.cells[4].value = '10';
    row2.cells[5].value = '1';
    row2.cells[6].value = '5';
    row2.cells[7].value = '10';
    row2.cells[8].value = '210';
    row2.cells[9].value = '5067.30';
    row2.cells[10].value = '609.00';
    row2.cells[11].value = '5676.30';

    final row3 = grid.rows.add();
    row3.cells[0].value = '3';
    row3.cells[1].value = 'I4402';
    row3.cells[2].value = 'Cream & Onion';
    row3.cells[3].value = '19059090';
    row3.cells[4].value = '10';
    row3.cells[5].value = '1';
    row3.cells[6].value = '5';
    row3.cells[7].value = '10';
    row3.cells[8].value = '210';
    row3.cells[9].value = '5067.30';
    row3.cells[10].value = '609.00';
    row3.cells[11].value = '5676.30';*/

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
      bounds: Rect.fromLTWH(0, 330, 0, 0),
    )!;
  }

  static void drawCompanyDetails(PdfPage page, Order order) {
    String orderbillbranch = "Bill To: \n\n" +
        order.billing_branch.branch_Name! +
        "\n" +
        order.billing_branch.address1!.substring(0, 35) +
        "\n" +
        order.billing_branch.address1!.substring(
          35,
        ) +
        /* "\n" +
        order.billing_branch.address2!.substring(0, 35) +
        "\n" +
        order.billing_branch.address2!.substring(
          35,
        ) +*/
        "\n" +
        order.billing_branch.city! +
        ", " +
        order.billing_branch.state! +
        ",\n" +
        order.billing_branch.country! +
        ", " +
        order.billing_branch.post_Code!.toString() +
        "\n" +
        "GST Number: " +
        order.billing_branch.gstin!.toString() +
        "\n\n" +
        "Contact Person: " +
        order.billing_branch.contact_Person! +
        "\n" +
        "Phone: " +
        order.billing_branch.branch_Phone!.toString() +
        "\n" +
        "Email: " +
        order.billing_branch.branch_Email! +
        "\n";

    String ordershipbranch = "Ship To: \n\n" +
        order.shipping_branch.branch_Name! +
        "\n" +
        order.shipping_branch.address1!.substring(0, 35) +
        "\n" +
        order.shipping_branch.address1!.substring(
          35,
        ) +
        "\n" +
        /* order.shipping_branch.address2!.substring(0, 35) +
        "\n" +
        order.shipping_branch.address2!.substring(
          35,
        ) +
        "\n" +*/
        order.shipping_branch.city! +
        ", " +
        order.shipping_branch.state! +
        ",\n" +
        order.shipping_branch.country! +
        ", " +
        order.shipping_branch.post_Code!.toString() +
        "\n" +
        "GST Number: " +
        order.shipping_branch.gstin!.toString() +
        "\n\n" +
        "Contact Person: " +
        order.shipping_branch.contact_Person! +
        "\n" +
        "Phone: " +
        order.shipping_branch.branch_Phone!.toString() +
        "\n" +
        "Email: " +
        order.shipping_branch.branch_Email! +
        "\n";

    final now = DateFormat.yMMMEd().format(DateTime.now());
    final orderid = "12323";
    final companyText = '''
    Balaji Wafers Private Limited,
    Survey No.19, Vajdi (Vad), 
    Kalawad Road, Ta. Lodhika, 
    Dist. Rajkot - 360021, 
    
    State : Gujarat (India)
    
    ''';

    /*final billingText = '''
    Bill To:

    Gota Kirana Store,
    Survey No.19, Vajdi (Vad),
    Kalawad Road, Ta. Lodhika,
    Dist. Rajkot - 360021,

    State : Gujarat (India)

    ''';

    final shippingText = '''
    Ship To:

    Balaji Wafers Private Limited,
    Survey No.19, Vajdi (Vad),
    Kalawad Road, Ta. Lodhika,
    Dist. Rajkot - 360021,

    State : Gujarat (India)

    ''';*/

    String timeText = "Date: " +
        now +
        "\n" +
        "Invoice Number: " +
        orderid +
        "\n" +
        "Employee Id: " +
        order.salesPerson.id!.toString() +
        "\n" +
        "Total: " +
        order.final_total.toString() +
        "\n" +
        "Signature of Retailer: ";

    PdfFont font =
        PdfStandardFont(PdfFontFamily.helvetica, 12, style: PdfFontStyle.bold);
    PdfFont font2 = PdfStandardFont(PdfFontFamily.helvetica, 12);

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
            format: PdfStringFormat(alignment: PdfTextAlignment.left))
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
            text: orderbillbranch,
            font: font2,
            format: PdfStringFormat(alignment: PdfTextAlignment.left))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(10, 110, page.getClientSize().width / 2,
                page.getClientSize().height / 2));

    PdfTextElement(
            text: ordershipbranch,
            font: font2,
            format: PdfStringFormat(alignment: PdfTextAlignment.left))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(260, 110, page.getClientSize().width / 2,
                page.getClientSize().height / 2));

    page.graphics.drawLine(
        PdfPen(PdfColor(0, 0, 0), width: 2), Offset(0, 320), Offset(762, 320));
  }

  static void drawSignature(PdfPage page, ByteData imageSignature) {
    final pageSize = page.getClientSize();
    final PdfBitmap image = PdfBitmap(imageSignature.buffer.asUint8List());

    page.graphics
        .drawImage(image, Rect.fromLTWH(pageSize.width - 110, 55, 100, 40));
  }

  static Future<File> saveFile(PdfDocument document) async {
    final path = await getApplicationDocumentsDirectory();
    // Might have replace path for above method

    final fileName =
        path.path + '/Invoice${DateTime.now().toIso8601String()}.pdf';
    final file = File(fileName);
    print("path for file " + file.path);

    file.writeAsBytes(document.save());
    document.dispose();

    return file;
  }
}
