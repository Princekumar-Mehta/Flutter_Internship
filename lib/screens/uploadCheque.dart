import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_v3/Database/db_approveOrders.dart';
import 'package:project_v3/Email/send_email.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';

import '../Extras/routes.dart';

class UploadChequePhoto extends StatefulWidget {
  int order_id;
  UploadChequePhoto({required this.order_id});

  @override
  _UploadChequePhotoState createState() => _UploadChequePhotoState();
}

class _UploadChequePhotoState extends State<UploadChequePhoto> {
  File? _pickedImage;
  Future<void> _pickImage() async {
    final pickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _pickedImage = File(pickedImageFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: MyColors.white,
              size: MyScreen.getScreenHeight(context) * (30 / 1063.6)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Upload Cheque Image",
            style: TextStyle(
                color: MyColors.white,
                fontSize: MyScreen.getScreenHeight(context) * (20 / 1063.6))),
        centerTitle: true,
        shape: Border(
          bottom: BorderSide(
            color: MyColors.scarlet,
            width: MyScreen.getScreenHeight(context) * (4 / 1063.6),
          ),
        ),
        backgroundColor: MyColors.richBlackFogra,
      ),
      backgroundColor: MyColors.richBlackFogra,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MyScreen.getScreenWidth(context),
              height: MyScreen.getScreenHeight(context) * (890 / 1063.6),
              color: MyColors.richBlackFogra,
              child: _pickedImage == null
                  ? Center(
                      child: Text(
                        "Upload Image to View",
                        style: TextStyle(
                          color: MyColors.pewterBlue,
                        ),
                      ),
                    )
                  : Image.file(File(_pickedImage!.path)),
            ),
            _pickedImage == null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _pickImage();
                        },
                        child: const Text("Upload Image"),
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _pickedImage = null;
                          });
                        },
                        child: const Text("Reset Image"),
                      ),
                      _pickedImage == null
                          ? Container()
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: MyColors.scarlet,
                              ),
                              onPressed: () async {
                                print(_pickedImage!.path);
                                if (await Database_ApproveOrders()
                                    .FulfilledOrder(
                                        widget.order_id, _pickedImage!.path)) {
                                  Send_Mail.send_mail(
                                      Database_ApproveOrders
                                          .customers[widget.order_id].email!,
                                      "Order Delivered",
                                      "Your Order has been delivered");
                                  Navigator.pop(context);
                                  var _processingOrders =
                                      Database_ApproveOrders();
                                  if (await _processingOrders
                                      .getProcessingOrders(MyDrawer.emp.id!,
                                          MyDrawer.emp.role!)) {
                                    Navigator.pushReplacementNamed(
                                        context, MyRoutes.MyProcessingOrders);
                                  }
                                }
                              },
                              child: const Text("Proceed"),
                            ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
