import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class viewOrder extends StatefulWidget {
  final File file;
  @override
  viewOrder({required this.file});

  @override
  State<viewOrder> createState() => _viewOrderState();
}

class _viewOrderState extends State<viewOrder> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: MyColors.scarlet,
                  size: MyScreen.getScreenHeight(context) * (30 / 1063.6)),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ),
          body: Column(children: [
            SizedBox(
              height: MyScreen.getScreenHeight(context) * (650 / 1063.6),
              width: MyScreen.getScreenWidth(context) * (490.9 / 490.9),
              child: SfPdfViewer.file((widget.file)),
            ),
          ]),
        ),
      );
  }
}
