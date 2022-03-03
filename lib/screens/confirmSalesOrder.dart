import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_v3/Database/db_final_individual_order.dart';
import 'package:project_v3/Database/db_final_order.dart';
import 'package:project_v3/Database/order.dart';
import 'package:project_v3/Email/send_email.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/pdf_signed_api.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class ConfirmOrder extends StatefulWidget {
  final Order order;
  final File file;
  @override
  ConfirmOrder({required this.order, required this.file});

  @override
  State<ConfirmOrder> createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  final keySignaturePad = GlobalKey<SfSignaturePadState>();

  void _handleClearButtonPressed() {
    keySignaturePad.currentState!.clear();
  }

  @override
  Widget build(BuildContext context) {
    widget.order.print_order();
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              SizedBox(
                height: MyScreen.getScreenHeight(context) * (650 / 1063.6),
                width: MyScreen.getScreenWidth(context) * (490.9 / 490.9),
                child: SfPdfViewer.file((widget.file)),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: MyColors.pewterBlue,
                          width: 1.0,
                        ),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Confirm Order and Sign Below",
                      style: TextStyle(
                        color: MyColors.black,
                        fontSize:
                            MyScreen.getScreenHeight(context) * (20 / 1063.6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    width: MyScreen.getScreenWidth(context) * (490.9 / 490.9),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: MyColors.pewterBlue,
                          width: 1.0,
                        ),
                      ),
                    ),
                    height: MyScreen.getScreenHeight(context) * (295 / 1063.6),
                    width: MyScreen.getScreenWidth(context) * (490.9 / 490.9),
                    child: SfSignaturePad(
                      key: keySignaturePad,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MyScreen.getScreenWidth(context) / 2,
                    color: MyColors.scarlet,
                    child: TextButton(
                        onPressed: onSubmit,
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              color: MyColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (16 / 1063.6)),
                        )),
                  ),
                  Container(
                    width: MyScreen.getScreenWidth(context) / 2,
                    color: MyColors.grullo,
                    child: TextButton(
                        onPressed: _handleClearButtonPressed,
                        child: Text(
                          "Clear",
                          style: TextStyle(
                              color: MyColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: MyScreen.getScreenHeight(context) *
                                  (16 / 1063.6)),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future onSubmit() async {
    final image = await keySignaturePad.currentState?.toImage();
    final imageSignature = await image!.toByteData(format: ImageByteFormat.png);
    final file = await PdfApi_Signed.generatePDF(
      order: widget.order,
      imageSignature: imageSignature!,
    );
    Send_Mail.send_mail(widget.order.billing_branch.branch_Email!,
        "Order Submitted", "Your order is Submitted",
        file: file, isFile: 1);
    Send_Mail.send_mail(widget.order.shipping_branch.branch_Email!,
        "Order Submitted", "Your order is Submitted",
        file: file, isFile: 1);
    widget.order.file_Address = file.path;
    widget.order.addToDatabase();
    Database_Final_Order().getFinalOrders();
    Database_Final_Individual_Order().getFinalIndividualOrders();
    Navigator.pop(context);

    // print(file.path);
  }
}
