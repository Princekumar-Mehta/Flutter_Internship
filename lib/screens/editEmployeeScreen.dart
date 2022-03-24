import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_v3/Database/db_Employee.dart';
import 'package:project_v3/Email/send_email.dart';
import 'package:project_v3/Extras/myColors.dart';
import 'package:project_v3/Extras/myScreen.dart';
import 'package:project_v3/Extras/mydrawer.dart';
import 'package:project_v3/Extras/utility.dart';
import 'package:project_v3/Models/employee.dart';

import '../Extras/routes.dart';
import 'otpVerificationScreen.dart';

class EditEmployeeScreen extends StatefulWidget {
  Employee emp;
  EditEmployeeScreen({required this.emp});
  @override
  _EditEmployeeScreenState createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  File? _pickedImage;
  bool _isObscure = true;
  bool _isObscure2 = true;
  String dropdownvalue = 'Select an Option';

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
              Navigator.pop(context);
              var _db_employee = Database_signUp();
              if (await _db_employee.getAllEmp()) {
                print(Database_signUp.emps);
                Navigator.pushNamed(context, MyRoutes.MyEditEmployeeScreen);
              }
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

  Future<void> confirmationDialog(
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
            child: const Text('No'),
            onPressed: () async {
              Navigator.pop(c, false);
            },
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () async {
              Navigator.pop(c, false);
              // MyDrawer.emp = widget.emp;
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String email = _formKey.currentState!.value['email'];
      if (_formKey.currentState!.value['password_1'] !=
          _formKey.currentState!.value['password_2']) {
        Utility.showMessage(context, "Both Password Should match");
        return;
      }
      if (_pickedImage == null) {
        LoadImage();
      }
      widget.emp.name = _formKey.currentState!.value['full_name'];
      //widget.emp.email = _formKey.currentState!.value['email'];
      widget.emp.password = _formKey.currentState!.value['password_1'];
      widget.emp.role = _formKey.currentState!.value['role'];
      widget.emp.profile_pic = _pickedImage!.path;
      await Database_signUp().updateEmp(widget.emp);
      setState(() {});
      Employee? emp = await Database_signUp.getEmp(
          email: widget.emp.email.toString(), id: 0);
      if (MyDrawer.emp.id == emp!.id!) {
        MyDrawer.emp = emp;
      }
      print(email);
      if (widget.emp.email != email) {
        int otp = 1000 + Random().nextInt(9999 - 1000);
        Send_Mail.send_mail(
            email, "OTP For Verification", "OTP is: " + otp.toString());
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtpVerificationScreen(
                      email: email,
                      otp: otp,
                      old_email: widget.emp.email!,
                      previous: "edit employee",
                    )));
      } else {
        int? id = emp.id;
        final emp_detials = emp.toMap();
        Send_Mail.send_mail(
          _formKey.currentState?.value['email'],
          "Profile Updated",
          "If you did not perform the changes we recommend resetting your password.<br>Name: " +
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
        if (MyDrawer.emp.role.toString() == "Admin") {
          Navigator.pop(context);
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
        }
        Utility.showMessage(context, "Profile Updated");
      }
    }
  }

  Future<void> LoadImage() async {
    _pickedImage = File(widget.emp.profile_pic!);
    print(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.emp.role);
    if (_pickedImage == null) {
      LoadImage();
    }
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: MyDrawer.emp.darkTheme == 1
                    ? MyColors.white
                    : MyColors.scarlet,
                size: MyScreen.getScreenHeight(context) * (30 / 1063.6)),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                if (MyDrawer.emp.name.toString() !=
                        _formKey.currentState!.value['full_name'] ||
                    MyDrawer.emp.email.toString() !=
                        _formKey.currentState!.value['email'] ||
                    MyDrawer.emp.password.toString() !=
                        _formKey.currentState!.value['password_1'] ||
                    MyDrawer.emp.role.toString() !=
                        _formKey.currentState!.value['role'] ||
                    MyDrawer.emp.profile_pic.toString() != _pickedImage!.path) {
                  confirmationDialog(context,
                      "Exit to Home Page?\n\nChanges will not be saved.");
                } else {
                  Navigator.pop(context);
                }
              }
            },
          ),
          shape: Border(
            bottom: BorderSide(
              color: MyColors.scarlet,
              width: MyScreen.getScreenHeight(context) * (4 / 1063.6),
            ),
          ),
          title: Text("Edit Employee Details",
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
                              color: MyDrawer.emp.darkTheme == 1
                                  ? MyColors.white
                                  : MyColors.scarlet,
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
                          initialValue: widget.emp.name,
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
                            initialValue: widget.emp.email,
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
                          initialValue: widget.emp.password,
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
                              Utility.showMessage(context,
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
                          width: MyScreen.getScreenWidth(context) * (228 / 294),
                          height:
                              MyScreen.getScreenHeight(context) * (30 / 1063.6),
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
                          initialValue: widget.emp.password,
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
                      MyDrawer.emp.role == 'Salesperson'
                          ? SizedBox(
                              width: MyScreen.getScreenWidth(context) *
                                  (228 / 294),
                              height: MyScreen.getScreenHeight(context) *
                                  (30 / 1063.6),
                              child: Text("Role: " + widget.emp.role!,
                                  style: TextStyle(
                                      color: MyDrawer.emp.darkTheme == 1
                                          ? MyColors.pewterBlue
                                          : MyColors.black,
                                      fontSize:
                                          MyScreen.getScreenHeight(context) *
                                              (20 / 1063.6))),
                            )
                          : SizedBox(
                              width: MyScreen.getScreenWidth(context) *
                                  (228 / 294),
                              height: MyScreen.getScreenHeight(context) *
                                  (30 / 1063.6),
                              child: Text("Select Role *",
                                  style: TextStyle(
                                      color: MyDrawer.emp.darkTheme == 1
                                          ? MyColors.pewterBlue
                                          : MyColors.black,
                                      fontSize:
                                          MyScreen.getScreenHeight(context) *
                                              (20 / 1063.6))),
                            ),
                      MyDrawer.emp.role == 'Admin'
                          ? Stack(children: [
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
                                width: MyScreen.getScreenWidth(context) *
                                    (228 / 294),
                                height: 54,
                                child: FormBuilderDropdown<String>(
                                  name: 'role',
                                  initialValue: widget.emp.role,
                                  validator: (value) {
                                    if (value.toString() ==
                                        "Select an Option") {
                                      return "Please select a role";
                                    }
                                    return null;
                                  },
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
                                    'Admin',
                                    'Salesperson',
                                    'Regional Manager',
                                    'Area Manager',
                                    'General Manager'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Center(
                                          child: Text(value,
                                              style: TextStyle(
                                                  color:
                                                      MyDrawer.emp.darkTheme ==
                                                              1
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
                            ])
                          : Container(),
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
                                child: Text("Update Profile",
                                    style: TextStyle(
                                        color: MyDrawer.emp.darkTheme == 1
                                            ? MyColors.richBlackFogra
                                            : MyColors.white,
                                        fontSize:
                                            MyScreen.getScreenHeight(context) *
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
        ));
  }
}
