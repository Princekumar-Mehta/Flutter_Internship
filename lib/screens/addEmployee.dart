import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_v3/Database/db_employee.dart';
import 'package:project_v3/Email/send_email.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/Extras/utility.dart';
import 'package:project_v3/Models/employee.dart';

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
              Navigator.pop(context);
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
      if (_pickedImage != null) {
        _pickedImage = File(pickedImageFile!.path);
      }
    });
  }

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String email = _formKey.currentState!.value['email'];
      if (!await Utility.isNotExist(email)) {
        showMessage(context, "User Already Exist");
        return;
      }
      if (_formKey.currentState!.value['password_1'] !=
          _formKey.currentState!.value['password_2']) {
        showMessage(context, "Both Password Should match");
        return;
      }
      if (_pickedImage == null) {
        LoadImage();
      }
      if (_formKey.currentState!.value['role'] == null) {
        showMessage(context, "Please Select Role");
        return;
      }
      String name = _formKey.currentState!.value['full_name'];
      String phone = _formKey.currentState!.value['phone'];
      String password = _formKey.currentState!.value['password_1'];
      String role = _formKey.currentState!.value['role'];
      String managerid = "2";
      print(_pickedImage!.path);
      await Database_signUp.addEmp(
        profile_pic: _pickedImage!.path,
        name: name,
        email: email,
        phone: phone,
        password: password,
        role: role,
        managerid: managerid,
        status: "Approved",
        darkTheme: 1,
      );
      Employee? emp = await Database_signUp.getEmp(email: email, id: 0);
      int otp = 1000 + Random().nextInt(9999 - 1000);
      int? id = emp!.id;

      final emp_detials = emp.toMap();
      Send_Mail.send_mail(
        _formKey.currentState?.value['email'],
        "Access Profile and Reset Your Password",
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
            emp_detials['role'] +
            "<br>",
      );
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
            shape: Border(
              bottom: BorderSide(
                color: MyColors.scarlet,
                width: MyScreen.getScreenHeight(context) * (4 / 1063.6),
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: MyDrawer.emp.darkTheme == 1
                      ? MyColors.white
                      : MyColors.scarlet,
                  size: MyScreen.getScreenHeight(context) * (30 / 1063.6)),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            title: Text("Create Employee",
                style: TextStyle(
                    color: MyDrawer.emp.darkTheme == 1
                        ? MyColors.white
                        : MyColors.scarlet,
                    fontSize:
                        MyScreen.getScreenHeight(context) * (20 / 1063.6))),
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
                        InkWell(
                            onTap: _pickImage,
                            child: Stack(children: [
                              CircleAvatar(
                                radius: MyScreen.getScreenWidth(context) *
                                    (40 / 360),
                                backgroundImage: _pickedImage != null
                                    ? FileImage(_pickedImage!)
                                    : null,
                              ),
                              Positioned(
                                bottom: 0,
                                right: 2,
                                child: Icon(Icons.add_circle,
                                    color: MyDrawer.emp.darkTheme == 1
                                        ? MyColors.white
                                        : MyColors.scarlet,
                                    size: MyScreen.getScreenWidth(context) *
                                        (22 / 360)),
                              )
                            ])),
                        SizedBox(
                            height:
                                MyScreen.getScreenWidth(context) * (70 / 640)),
                        SizedBox(
                          width: MyScreen.getScreenWidth(context) * (228 / 294),
                          height:
                              MyScreen.getScreenHeight(context) * (30 / 1063.6),
                          child: Text("Full Name *",
                              style: TextStyle(
                                  color: MyDrawer.emp.darkTheme == 1
                                      ? MyColors.pewterBlue
                                      : MyColors.black,
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
                                  borderSide: BorderSide(
                                color: MyDrawer.emp.darkTheme == 1
                                    ? MyColors.pewterBlue
                                    : MyColors.black,
                              )),
                            ),
                            style: TextStyle(
                                color: MyDrawer.emp.darkTheme == 1
                                    ? MyColors.middleRed
                                    : MyColors.scarlet,
                                fontSize: MyScreen.getScreenHeight(context) *
                                    (25 / 1063.6)),
                            validator: (value) {
                              RegExp regexname = RegExp(r'^[a-zA-Z]*$');
                              if (value == null || value.isEmpty) {
                                return "Please Enter Full Name";
                              } else if (!regexname.hasMatch(value)) {
                                return "Enter Proper Full Name";
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
                                  color: MyDrawer.emp.darkTheme == 1
                                      ? MyColors.pewterBlue
                                      : MyColors.black,
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
                                    borderSide: BorderSide(
                                  color: MyDrawer.emp.darkTheme == 1
                                      ? MyColors.pewterBlue
                                      : MyColors.black,
                                )),
                              ),
                              style: TextStyle(
                                  color: MyDrawer.emp.darkTheme == 1
                                      ? MyColors.middleRed
                                      : MyColors.scarlet,
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
                          width: MyScreen.getScreenWidth(context) * (228 / 294),
                          height:
                              MyScreen.getScreenHeight(context) * (30 / 1063.6),
                          child: Text("Mobile Number *",
                              style: TextStyle(
                                  color: MyDrawer.emp.darkTheme == 1
                                      ? MyColors.pewterBlue
                                      : MyColors.black,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (20 / 1063.6))),
                        ),
                        SizedBox(
                          width: MyScreen.getScreenWidth(context) * (228 / 294),
                          height:
                              MyScreen.getScreenHeight(context) * (50 / 1063.6),
                          child: FormBuilderTextField(
                              name: 'phone',
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: MyDrawer.emp.darkTheme == 1
                                      ? MyColors.pewterBlue
                                      : MyColors.black,
                                )),
                              ),
                              style: TextStyle(
                                  color: MyDrawer.emp.darkTheme == 1
                                      ? MyColors.middleRed
                                      : MyColors.scarlet,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (25 / 1063.6)),
                              validator: (value) {
                                RegExp regexem = RegExp(r'^[0-9]{10}$');
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Mobile Number";
                                } else if (!regexem.hasMatch(value)) {
                                  return "Enter Valid Mobile Number";
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
                                        color: MyDrawer.emp.darkTheme == 1
                                            ? MyColors.pewterBlue
                                            : MyColors.black,
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
                            initialValue: "Dims@123",
                            obscureText: _isObscure,
                            style: TextStyle(
                                color: MyDrawer.emp.darkTheme == 1
                                    ? MyColors.middleRed
                                    : MyColors.scarlet,
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
                                    color: MyDrawer.emp.darkTheme == 1
                                        ? MyColors.pewterBlue
                                        : MyColors.black,
                                    size: MyScreen.getScreenHeight(context) *
                                        (22 / 1063.6)),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: MyDrawer.emp.darkTheme == 1
                                    ? MyColors.pewterBlue
                                    : MyColors.black,
                              )),
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
                                        color: MyDrawer.emp.darkTheme == 1
                                            ? MyColors.pewterBlue
                                            : MyColors.black,
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
                            initialValue: "Dims@123",
                            obscureText: _isObscure2,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                padding: const EdgeInsets.only(bottom: 2.0),
                                icon: Icon(
                                    _isObscure2
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: MyDrawer.emp.darkTheme == 1
                                        ? MyColors.pewterBlue
                                        : MyColors.black,
                                    size: MyScreen.getScreenHeight(context) *
                                        (22 / 1063.6)),
                                onPressed: () {
                                  setState(() {
                                    _isObscure2 = !_isObscure2;
                                  });
                                },
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: MyDrawer.emp.darkTheme == 1
                                    ? MyColors.pewterBlue
                                    : MyColors.black,
                              )),
                            ),
                            style: TextStyle(
                                color: MyDrawer.emp.darkTheme == 1
                                    ? MyColors.middleRed
                                    : MyColors.scarlet,
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
                                  color: MyDrawer.emp.darkTheme == 1
                                      ? MyColors.pewterBlue
                                      : MyColors.black,
                                  fontSize: MyScreen.getScreenHeight(context) *
                                      (20 / 1063.6))),
                        ),
                        Stack(children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: MyDrawer.emp.darkTheme == 1
                                    ? MyColors.pewterBlue
                                    : MyColors.black,
                                width: MyScreen.getScreenWidth(context) *
                                    (.75 / 294),
                              ),
                            ),
                            width:
                                MyScreen.getScreenWidth(context) * (228 / 294),
                            height: 54,
                            child: FormBuilderDropdown<String>(
                              name: 'role',
                              dropdownColor: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.richBlackFogra
                                  : MyColors.white,
                              iconSize: MyScreen.getScreenHeight(context) *
                                  (35 / 1063.6),
                              isExpanded: true,
                              isDense: true,
                              iconDisabledColor: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.pewterBlue
                                  : MyColors.black,
                              iconEnabledColor: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.pewterBlue
                                  : MyColors.black,
                              icon: const Icon(Icons.arrow_drop_down),
                              style: TextStyle(
                                color: MyDrawer.emp.darkTheme == 1
                                    ? MyColors.pewterBlue
                                    : MyColors.black,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownvalue = newValue!;
                                });
                              },
                              items: <String>[
                                'Salesperson',
                                'Regional Manager',
                                'Area Manager',
                                'General Manager',
                                'Dealer'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Center(
                                      child: Text(value,
                                          style: TextStyle(
                                              color: MyDrawer.emp.darkTheme == 1
                                                  ? MyColors.pewterBlue
                                                  : MyColors.black,
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
                                      color: MyDrawer.emp.darkTheme == 1
                                          ? MyColors.middleRed
                                          : MyColors.scarlet,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text("Create Profile",
                                      style: TextStyle(
                                          color: MyDrawer.emp.darkTheme == 1
                                              ? MyColors.richBlackFogra
                                              : MyColors.white,
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
