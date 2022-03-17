import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';

class UploadChequePhoto extends StatefulWidget {
  const UploadChequePhoto({Key? key}) : super(key: key);

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
    return Column(
      children: [
        Container(
          width: MyScreen.getScreenWidth(context) * (50 / 490.9),
          height: MyScreen.getScreenWidth(context) * (50 / 490.9),
          color: MyColors.richBlackFogra,
          child: Image.file(File(_pickedImage!.path)),
        ),
        ElevatedButton(
          onPressed: () {
            _pickImage();
          },
          child: Text("Upload Image"),
        )
      ],
    );
  }
}
