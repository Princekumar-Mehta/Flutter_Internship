import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_v3/Database/db_SignUp.dart';
import 'package:project_v3/Email/send_email.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';

class SignUpEmail extends StatefulWidget {
  const SignUpEmail({Key? key}) : super(key: key);

  @override
  _SignUpEmailState createState() => _SignUpEmailState();
}

class _SignUpEmailState extends State<SignUpEmail> {
  final _formKey = GlobalKey<FormBuilderState>();
  File? _pickedImage;
  bool _isObscure = true;
  bool _isObscure2 = true;
  String dropdownvalue = 'Select an Option';
  var items = [
    'Salesperson',
    'Regional Manager',
    'Area Manager',
    'General Manager',
  ];
  Future<void> showMessage(
    BuildContext context,
    String message,
  ) async {
    showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Alert'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('Okay'),
            onPressed: () async {
              Navigator.pop(c, false);
            },
          ),
        ],
      ),
    );
  }

  Future<void> showIdOtp(
    BuildContext context,
    String message,
    String email,
    int id,
    int otp,
  ) async {
    showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Alert'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('Okay'),
            onPressed: () async {
              Navigator.pop(c, false);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _pickedImage = File(pickedImageFile!.path);
    });
  }

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_formKey.currentState!.value['password_1'] !=
          _formKey.currentState!.value['password_2']) {
        showMessage(context, "Both Password Should match");
        return;
      }
      if (_pickedImage == null) {
        LoadImage();
      }
      String name = _formKey.currentState!.value['full_name'];
      String email = _formKey.currentState!.value['email'];
      String password = _formKey.currentState!.value['password_1'];
      String role = _formKey.currentState!.value['role'];
      await Database_signUp.addEmp(
        profile_pic: _pickedImage!.path,
        name: name,
        email: email,
        password: password,
        role: role,
        status: "Approved",
      );
      Employee? emp = await Database_signUp.getEmp(email: email, id: 0);
      int otp = 1000 + Random().nextInt(9999 - 1000);
      int? id = emp!.id;
      final emp_detials = emp.toMap();
      Send_Mail.send_mail(
          _formKey.currentState?.value['email'],
          "Name: " +
              emp_detials['name'] +
              "<br>" +
              "Employee ID: " +
              emp_detials['id'].toString() +
              "<br>" +
              "Email: " +
              emp_detials['email'] +
              "<br>"
                  "Password: " +
              emp_detials['password'] +
              "<br>"
                  "Role: " +
              emp_detials['role']);
      await showIdOtp(
          context,
          "Employee ID: " +
              emp.id.toString() +
              "\nCheck your Inbox and Spam folder $email",
          email,
          id!,
          otp);
    }
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/DIMS.png');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  Future<void> LoadImage() async {
    _pickedImage = await getImageFileFromAssets('images/DIMS.png');
    print(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    if (_pickedImage == null) {
      LoadImage();
    }
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: MyColors.scarlet, size: 30),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            backgroundColor: MyColors.richBlackFogra,
          ),
          backgroundColor: MyColors.richBlackFogra,
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                alignment: Alignment.center,
                child: Stack(children: [
                  FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                            height:
                                MyScreen.getScreenWidth(context) * (70 / 640)),
                        Stack(children: [
                          InkWell(
                            child: CircleAvatar(
                              radius:
                                  MyScreen.getScreenWidth(context) * (40 / 360),
                              backgroundImage: _pickedImage != null
                                  ? FileImage(_pickedImage!)
                                  : null,
                            ),
                            onTap: _pickImage,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 2,
                            child: Icon(Icons.add_circle,
                                color: Colors.white,
                                size: MyScreen.getScreenWidth(context) *
                                    (22 / 360)),
                          )
                        ]),
                        SizedBox(
                            height:
                                MyScreen.getScreenWidth(context) * (70 / 640)),
                        SizedBox(
                          width: MyScreen.getScreenWidth(context) * (228 / 294),
                          height:
                              MyScreen.getScreenHeight(context) * (30 / 1063.6),
                          child: Text("Full Name *",
                              style: TextStyle(
                                  color: MyColors.pewterBlue,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (20 / 1063.6))),
                        ),
                        SizedBox(
                          width: MyScreen.getScreenWidth(context) * (228 / 294),
                          height:
                              MyScreen.getScreenHeight(context) * (50 / 1063.6),
                          child: FormBuilderTextField(
                            name: 'full_name',
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MyColors.pewterBlue)),
                            ),
                            style: TextStyle(
                                color: MyColors.middleRed,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (25 / 1063.6)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Full Name";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                            height:
                                MyScreen.getScreenHeight(context) * (6 / 553)),
                        SizedBox(
                          width: MyScreen.getScreenWidth(context) * (228 / 294),
                          height:
                              MyScreen.getScreenHeight(context) * (30 / 1063.6),
                          child: Text("Email Address *",
                              style: TextStyle(
                                  color: MyColors.pewterBlue,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (20 / 1063.6))),
                        ),
                        SizedBox(
                          width: MyScreen.getScreenWidth(context) * (228 / 294),
                          height:
                              MyScreen.getScreenHeight(context) * (50 / 1063.6),
                          child: FormBuilderTextField(
                              name: 'email',
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyColors.pewterBlue)),
                              ),
                              style: TextStyle(
                                  color: MyColors.middleRed,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (25 / 1063.6)),
                              validator: (value) {
                                RegExp regexem = RegExp(
                                    r'^[a-z0-9!#$%&"*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&"*+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9][a-zA-Z0-9-]{0,253}\.)*[a-zA-Z0-9][a-zA-Z0-9-]{0,253}\.[a-zA-Z0-9]{2,}$');
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Email ID";
                                } else if (!regexem.hasMatch(value)) {
                                  return "Enter Proper Email ID";
                                }
                                return null;
                              }),
                        ),
                        SizedBox(
                            height:
                                MyScreen.getScreenHeight(context) * (6 / 553)),
                        SizedBox(
                            width:
                                MyScreen.getScreenWidth(context) * (228 / 294),
                            height: MyScreen.getScreenHeight(context) *
                                (30 / 1063.6),
                            child: Row(
                              children: [
                                Text("Password *",
                                    style: TextStyle(
                                        color: MyColors.pewterBlue,
                                        fontSize:
                                            MyScreen.getScreenHeight(context) *
                                                (20 / 1063.6))),
                              ],
                            )),
                        SizedBox(
                          width: MyScreen.getScreenWidth(context) * (228 / 294),
                          height:
                              MyScreen.getScreenHeight(context) * (50 / 1063.6),
                          child: FormBuilderTextField(
                            name: 'password_1',
                            obscureText: _isObscure,
                            style: TextStyle(
                                color: MyColors.middleRed,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (25 / 1063.6)),
                            validator: (value) {
                              RegExp regex = RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                              if (value == null || value.isEmpty) {
                                return "Please Enter Password";
                              } else if (!regex.hasMatch(value)) {
                                showMessage(context,
                                    "Password Error\n\nPassword Length must be at least 8 characters\nIt must contain atleast:\n1 Capital Letter\n1 Lower Letter\n1 Digit\n1 Special Character");
                                return "Enter Proper Password";
                                //return "Password Length must be at least 8 characters\nIt must contain atleast:\n1 Capital Letter\n1 Lower Letter\n1 Digit\n1 Special Character";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                padding: const EdgeInsets.only(bottom: 2.0),
                                icon: Icon(
                                    _isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: MyColors.pewterBlue,
                                    size: MyScreen.getScreenHeight(context) *
                                        (22 / 1063.6)),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MyColors.pewterBlue)),
                            ),
                          ),
                        ),
                        SizedBox(
                            height:
                                MyScreen.getScreenHeight(context) * (6 / 553)),
                        SizedBox(
                            width:
                                MyScreen.getScreenWidth(context) * (228 / 294),
                            height: MyScreen.getScreenHeight(context) *
                                (30 / 1063.6),
                            child: Row(
                              children: [
                                Text("Confirm Password *",
                                    style: TextStyle(
                                        color: MyColors.pewterBlue,
                                        fontSize:
                                            MyScreen.getScreenHeight(context) *
                                                (20 / 1063.6))),
                              ],
                            )),
                        SizedBox(
                          width: MyScreen.getScreenWidth(context) * (228 / 294),
                          height:
                              MyScreen.getScreenHeight(context) * (50 / 1063.6),
                          child: FormBuilderTextField(
                            name: 'password_2',
                            obscureText: _isObscure2,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                padding: const EdgeInsets.only(bottom: 2.0),
                                icon: Icon(
                                    _isObscure2
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: MyColors.pewterBlue,
                                    size: MyScreen.getScreenHeight(context) *
                                        (22 / 1063.6)),
                                onPressed: () {
                                  setState(() {
                                    _isObscure2 = !_isObscure2;
                                  });
                                },
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MyColors.pewterBlue)),
                            ),
                            style: TextStyle(
                                color: MyColors.middleRed,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (25 / 1063.6)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Confirm Password";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                            height:
                                MyScreen.getScreenHeight(context) * (6 / 553)),
                        SizedBox(
                          width: MyScreen.getScreenWidth(context) * (228 / 294),
                          height:
                              MyScreen.getScreenHeight(context) * (30 / 1063.6),
                          child: Text("Select Role *",
                              style: TextStyle(
                                  color: MyColors.pewterBlue,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (20 / 1063.6))),
                        ),
                        Stack(children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: MyColors.pewterBlue,
                                width: MyScreen.getScreenWidth(context) *
                                    (.75 / 294),
                              ),
                            ),
                            width:
                                MyScreen.getScreenWidth(context) * (228 / 294),
                            height: 60,
                            child: FormBuilderDropdown<String>(
                              name: 'role',
                              validator: (value) {
                                if (value.toString() == "Select an Option") {
                                  return "Please select a role";
                                }
                                return null;
                              },
                              dropdownColor: MyColors.richBlackFogra,
                              iconSize: MyScreen.getScreenHeight(context) *
                                  (35 / 1063.6),
                              isExpanded: true,
                              isDense: true,
                              iconDisabledColor: MyColors.pewterBlue,
                              iconEnabledColor: MyColors.pewterBlue,
                              icon: const Icon(Icons.arrow_drop_down),
                              style: TextStyle(color: MyColors.pewterBlue),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownvalue = newValue!;
                                });
                              },
                              items: <String>[
                                'Salesperson',
                                'Regional Manager',
                                'Area Manager',
                                'General Manager'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Center(
                                      child: Text(value,
                                          style: TextStyle(
                                              color: MyColors.pewterBlue,
                                              fontSize:
                                                  MyScreen.getScreenHeight(
                                                          context) *
                                                      (20 / 1063.6)))),
                                );
                              }).toList(),
                            ),
                          )
                        ]),
                        SizedBox(
                            height: MyScreen.getScreenHeight(context) *
                                (60 / 1063.6)),
                        SizedBox(
                          width: MyScreen.getScreenWidth(context) * (85 / 294),
                          height:
                              MyScreen.getScreenHeight(context) * (60 / 1063.6),
                          child: InkWell(
                            child: Stack(
                              children: [
                                Opacity(
                                  opacity: 0.8,
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          MyScreen.getScreenHeight(context) *
                                              (10 / 1063.6)),
                                      color: MyColors.middleRed,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text("Create Profile",
                                      style: TextStyle(
                                          color: MyColors.richBlackFogra,
                                          fontSize: MyScreen.getScreenHeight(
                                                  context) *
                                              (17 / 1063.6),
                                          fontWeight: FontWeight.bold)),
                                )
                              ],
                            ),
                            onTap: () => moveToHome(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          )),
    );
  }
}
