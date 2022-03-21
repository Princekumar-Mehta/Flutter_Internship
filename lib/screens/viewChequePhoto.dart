import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';

class ViewChequePhoto extends StatefulWidget {
  final String chequePath;
  ViewChequePhoto({required this.chequePath});

  @override
  _ViewChequePhotoState createState() => _ViewChequePhotoState();
}

class _ViewChequePhotoState extends State<ViewChequePhoto> {
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
        title: Text("View Cheque Image",
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
      backgroundColor: MyDrawer.emp.darkTheme == 1
          ? MyColors.richBlackFogra
          : MyColors.white,
      body: Column(
        children: [
          Container(
            width: MyScreen.getScreenWidth(context),
            height: MyScreen.getScreenHeight(context) * (890 / 1063.6),
            color: MyColors.richBlackFogra,
            child: Image.file(File(widget.chequePath)),
          ),
        ],
      ),
    );
  }
}
